import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

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

      final (offset, timezone) =
          timezoneUtil.offsetAndTimezone(coordinates: coordinates);

      final updatedState = WeatherState(
        status: WeatherStatus.success,
        weather: weather,
        unitSettings: unitSettings,
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
        ),
        alertModel: alert,
      );
    } catch (error) {
      rethrow;
    }
  }
}
