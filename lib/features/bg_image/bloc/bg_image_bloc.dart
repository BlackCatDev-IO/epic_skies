import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:epic_skies/core/database/firestore_database.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_state.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';

import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

export 'bg_image_state.dart';

part 'bg_image_event.dart';

/// Manages all logic that determines which background image to display
class BgImageBloc extends HydratedBloc<BgImageEvent, BgImageState> {
  /// Requires initialized `fileMap` to be passed in for initial state on
  /// app start
  BgImageBloc({
    required StorageController storage,
  })  : _storage = storage,
        super(const BgImageState()) {
    on<BgImageFetchOnFirstInstall>(_onBgImageInitOnFirstInstall);
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

  Future<void> _onBgImageInitOnFirstInstall(
    BgImageFetchOnFirstInstall event,
    Emitter<BgImageState> emit,
  ) async {
    try {
      final imageList = await event.imageRepo.fetchFirebaseImages();
      emit(state.copyWith(imageList: imageList));
    } catch (e) {
      _logBgImageBloc('Error: $e');
    }
  }

  Future<void> _onBgImageUpdateOnRefresh(
    BgImageUpdateOnRefresh event,
    Emitter<BgImageState> emit,
  ) async {
    if (state.imageSettings.isDynamic) {
      final condition =
          event.weatherState.weatherModel!.currentCondition.conditions;

      _isDayCurrent = event.weatherState.isDay;

      _logBgImageBloc('isDay: $_isDayCurrent');

      _storage.storeDayOrNight(isDay: _isDayCurrent);

      var bgImage = '';

      _currentCondition = condition.toLowerCase();
      if (_currentCondition.contains('clear')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.clear);
      }

      if (_currentCondition.contains('cloud') ||
          _currentCondition.contains('fog') ||
          _currentCondition.contains('overcast') ||
          _currentCondition.contains('wind')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.cloudy);
      }

      if (_currentCondition.contains('rain') ||
          _currentCondition.contains('drizzle')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.rain);
      }

      if (_currentCondition.contains('snow') ||
          _currentCondition.contains('ice') ||
          _currentCondition.contains('hail') ||
          _currentCondition.contains('flurries')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.snow);
      }

      if (_currentCondition.contains('storm')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.storm);
      }

      /// This should never happen
      if (bgImage == '') {
        bgImage = state.bgImagePath;

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

        emit(
          state.copyWith(
            imageSettings: ImageSettings.deviceGallery,
            bgImagePath: imageFile.path,
          ),
        );
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

  String _getWeatherImageFromCondition({required WeatherImageType type}) {
    var filteredImageList = <WeatherImageModel>[];
    var randomNumber = 0;

    switch (type) {
      case WeatherImageType.clear:
        filteredImageList = state.imageList
            .where(
              (image) =>
                  image.condition.isClear && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.cloudy:
        filteredImageList = state.imageList
            .where(
              (image) =>
                  image.condition.isCloudy && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.rain:
        filteredImageList = state.imageList
            .where(
              (image) => image.condition.isRain && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.snow:
        filteredImageList = state.imageList
            .where(
              (image) => image.condition.isSnow && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.storm:
        filteredImageList = state.imageList
            .where(
              (image) =>
                  image.condition.isStorm && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
    }

    final tempUrlList = filteredImageList.map((e) => e.imageUrl).toList();

    if (tempUrlList.length > 1) {
      randomNumber = _random.nextInt(tempUrlList.length - 1);
    } else {
      randomNumber = 0;
    }

    return tempUrlList[randomNumber];
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
