@Skip('Pending refactor update')
library;

import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/visual_crossing_mock.dart';

void main() {
  late String hourlyCondition;
  late int index;
  late HourlyData data;
  late DateTime startTime;
  late UnitSettings unitSettings;
  late String iconPath;
  late WeatherResponseModel weatherModel;

  setUpAll(() async {
    unitSettings = const UnitSettings();

    weatherModel = WeatherResponseModel.fromResponse(
      response: nycVisualCrossingResponse,
    );

    data = weatherModel.days[0].hours![12];

    startTime = TimeZoneUtil().secondsFromEpoch(
      secondsSinceEpoch: data.datetimeEpoch,
    );

    index = 0;

    hourlyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);

    iconPath = IconController.getIconImagePath(
      condition: hourlyCondition,
      temp: 63.73.round(),
      tempUnitsMetric: false,
      isDay: true,
    );
  });

  group('hourly forecast model test: ', () {
    test('.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: DateTime.now(),
      );

      final modelFromResponse = HourlyForecastModel.fromWeatherData(
        iconPath: iconPath,
        data: data,
        unitSettings: unitSettings,
      );

      final regularModel = HourlyForecastModel(
        temp: 42,
        feelsLike: 38,
        precipitationAmount: 0,
        windSpeed: 7,
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          condition: hourlyCondition,
          temp: 63.73.round(),
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        condition: 'Partially cloudy',
        time: startTime,
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      const metricUnitSettings = UnitSettings(
        timeIn24Hrs: true,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      iconPath = IconController.getIconImagePath(
        condition: hourlyCondition,
        temp: data.temp.round(),
        tempUnitsMetric: metricUnitSettings.tempUnitsMetric,
        isDay: true,
      );

      final modelFromResponse = HourlyForecastModel.fromWeatherData(
        iconPath: iconPath,
        data: data,
        unitSettings: metricUnitSettings,
      );

      expect(modelFromResponse.precipitationAmount, 0.0);
      expect(modelFromResponse.temp, 6); // converted from 42 Fahrenheight
      expect(modelFromResponse.feelsLike, 3); // converted from 38 Fahrenheight
      expect(modelFromResponse.windSpeed, 13); // converted from 7 mph
      expect(modelFromResponse.time, '12:00'); // from 12 PM
    });
  });
}
