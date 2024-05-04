import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

/// Generates mock weather state based on mock responses stored on Epic Skies
/// server for  testing & bug fixing
class MockWeatherService with AlertService {
  Future<WeatherState> getMockWeatherState({
    required WeatherRepository weatherRepo,
    required UnitSettings unitSettings,
    required String key,
  }) async {
    try {
      final timezoneUtil = getIt<TimeZoneUtil>();
      final (mockLocation, weather) = await weatherRepo.mockResponse(key);

      final coordinates = mockLocation.searchIsLocal
          ? mockLocation.localCoordinates
          : mockLocation.remoteLocationData.coordinates;

      timezoneUtil
        ..setTimeZoneOffset(
          coordinates: coordinates,
        )
        ..now = weather.currentWeather.asOf;

      final (suntimes, isDay) = timezoneUtil.getSuntimesAndIsDay(
        unitSettings: unitSettings,
        isWeatherKit: true,
        weather: weather,
      );

      final alert = getAlertModelFromWeather(weather);

      return WeatherState(
        status: WeatherStatus.success,
        weather: weather,
        refererenceSuntimes: suntimes,
        isDay: isDay,
        alertModel: alert,
      );
    } catch (error) {
      rethrow;
    }
  }
}
