import 'dart:async';

import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/error_handling/failure_handler.dart';
import '../../../models/weather_response_models/weather_data_model.dart';
import '../../../services/settings/unit_settings/unit_settings_model.dart';
import '../../../services/ticker_controllers/tab_navigation_controller.dart';
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
    on<LocalWeatherUpdated>(_onLocalWeatherUpdated);
    on<RemoteWeatherUpdated>(_onRemoteWeatherUpdated);
    on<UnitSettingsUpdated>(_onUnitSettingsUpdated);
    on<RefreshWeatherData>(_onRefreshWeatherData);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onLocalWeatherUpdated(
    LocalWeatherUpdated event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final hasConnection = await InternetConnectionChecker().hasConnection;

      if (hasConnection) {
        emit(
          state.copyWith(status: WeatherStatus.loading, searchIsLocal: true),
        );

        _weatherRepository.storeSearchIsLocal(searchIsLocal: true);

        final data = await _weatherRepository.fetchLocalWeatherData();

        final searchButtonModel =
            SearchLocalWeatherButtonModel.fromWeatherModel(
          model: data!,
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
    } catch (error) {
      emit(state.copyWith(status: WeatherStatus.error));

      _logWeatherBloc('LocalWeatherUpdated error: $error');
      rethrow;
    }
  }

  Future<void> _onRemoteWeatherUpdated(
    RemoteWeatherUpdated event,
    Emitter<WeatherState> emit,
  ) async {
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      try {
        emit(
          state.copyWith(status: WeatherStatus.loading, searchIsLocal: false),
        );
        TabNavigationController.to.tabController.animateTo(0);

        final data = await _weatherRepository.fetchRemoteWeatherData(
          suggestion: event.searchSuggestion,
        );

        emit(state.copyWith(status: WeatherStatus.success, weatherModel: data));
      } catch (error) {
        emit(state.copyWith(status: WeatherStatus.error));

        _logWeatherBloc('LocalWeatherUpdated error: $error');
      }
    } else {
      FailureHandler.handleNoConnection(method: 'fetchRemoteWeatherData');
    }
  }

  Future<void> _onUnitSettingsUpdated(
    UnitSettingsUpdated event,
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

  Future<void> _onRefreshWeatherData(
    RefreshWeatherData event,
    Emitter<WeatherState> emit,
  ) async {
    if (state.searchIsLocal) {
      add(LocalWeatherUpdated());
    } else {
      final suggestion = _weatherRepository.restoreLatestSuggestion();
      add(RemoteWeatherUpdated(searchSuggestion: suggestion));
    }
  }

  @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    super.onTransition(transition);
    _logWeatherBloc('''
Transition: Event: ${transition.event} 
Current State: 
      ${transition.currentState} 
Next State: 
      ${transition.nextState} \n
''');
  }
}
