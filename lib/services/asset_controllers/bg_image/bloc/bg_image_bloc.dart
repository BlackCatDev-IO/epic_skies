import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bg_image_state.dart';
export 'bg_image_state.dart';

part 'bg_image_event.dart';

class BgImageBloc extends HydratedBloc<BgImageEvent, BgImageState> {
  BgImageBloc({
    required StorageController storage,
    required Map<String, List<String>> fileMap,
  })  : _storage = storage,
        super(BgImageState.initial(fileMap)) {
    on<BgImageInitDynamicSetting>(_onBgInitDynamicSetting);
    on<BgImageUpdateOnRefresh>(_onBgImageUpdateOnRefresh);
    on<BgImageSelectFromAppGallery>(_onBgImageSelectFromAppGallery);
    on<BgImageSelectFromDeviceGallery>(_onBgImageFromDeviceGallery);
  }
  final StorageController _storage;

  late bool _isDayCurrent;

  late String _currentCondition;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();

  Future<void> _onBgImageUpdateOnRefresh(
    BgImageUpdateOnRefresh event,
    Emitter<BgImageState> emit,
  ) async {
    if (state.imageSettings.isDynamic) {
      final condition =
          event.weatherState.weatherModel!.currentCondition!.condition;

      _isDayCurrent = event.weatherState.isDay;

      _logBgImageBloc('isDay: $_isDayCurrent');

      _storage.storeDayOrNight(isDay: _isDayCurrent);

      if (event.weatherState.searchIsLocal) {
        _storage.storeLocalIsDay(isDay: _isDayCurrent);
      }

      String bgImage = '';

      _currentCondition = condition.toLowerCase();
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

      if (bgImage == '') {
        bgImage = state.imageFileMap['clear_day']![0];

        /// This should never happen
        _logBgImageBloc(
          'Unaccounted Weather Condition: $_currentCondition',
        );
      }

      emit(
        state.copyWith(
          bgImagePath: bgImage,
        ),
      );
    }
  }

  Future<void> _onBgImageSelectFromAppGallery(
    BgImageSelectFromAppGallery event,
    Emitter<BgImageState> emit,
  ) async {
    emit(
      state.copyWith(
        bgImagePath: event.imageFile.path,
        imageSettings: ImageSettings.appGallery,
      ),
    );

    // _storage.storeBgImageAppGalleryPath(path: event.imageFile.path);

    // _storage.storeBgImageSettings(ImageSettings.appGallery);
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
        // _storage.storeDeviceImagePath(pickedFile.path);

        emit(
          state.copyWith(
            imageSettings: ImageSettings.deviceGallery,
            bgImagePath: imageFile.path,
          ),
        );

        // _storage.storeBgImageSettings(ImageSettings.deviceGallery);
      }
    } catch (error, stack) {
      _logBgImageBloc(
        '_onBgImageFromDeviceGallery ERROR: $error, stack: $stack',
      );
    }
  }

  Future<void> _onBgInitDynamicSetting(
    BgImageInitDynamicSetting event,
    Emitter<BgImageState> emit,
  ) async {
    emit(state.copyWith(imageSettings: ImageSettings.dynamic));

    add(BgImageUpdateOnRefresh(weatherState: event.weatherState));
  }

  /* ----------------------------- Utiliy Methods ----------------------------- */

  String _getWeatherImageFromCondition({required String condition}) {
    List<String> tempFileList = [];
    int randomNumber = 0;

    if (_isDayCurrent) {
      if (state.imageFileMap['${condition}_day']!.isNotEmpty) {
        tempFileList =
            state.imageFileMap['${condition}_day']!.map((e) => e).toList();
      } else {
        tempFileList =
            state.imageFileMap['${condition}_night']!.map((e) => e).toList();
      }
    } else {
      if (state.imageFileMap['${condition}_night']!.isNotEmpty) {
        tempFileList =
            state.imageFileMap['${condition}_night']!.map((e) => e).toList();
      } else {
        tempFileList =
            state.imageFileMap['${condition}_day']!.map((e) => e).toList();
      }
    }

    if (tempFileList.length > 1) {
      randomNumber = _random.nextInt(tempFileList.length - 1);
    } else {
      randomNumber = 0;
    }

    return tempFileList[randomNumber];
  }

  void _logBgImageBloc(String message) {
    AppDebug.log(message, name: 'BgImageBloc');
  }

  @override
  BgImageState? fromJson(Map<String, dynamic> json) {
    return BgImageState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BgImageState state) {
    return state.toJson();
  }
}
