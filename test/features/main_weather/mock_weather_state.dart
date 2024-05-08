import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';

import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/alerts/alert_service.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

import '../../mocks/visual_crossing_mock.dart';
import '../../mocks/weather_kit_mocks/weather_kit_mocks.dart';

class MockWeatherState with AlertService {
  final timezoneUtil = TimeZoneUtil();

  WeatherState mockWeatherKitState() {
    final weatherKit = Weather.fromMap(nycWeatherKitMock);

    final (offset, timezone) = timezoneUtil.offsetAndTimezone(
      coordinates: Coordinates(
        lat: weatherKit.currentWeather.metadata.latitude,
        long: weatherKit.currentWeather.metadata.longitude,
      ),
    );

    final weatherState = WeatherState(
      weather: weatherKit,
      status: WeatherStatus.success,
      refTimes: ReferenceTimesModel(
        timezoneOffsetInMs: offset.inMilliseconds,
        timezone: timezone,
      ),
    );

    final stateWithRefTimes = weatherState.copyWith(
      refTimes: timezoneUtil.getReferenceTimesModel(
        weatherState: weatherState,
      ),
    );

    return stateWithRefTimes.copyWith(
      alertModel: getAlertModelFromWeather(weatherState: stateWithRefTimes),
    );
  }

  WeatherState mockVisualCrossingState() {
    final mockWeather = WeatherResponseModel.fromResponse(
      response: nycVisualCrossingResponse,
    );

    final (offset, timezone) = timezoneUtil.offsetAndTimezone(
      coordinates: Coordinates(
        lat: mockWeather.latitude!,
        long: mockWeather.longitude!,
      ),
    );

    final weatherState = WeatherState(
      status: WeatherStatus.success,
      weatherModel: mockWeather,
      useBackupApi: true,
      refTimes: ReferenceTimesModel(
        timezoneOffsetInMs: offset.inMilliseconds,
        timezone: timezone,
      ),
    );

    return weatherState.copyWith(
      refTimes: timezoneUtil.getReferenceTimesModel(
        weatherState: weatherState,
      ),
    );
  }
}
