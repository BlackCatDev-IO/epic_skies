import 'dart:async';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/search_local_weather_button_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
    try {
      emit(
        state.copyWith(
          status: WeatherStatus.loading,
          searchIsLocal: event.searchIsLocal,
        ),
      );

      final data = await _weatherRepository.fetchWeatherData(
        lat: event.lat,
        long: event.long,
      );

      final suntimes = TimeZoneUtil.initSunTimeList(
        weatherModel: data,
        searchIsLocal: event.searchIsLocal,
        unitSettings: state.unitSettings,
      );

      final isDay = TimeZoneUtil.getCurrentIsDay(
        searchIsLocal: state.searchIsLocal,
        refSuntimes: suntimes,
        refTimeEpochInSeconds: data.currentCondition.datetimeEpoch,
      );

      final searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
        model: data,
        unitSettings: state.unitSettings,
        isDay: _weatherRepository.restoreSavedIsDay(),
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weatherModel: data,
          searchButtonModel:
              event.searchIsLocal ? searchButtonModel : state.searchButtonModel,
          refererenceSuntimes: suntimes,
          isDay: isDay,
        ),
      );
    } on Exception catch (exception) {
      emit(
        WeatherState.error(
          exception: exception,
        ),
      );
      _logWeatherBloc('LocalWeatherUpdated error: $exception');
    } catch (error) {
      emit(
        WeatherState.error(
          exception: NetworkException(),
        ),
      );

      _logWeatherBloc('LocalWeatherUpdated error: $error');
    }
  }

  Future<void> _onWeatherUnitSettingsUpdate(
    WeatherUnitSettingsUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    final searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
      model: state.weatherModel!,
      unitSettings: event.unitSettings,
      isDay: _weatherRepository.restoreSavedIsDay(),
    );
    emit(
      state.copyWith(
        status: WeatherStatus.unitSettingsUpdate,
        unitSettings: event.unitSettings,
        searchButtonModel: searchButtonModel,
      ),
    );
  }

  void _logWeatherBloc(String message) {
    AppDebug.log(message, name: 'WeatherBloc');
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
