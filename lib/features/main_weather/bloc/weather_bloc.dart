import 'dart:async';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:timezone/timezone.dart';

export 'weather_state.dart';

part 'weather_event.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState>
    with AlertService {
  WeatherBloc({
    required WeatherRepository weatherRepository,
    TimeZoneUtil? timeZoneUtil,
  })  : _weatherRepository = weatherRepository,
        _timezoneUtil = timeZoneUtil ?? TimeZoneUtil(),
        super(const WeatherState()) {
    on<WeatherUpdate>(_onWeatherUpdate);
    on<WeatherBackupRequest>(_onWeatherBackupRequest);
    on<WeatherUnitSettingsUpdate>(_onWeatherUnitSettingsUpdate);
  }

  final WeatherRepository _weatherRepository;
  final TimeZoneUtil _timezoneUtil;

  Future<void> _onWeatherUpdate(
    WeatherUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    late Weather weather;
    final locationState = event.locationState;
    emit(
      state.copyWith(
        status: WeatherStatus.loading,
        searchIsLocal: locationState.searchIsLocal,
      ),
    );

    final (coordinates, countryCode, languageCode) =
        _getLocationRequestInfo(locationState);

    final (offset, timezone) =
        _timezoneUtil.offsetAndTimezone(coordinates: coordinates);

    /// For testing with mock responses stored on Epic Skies server
    // if (kDebugMode) {
    //  final mockWeatherState = await MockWeatherService().getMockWeatherState(
    //     weatherRepo: _weatherRepository,
    //     unitSettings: state.unitSettings,
    //     timezoneOffset: offset,
    //     key: 'missingSunTimes',
    //   );
    //   return emit(mockWeatherState);
    // }

    try {
      final futures = [
        _weatherRepository.getWeatherKitData(
          coordinates: coordinates,
          timezone: timezone,
          countryCode: countryCode,
          languageCode: languageCode,
        ),
        // _weatherRepository.getVisualCrossingData(
        //   lat: event.lat,
        //   long: event.long,
        // ),
      ];

      final results = await Future.wait(futures);

      weather = results.first;

      final updatedState = state.copyWith(
        status: WeatherStatus.success,
        weather: weather,
        useBackupApi: false,
        refTimes: ReferenceTimesModel(
          timezoneOffsetInMs: offset.inMilliseconds,
          timezone: timezone,
        ),
      );

      final stateWithRefTimes = updatedState.copyWith(
        refTimes: _timezoneUtil.getReferenceTimesModel(
          weatherState: updatedState,
        ),
      );

      final alert = getAlertModelFromWeather(weatherState: stateWithRefTimes);

      emit(
        stateWithRefTimes.copyWith(
          alertModel: alert,
        ),
      );
    } on WeatherKitFailureException {
      add(WeatherBackupRequest(locationState: locationState));
      rethrow;
    } on LocationNotFoundException {
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
      rethrow;
    } on EpicSkiesApiException {
      rethrow;
    } on Exception catch (exception) {
      emit(
        state.copyWith(
          status: WeatherStatus.error,
          errorModel: ErrorModel.fromException(exception),
        ),
      );

      _logWeatherBloc('LocalWeatherUpdated error: $exception');
      rethrow;
    } catch (error) {
      emit(
        state.copyWith(
          status: WeatherStatus.error,
          errorModel: ErrorModel.fromException(NetworkException()),
        ),
      );

      _logWeatherBloc('LocalWeatherUpdated error: $error');
      rethrow; // send to Sentry
    }
  }

  (Coordinates, String, String) _getLocationRequestInfo(
    LocationState locationState,
  ) {
    if (locationState.searchIsLocal) {
      return (
        locationState.localCoordinates,
        locationState.countryCode ?? '',
        locationState.languageCode ?? ''
      );
    }

    return (
      locationState.remoteLocationData.coordinates,
      locationState.remoteLocationData.country,
      locationState.languageCode ?? ''
    );
  }

  Future<void> _onWeatherBackupRequest(
    WeatherBackupRequest event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final coordinates = event.locationState.searchIsLocal
          ? event.locationState.localCoordinates
          : event.locationState.remoteLocationData.coordinates;

      final weatherModel = await _weatherRepository.getVisualCrossingData(
        coordinates: coordinates,
      );

      final (offset, timezone) =
          _timezoneUtil.offsetAndTimezone(coordinates: coordinates);

      final updatedState = state.copyWith(
        status: WeatherStatus.success,
        weatherModel: weatherModel,
        useBackupApi: true,
        alertModel: const AlertModel.none(),
        refTimes: ReferenceTimesModel(
          timezoneOffsetInMs: offset.inMilliseconds,
          timezone: timezone,
        ),
      );

      emit(
        updatedState.copyWith(
          refTimes: _timezoneUtil.getReferenceTimesModel(
            weatherState: updatedState,
          ),
        ),
      );
    } on Exception catch (exception) {
      emit(
        state.copyWith(
          status: WeatherStatus.error,
          errorModel: ErrorModel.fromException(exception),
        ),
      );
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
    final noAlertState = state.copyWith(
      alertModel: const AlertModel.none(),
    );

    return noAlertState.toMap();
  }
}
