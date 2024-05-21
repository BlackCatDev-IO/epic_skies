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

  WeatherState mockWeatherKitState([Map<String, dynamic>? weatherResponse]) {
    final weatherKit = Weather.fromMap(weatherResponse ?? nycWeatherKitMock);

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

    final now = weatherKit.currentWeather.asOf.add(offset);

    final stateWithRefTimes = weatherState.copyWith(
      refTimes: timezoneUtil.getReferenceTimesModel(
        weatherState: weatherState,
        nowFromApi: now,
      ),
    );

    return stateWithRefTimes.copyWith(
      alertModel: getAlertModelFromWeather(weatherState: stateWithRefTimes),
    );
  }

  WeatherState mockVisualCrossingState([
    Map<String, dynamic>? weatherResponse,
  ]) {
    final mockWeather = WeatherResponseModel.fromResponse(
      response: weatherResponse ?? nycVisualCrossingResponse,
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

    final now = DateTime.fromMillisecondsSinceEpoch(
      mockWeather.currentCondition.datetimeEpoch * 1000,
    ).toUtc().add(
          Duration(milliseconds: weatherState.refTimes.timezoneOffsetInMs),
        );

    return weatherState.copyWith(
      refTimes: timezoneUtil.getReferenceTimesModel(
        weatherState: weatherState,
        nowFromApi: now,
      ),
    );
  }
}
