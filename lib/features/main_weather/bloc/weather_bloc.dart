import 'dart:async';

import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../models/weather_response_models/weather_data_model.dart';
import '../../../services/settings/unit_settings/unit_settings_model.dart';
import '../../../utils/logging/app_debug_log.dart';
import '../model/search_local_weather_button_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
    required UnitSettings unitSettings,
    WeatherResponseModel? weatherModel,
  })  : _weatherRepository = weatherRepository,
        super(
          WeatherState(
            status: weatherModel == null
                ? WeatherStatus.initial
                : WeatherStatus.success,
            weatherModel: weatherModel,
            unitSettings: unitSettings,
          ),
        ) {
    on<WeatherUpdate>(_onWeatherUpdate);
    // on<WeatherUpdateRemote>(_onWeatherUpdateRemote);
    on<WeatherUnitSettingsUpdate>(_onWeatherUnitSettingsUpdate);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onWeatherUpdate(
    WeatherUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final hasConnection = await InternetConnectionChecker().hasConnection;

      if (hasConnection) {
        emit(
          state.copyWith(
            status: WeatherStatus.loading,
            searchIsLocal: event.searchIsLocal,
          ),
        );

        _weatherRepository.storeSearchIsLocal(
          searchIsLocal: event.searchIsLocal,
        );

        final data = await _weatherRepository.fetchWeatherData(
          lat: event.lat,
          long: event.long,
        );

        if (data != null) {
          final searchButtonModel =
              SearchLocalWeatherButtonModel.fromWeatherModel(
            model: data,
            unitSettings: state.unitSettings,
            isDay: _weatherRepository.restoreSavedIsDay(),
          );

          emit(
            state.copyWith(
              status: WeatherStatus.success,
              weatherModel: data,
              searchButtonModel: searchButtonModel,
            ),
          );
        } else {
          emit(state.copyWith(status: WeatherStatus.error));
        }
      } else {
        emit(state.copyWith(status: WeatherStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: WeatherStatus.error));

      _logWeatherBloc('LocalWeatherUpdated error: $error');
      rethrow;
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
    _weatherRepository.storeUnitSettings(event.unitSettings);
  }

  void _logWeatherBloc(String message) {
    AppDebug.log(message, name: 'WeatherBloc');
  }
}
