import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';

void main() {
  late WeatherResponseModel weatherModel;
  late DateTime now;
  late String dailyCondition;
  late int index;
  late DailyData data;
  late UnitSettings unitSettings;
  late SunTimesModel suntime;

  setUpAll(() async {
    unitSettings = const UnitSettings(
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    index = 0;

    data = weatherModel.days[0];

    suntime = SunTimesModel.fromDailyData(
      data: data,
      unitSettings: unitSettings,
      searchIsLocal: true,
    );

    now = DateTime.now();
    dailyCondition = data.condition;
  });

  group('DailyForecastModel model test: ', () {
    test('dailyDetailWidgetModel.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: now,
      );

      final today = now.weekday;

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: data,
        currentTime: now,
        hourlyKey: 'day_1',
        suntime: suntime,
        unitSettings: unitSettings,
      );

      final expectedModel = DailyForecastModel(
        dailyTemp: 35,
        feelsLikeDay: 33,
        highTemp: 44,
        lowTemp: 24,
        precipitationAmount: 0.0,
        windSpeed: 9,
        precipitationProbability: 61,
        precipitationType: 'rain',
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 35,
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        day: DateTimeFormatter.getNext7Days(
          day: now.weekday + index,
          today: today,
        ),
        month: DateTimeFormatter.getNextDaysMonth(),
        year: DateTimeFormatter.getNextDaysYear(),
        date: DateTimeFormatter.getNextDaysDate(),
        condition: dailyCondition,
        tempUnit: 'F',
        speedUnit: 'mph',
        extendedHourlyForecastKey: 'day_1',
        suntime: suntime,
        precipUnit: 'in',
        precipIconPath: null,
      );

      expect(expectedModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      const metricUnitSettings = UnitSettings(
        timeIn24Hrs: true,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: data,
        currentTime: now,
        hourlyKey: 'day_1',
        suntime: suntime,
        unitSettings: metricUnitSettings,
      );

      final regularModel = DailyForecastModel(
        dailyTemp: UnitConverter.toCelcius(temp: 35),
        feelsLikeDay: UnitConverter.toCelcius(temp: 33),
        highTemp: data.tempMax,
        lowTemp: data.tempMin,
        precipitationAmount: 0.3,
        windSpeed: 14,
        precipitationProbability: 61,
        precipitationType: 'rain',
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 64.4.round(),
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        day: DateTimeFormatter.getNext7Days(
          day: now.weekday + index,
          today: now.weekday,
        ),
        month: DateTimeFormatter.getNextDaysMonth(),
        year: DateTimeFormatter.getNextDaysYear(),
        date: DateTimeFormatter.getNextDaysDate(),
        condition: dailyCondition,
        tempUnit: 'C',
        speedUnit: 'kph',
        extendedHourlyForecastKey: 'day_1',
        suntime: suntime,
        precipUnit: 'mm',
        precipIconPath: IconController.getPrecipIconPath(
          precipType: data.precipitationType![0]! as String,
        ),
      );

      expect(regularModel, modelFromResponse);
    });
  });
}
