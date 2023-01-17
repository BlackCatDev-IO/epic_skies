import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ticker_controllers/tab_navigation_controller.dart';

part 'bg_image_event.dart';
part 'bg_image_state.dart';

class BgImageBloc extends Bloc<BgImageEvent, BgImageState> {
  BgImageBloc({
    required StorageController storage,
    required Map<String, List<File>> fileMap,
  })  : _storage = storage,
        super(BgImageState(imageFileMap: fileMap)) {
    on<BgImageInitFromStorage>(_onBgImageInitFromStorage);
    on<BgImageUpdateOnRefresh>(_onBgImageUpdateOnRefresh);
    on<BgImageSelectFromAppGallery>(_onBgImageSelectFromAppGallery);
    on<BgImageSelectFromDeviceGallery>(_onBgImageFromDeviceGallery);
    on<BgImageSettingsUpdated>(_onBgImageSettingsUpdated);
  }
  final StorageController _storage;

  late bool _isDayCurrent;

  late String _currentCondition;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();

  Future<void> _onBgImageInitFromStorage(
    BgImageInitFromStorage event,
    Emitter<BgImageState> emit,
  ) async {
    final storedImageSettings = _storage.restoreBgImageSettings();

    final imageFileList = <File>[];

    /// This is temporary until ImageGalleryController is refactored into a Cubit class
    final imageFileMap = state.imageFileMap;
    for (final fileList in imageFileMap.values) {
      for (final file in fileList) {
        imageFileList.add(file);
      }
    }

    String path = '';

    switch (storedImageSettings) {
      case ImageSettings.appGallery:
        path = _storage.restoreBgImageAppGalleryPath();
        break;
      case ImageSettings.deviceGallery:
        path = _storage.restoreDeviceImagePath()!;
        break;
      case ImageSettings.dynamic:
        path = _storage.restoreBgImageDynamicPath();
        break;
    }

    emit(
      state.copyWith(
        bgImage: FileImage(File(path)),
        imageSettings: storedImageSettings,
        imageFileList: imageFileList,
      ),
    );
  }

  Future<void> _onBgImageUpdateOnRefresh(
    BgImageUpdateOnRefresh event,
    Emitter<BgImageState> emit,
  ) async {
    final searchIsLocal = _storage.restoreSavedSearchIsLocal();

    _isDayCurrent = event.isDay;

    _logBgImageBloc('isDay: $_isDayCurrent');

    _storage.storeDayOrNight(isDay: _isDayCurrent);

    if (searchIsLocal) {
      _storage.storeLocalIsDay(isDay: _isDayCurrent);
    }

    late ImageProvider? bgImage;

    _currentCondition = event.condition.toLowerCase();
    if (_currentCondition.contains('clear')) {
      bgImage = _getWeatherImageFromCondition(condition: 'clear');
    }

    if (_currentCondition.contains('cloud') ||
        _currentCondition.contains('fog') ||
        _currentCondition.contains('overcast') ||
        _currentCondition.contains('wind')) {
      bgImage = _getWeatherImageFromCondition(condition: 'cloudy');
    }

    if (_currentCondition.contains('rain') ||
        _currentCondition.contains('drizzle')) {
      bgImage = _getWeatherImageFromCondition(condition: 'rain');
    }

    if (_currentCondition.contains('snow') ||
        _currentCondition.contains('ice') ||
        _currentCondition.contains('hail') ||
        _currentCondition.contains('flurries')) {
      bgImage = _getWeatherImageFromCondition(condition: 'snow');
    }

    if (_currentCondition.contains('storm')) {
      bgImage = _getWeatherImageFromCondition(condition: 'storm');
    }

    if (bgImage == null) {
      bgImage = FileImage(state.imageFileMap['clear_day']![0]);

      /// This should never happen
      _logBgImageBloc(
        'Unaccounted Weather Condition: $_currentCondition',
      );
    }

    emit(state.copyWith(bgImage: bgImage));
  }

  Future<void> _onBgImageSelectFromAppGallery(
    BgImageSelectFromAppGallery event,
    Emitter<BgImageState> emit,
  ) async {
    emit(
      state.copyWith(
        bgImage: FileImage(event.imageFile),
        imageSettings: ImageSettings.appGallery,
      ),
    );

    _storage.storeBgImageAppGalleryPath(path: event.imageFile.path);

    _storage.storeBgImageSettings(ImageSettings.appGallery);

    TabNavigationController.to.navigateToHome();
  }

  Future<void> _onBgImageFromDeviceGallery(
    BgImageSelectFromDeviceGallery event,
    Emitter<BgImageState> emit,
  ) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        _storage.storeDeviceImagePath(pickedFile.path);
        emit(
          state.copyWith(
            imageSettings: ImageSettings.deviceGallery,
            bgImage: FileImage(imageFile),
          ),
        );

        _storage.storeBgImageSettings(ImageSettings.deviceGallery);
      }
    } catch (error, stack) {
      _logBgImageBloc(
        '_onBgImageFromDeviceGallery ERROR: $error, stack: $stack',
      );
    }
  }

  Future<void> _onBgImageSettingsUpdated(
    BgImageSettingsUpdated event,
    Emitter<BgImageState> emit,
  ) async {
    final path = _storage.restoreBgImageDynamicPath();
    emit(
      state.copyWith(
        imageSettings: event.imageSetting,
        bgImage: FileImage(File(path)),
      ),
    );
    _storage.storeBgImageSettings(event.imageSetting);
  }

  /* ----------------------------- Utiliy Methods ----------------------------- */

  ImageProvider _getWeatherImageFromCondition({required String condition}) {
    List<File> tempFileList = [];
    int randomNumber = 0;

    if (_isDayCurrent) {
      if (state.imageFileMap['${condition}_day']!.isNotEmpty) {
        tempFileList = state.imageFileMap['${condition}_day']!;
      } else {
        tempFileList = state.imageFileMap['${condition}_night']!;
      }
    } else {
      if (state.imageFileMap['${condition}_night']!.isNotEmpty) {
        tempFileList = state.imageFileMap['${condition}_night']!;
      } else {
        tempFileList = state.imageFileMap['${condition}_day']!;
      }
    }

    if (tempFileList.length > 1) {
      randomNumber = _random.nextInt(tempFileList.length - 1);
    } else {
      randomNumber = 0;
    }

    return FileImage(tempFileList[randomNumber]);
  }

  void _logBgImageBloc(String message) {
    AppDebug.log(message, name: 'BgImageBloc');
  }
}
