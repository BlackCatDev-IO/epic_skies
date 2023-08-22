import 'dart:async';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:timezone/timezone.dart';

export 'weather_state.dart';

part 'weather_event.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState()) {
    on<WeatherUpdate>(_onWeatherUpdate);
    on<WeatherUnitSettingsUpdate>(_onWeatherUnitSettingsUpdate);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onWeatherUpdate(
    WeatherUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    late WeatherResponseModel data;
    late Weather weather;
    try {
      emit(
        state.copyWith(
          status: WeatherStatus.loading,
          searchIsLocal: event.searchIsLocal,
        ),
      );

      final futures = [
        _weatherRepository.getWeatherKitData(
          lat: event.lat,
          long: event.long,
          timezone: event.timezone,
          countryCode: event.countryCode,
          languageCode: event.languageCode,
        ),
        _weatherRepository.getVisualCrossingData(
          lat: event.lat,
          long: event.long,
        ),
      ];

      final results = await Future.wait(futures);

      weather = results[0] as Weather;
      data = results[1] as WeatherResponseModel;

      // final suntimes = TimeZoneUtil.initSunTimeList(
      //   weatherModel: data,
      //   searchIsLocal: event.searchIsLocal,
      //   unitSettings: state.unitSettings,
      // );

      final weatherKitSuntimes = TimeZoneUtil.initSunTimeListFromWeatherKit(
        weather: weather,
        searchIsLocal: event.searchIsLocal,
        unitSettings: state.unitSettings,
      );

      final isDay = TimeZoneUtil.getCurrentIsDay(
        searchIsLocal: state.searchIsLocal,
        refSuntimes: weatherKitSuntimes,
        refTimeEpochInSeconds: data.currentCondition.datetimeEpoch,
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weatherModel: data,
          weather: weather,
          refererenceSuntimes: weatherKitSuntimes,
          isDay: isDay,
        ),
      );
    } on Exception catch (exception) {
      if (exception is LocationNotFoundException) {
        emit(
          state.copyWith(
            status: WeatherStatus.success,
            weatherModel: data,
          ),
        );
        rethrow; // send to Sentry
      }

      emit(
        state.copyWith(
          status: WeatherStatus.error,
          errorModel: ErrorModel.fromException(exception),
        ),
      );

      _logWeatherBloc('LocalWeatherUpdated error: $exception');
    } catch (error) {
      emit(
        state.copyWith(
          status: WeatherStatus.error,
          errorModel: ErrorModel.fromException(NetworkException()),
        ),
      );

      _logWeatherBloc('LocalWeatherUpdated error: $error');
    }
  }

  Future<void> _onWeatherUnitSettingsUpdate(
    WeatherUnitSettingsUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    emit(
      state.copyWith(
        status: WeatherStatus.unitSettingsUpdate,
        unitSettings: event.unitSettings,
      ),
    );
  }

  void _logWeatherBloc(String message) {
    AppDebug.log(message, name: 'WeatherBloc');
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toMap();
  }
}
