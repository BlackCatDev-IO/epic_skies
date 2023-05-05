import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:epic_skies/core/image_repository.dart';
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
  BgImageBloc({ImageRepository? imageRepo})
      : _imageRepo = imageRepo ?? ImageRepository(),
        super(const BgImageState()) {
    on<BgImageInitDynamicSetting>(_onBgInitDynamicSetting);
    on<BgImageUpdateOnRefresh>(_onBgImageUpdateOnRefresh);
    on<BgImageSelectFromAppGallery>(_onBgImageSelectFromAppGallery);
    on<BgImageSelectFromDeviceGallery>(_onBgImageSelectFromDeviceGallery);
    on<BgImageFetchOnFirstInstall>(_onBgImageInitOnFirstInstall);
  }

  late bool _isDayCurrent;

  late String _currentCondition;

  final ImageRepository _imageRepo;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();

  Future<void> _onBgImageInitOnFirstInstall(
    BgImageFetchOnFirstInstall event,
    Emitter<BgImageState> emit,
  ) async {
    emit(state.copyWith(status: BgImageStatus.loading));

    try {
      final imageList = await _imageRepo.fetchFirebaseImages();
      emit(
        state.copyWith(
          bgImageList: imageList,
          status: BgImageStatus.loaded,
        ),
      );
    } catch (e) {
      _logBgImageBlocError(
        'BgImageFetchOnFirstInstall: $e',
        StackTrace.current,
      );

      emit(state.copyWith(status: BgImageStatus.error));
    }
  }

  Future<void> _onBgImageUpdateOnRefresh(
    BgImageUpdateOnRefresh event,
    Emitter<BgImageState> emit,
  ) async {
    if (state.imageSettings.isDynamic) {
      if (state.status.isError) {
        add(BgImageFetchOnFirstInstall());

        await stream
            .firstWhere((bgImageState) => !bgImageState.status.isLoading);

        if (state.status.isError) {
          return;
        }
      }

      final condition =
          event.weatherState.weatherModel!.currentCondition.conditions;

      _isDayCurrent = event.weatherState.isDay;

      _logBgImageBloc('isDay: $_isDayCurrent');

      var bgImage = '';

      _currentCondition = condition.toLowerCase();

      if (_currentCondition.contains('clear')) {
        return emit(
          state.copyWith(
            bgImagePath:
                _getWeatherImageFromCondition(type: WeatherImageType.clear),
          ),
        );
      }

      if (_currentCondition.contains('rain') ||
          _currentCondition.contains('drizzle')) {
        bgImage = _getWeatherImageFromCondition(type: WeatherImageType.rain);
        return emit(state.copyWith(bgImagePath: bgImage));
      }

      if (_currentCondition.contains('cloud') ||
          _currentCondition.contains('fog') ||
          _currentCondition.contains('overcast') ||
          _currentCondition.contains('wind')) {
        return emit(
          state.copyWith(
            bgImagePath:
                _getWeatherImageFromCondition(type: WeatherImageType.cloudy),
          ),
        );
      }

      if (_currentCondition.contains('snow') ||
          _currentCondition.contains('ice') ||
          _currentCondition.contains('hail') ||
          _currentCondition.contains('flurries')) {
        return emit(
          state.copyWith(
            bgImagePath:
                _getWeatherImageFromCondition(type: WeatherImageType.snow),
          ),
        );
      }

      if (_currentCondition.contains('storm')) {
        return emit(
          state.copyWith(
            bgImagePath:
                _getWeatherImageFromCondition(type: WeatherImageType.storm),
          ),
        );
      }
      _logBgImageBloc(
        'Unaccounted Weather Condition: $_currentCondition',
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

  Future<void> _onBgImageSelectFromDeviceGallery(
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
        filteredImageList = state.bgImageList
            .where(
              (image) =>
                  image.condition.isClear && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.cloudy:
        filteredImageList = state.bgImageList
            .where(
              (image) =>
                  image.condition.isCloudy && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.rain:
        filteredImageList = state.bgImageList
            .where(
              (image) => image.condition.isRain && image.isDay == true,
            )
            .toList();
        break;
      case WeatherImageType.snow:
        filteredImageList = state.bgImageList
            .where(
              (image) => image.condition.isSnow && image.isDay == _isDayCurrent,
            )
            .toList();
        break;
      case WeatherImageType.storm:
        filteredImageList = state.bgImageList
            .where(
              (image) => image.condition.isStorm && image.isDay == false,
            )
            .toList();
        break;
    }

    final tempUrlList =
        filteredImageList.map((imageModel) => imageModel.imageUrl).toList();

    if (tempUrlList.length > 1) {
      randomNumber = _random.nextInt(tempUrlList.length - 1);
    } else {
      randomNumber = 0;
    }

    if (tempUrlList.isEmpty) {
      _logBgImageBloc('No Image Found for WeatherImageModel: $type');
      throw Exception('No Image Found for WeatherImageModel: $type');
    }

    return tempUrlList[randomNumber];
  }

  void _logBgImageBloc(String message) {
    AppDebug.log(message, name: 'BgImageBloc');
  }

  void _logBgImageBlocError(String message, StackTrace stack) {
    AppDebug.logSentryError(message, name: 'BgImageBloc', stack: stack);
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
