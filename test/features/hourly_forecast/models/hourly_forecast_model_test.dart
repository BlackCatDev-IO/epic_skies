@Skip('Pending refactor update')
library;

import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/visual_crossing_mocks/visual_crossing_nyc_metric.dart';
import '../../main_weather/mock_weather_state.dart';

void main() {
  late String hourlyCondition;
  late int index;
  late HourlyData data;
  late DateTime startTime;
  late UnitSettings unitSettings;
  late String iconPath;
  late WeatherState weatherState;

  setUpAll(() async {
    weatherState =
        MockWeatherState().mockVisualCrossingState(nycVisualCrossingMetric);
    unitSettings = const UnitSettings();

    data = weatherState.weatherModel!.days[0].hours![12];

    startTime = DateTime.fromMillisecondsSinceEpoch(data.datetimeEpoch * 1000)
        .toUtc()
        .add(
          Duration(milliseconds: weatherState.refTimes.timezoneOffsetInMs),
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
    test('.fromVisualCrossing initializes as expected', () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: DateTime.now(),
      );

      final modelFromResponse = HourlyForecastModel.fromVisualCrossing(
        weatherState: weatherState,
        iconPath: iconPath,
        data: data,
      );

      final regularModel = HourlyForecastModel(
        temp: 69,
        feelsLike: 69,
        precipitationAmount: 0,
        windSpeed: 8,
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          condition: hourlyCondition,
          temp: 69,
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

      weatherState = weatherState.copyWith(
        unitSettings: metricUnitSettings,
      );

      iconPath = IconController.getIconImagePath(
        condition: hourlyCondition,
        temp: data.temp.round(),
        tempUnitsMetric: metricUnitSettings.tempUnitsMetric,
        isDay: true,
      );

      final modelFromResponse = HourlyForecastModel.fromVisualCrossing(
        weatherState: weatherState,
        iconPath: iconPath,
        data: data,
      );

      expect(modelFromResponse.precipitationAmount, 0.0);
      expect(modelFromResponse.temp, 21);
      expect(modelFromResponse.feelsLike, 21);
      expect(modelFromResponse.windSpeed, 12);
    });
  });
}
