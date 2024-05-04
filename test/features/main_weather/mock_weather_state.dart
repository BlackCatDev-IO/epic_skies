import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

import '../../mocks/visual_crossing_mock.dart';
import '../../mocks/weather_kit_mocks/weather_kit_mocks.dart';

WeatherState mockVisualCrossingState() {
  const unitSettings = UnitSettings();

  final mockWeatherModel = WeatherResponseModel.fromResponse(
    response: nycVisualCrossingResponse,
  );

  final suntimeList = TimeZoneUtil().initSunTimeList(
    weatherModel: mockWeatherModel,
    unitSettings: unitSettings,
  );

  final isDay = TimeZoneUtil().getCurrentIsDay(
    refSuntimes: suntimeList,
    refTimeEpochInSeconds: mockWeatherModel.currentCondition.datetimeEpoch,
  );

  return WeatherState(
    weatherModel: mockWeatherModel,
    status: WeatherStatus.success,
    refererenceSuntimes: suntimeList,
    isDay: isDay,
  );
}

WeatherState mockWeatherKitState() {
  const unitSettings = UnitSettings();

  final mockWeather = Weather.fromMap(nycWeatherKitMock);

  final suntimeList = TimeZoneUtil().initSunTimeListFromWeatherKit(
    weather: mockWeather,
    unitSettings: unitSettings,
  );

  final isDay = TimeZoneUtil().getCurrentIsDayFromWeatherKit(
    refSuntimes: suntimeList,
    referenceTime: mockWeather.currentWeather.asOf,
  );

  return WeatherState(
    weather: mockWeather,
    status: WeatherStatus.success,
    refererenceSuntimes: suntimeList,
    isDay: isDay,
  );
}
