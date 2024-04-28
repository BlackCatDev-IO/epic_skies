import 'dart:async';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/services/register_services.dart';
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
        _timezoneUtil = timeZoneUtil ?? getIt<TimeZoneUtil>(),
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
    // late WeatherResponseModel data;
    late Weather weather;
    final locationState = event.locationState;
    emit(
      state.copyWith(
        status: WeatherStatus.loading,
        searchIsLocal: locationState.searchIsLocal,
      ),
    );

    final coordinates = locationState.searchIsLocal
        ? locationState.localCoordinates
        : locationState.remoteLocationData.coordinates;

    try {
      _timezoneUtil.setTimeZoneOffset(
        coordinates: coordinates,
      );

      final futures = [
        _weatherRepository.getWeatherKitData(
          coordinates: coordinates,
          timezone: _timezoneUtil.timezone,
          countryCode: locationState.countryCode,
          languageCode: locationState.languageCode,
        ),
        // _weatherRepository.getVisualCrossingData(
        //   lat: event.lat,
        //   long: event.long,
        // ),
      ];

      final results = await Future.wait(futures);

      weather = results[0];
      // data = results[1] as WeatherResponseModel;

      final (suntimes, isDay) = _getSuntimesAndIsDay(
        searchIsLocal: locationState.searchIsLocal,
        isWeatherKit: true,
        weather: weather,
      );

      final alert = getAlertModelFromWeather(weather);

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          refererenceSuntimes: suntimes,
          isDay: isDay,
          useBackupApi: false,
          alertModel: alert,
        ),
      );

      if (alert != const AlertModel.none()) {
        await _weatherRepository.recordWeatherAlert(
          weather: weather,
          alert: alert,
        );
      }
    } on WeatherKitFailureException {
      add(
        WeatherBackupRequest(
          coordinates: coordinates,
          searchIsLocal: locationState.searchIsLocal,
        ),
      );
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

  Future<void> _onWeatherBackupRequest(
    WeatherBackupRequest event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final weatherModel = await _weatherRepository.getVisualCrossingData(
        coordinates: event.coordinates,
      );

      final (suntimes, isDay) = _getSuntimesAndIsDay(
        searchIsLocal: event.searchIsLocal,
        isWeatherKit: false,
        weatherModel: weatherModel,
      );

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weatherModel: weatherModel,
          refererenceSuntimes: suntimes,
          isDay: isDay,
          useBackupApi: true,
          alertModel: const AlertModel.none(),
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

  (List<SunTimesModel>, bool) _getSuntimesAndIsDay({
    required bool searchIsLocal,
    required bool isWeatherKit,
    WeatherResponseModel? weatherModel,
    Weather? weather,
  }) {
    late List<SunTimesModel> suntimesList;
    late bool isDay;

    if (isWeatherKit) {
      suntimesList = _timezoneUtil.initSunTimeListFromWeatherKit(
        weather: weather!,
        searchIsLocal: searchIsLocal,
        unitSettings: state.unitSettings,
      );

      isDay = _timezoneUtil.getCurrentIsDayFromWeatherKit(
        searchIsLocal: searchIsLocal,
        refSuntimes: suntimesList,
        referenceTime: weather.currentWeather.asOf,
      );
    } else {
      suntimesList = _timezoneUtil.initSunTimeList(
        weatherModel: weatherModel!,
        searchIsLocal: searchIsLocal,
        unitSettings: state.unitSettings,
      );

      isDay = _timezoneUtil.getCurrentIsDay(
        searchIsLocal: searchIsLocal,
        refSuntimes: suntimesList,
        refTimeEpochInSeconds: weatherModel.currentCondition.datetimeEpoch,
      );
    }

    return (suntimesList, isDay);
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
