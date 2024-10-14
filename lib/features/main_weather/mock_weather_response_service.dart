import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

/// Keys used to retrieve mock responses from Epic Skies server
class MockResponseKeys {
  static const rangeError = 'rangeError';
  static const missingSunTimes = 'missingSunTimes';
  static const visualCrossingOffest = 'visualCrossingOffest';
  static const missingSunTimes2 = 'missingSunTimes2';
  static const thunderstorm = 'thunderstorm';
  static const nyMostlyClear = 'nyMostlyClear';
  static const clear = 'clear';
  static const coolRainRochester = 'coolRainRochester';
  static const belowFreezingRussia = 'belowFreezingRussia';
}

/// Generates mock weather state based on mock responses stored on Epic Skies
/// server for  testing & bug fixing
class MockWeatherService with AlertService {
  Future<WeatherState> getMockWeatherState({
    required WeatherRepository weatherRepo,
    required UnitSettings unitSettings,
    required String key,
    required Duration timezoneOffset,
  }) async {
    try {
      final timezoneUtil = TimeZoneUtil();
      final (mockLocation, weather) = await weatherRepo.mockResponse(key);

      final coordinates = mockLocation.searchIsLocal
          ? mockLocation.localCoordinates
          : mockLocation.remoteLocationData.coordinates;

      final (offset, timezone) = timezoneUtil.offsetAndTimezone(
        coordinates: coordinates,
      );

      final updatedState = WeatherState(
        status: WeatherStatus.success,
        weather: weather,
        unitSettings: unitSettings,
        searchIsLocal: mockLocation.searchIsLocal,
        refTimes: ReferenceTimesModel(
          timezoneOffsetInMs: offset.inMilliseconds,
          timezone: timezone,
        ),
      );

      final alert = getAlertModelFromWeather(
        weatherState: updatedState,
      );

      return updatedState.copyWith(
        refTimes: timezoneUtil.getReferenceTimesModel(
          weatherState: updatedState,
          nowFromApi: weather.currentWeather.asOf.add(offset),
        ),
        alertModel: alert,
      );
    } catch (error) {
      rethrow;
    }
  }
}
