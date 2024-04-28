import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';

void main() {
  late WeatherResponseModel weatherModel;
  late DateTime now;
  late String dailyCondition;
  late int index;
  late DailyData dailyData;
  late UnitSettings unitSettings;
  late SunTimesModel suntime;

  setUpAll(() async {
    getIt.registerSingleton<TimeZoneUtil>(TimeZoneUtil());
    unitSettings = const UnitSettings();

    weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    index = 0;

    dailyData = weatherModel.days[0];

    suntime = SunTimesModel.fromDailyData(
      data: dailyData,
      unitSettings: unitSettings,
      searchIsLocal: true,
    );

    now = DateTime.now();
    dailyCondition = dailyData.conditions;
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
        data: dailyData,
        currentTime: now,
        suntime: suntime,
        unitSettings: unitSettings,
        extendedHourlyList: [],
      );

      final expectedModel = DailyForecastModel(
        dailyTemp: 96,
        feelsLikeDay: 92,
        highTemp: 45,
        lowTemp: 24,
        precipitationAmount: 0.0,
        windSpeed: 6,
        precipitationProbability: 61,
        precipitationType: 'rain',
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 96,
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
        condition: 'Rain',
        suntime: suntime,
        precipIconPath: IconController.getPrecipIconPath(
          precipType: dailyData.preciptype![0]! as String,
        ),
        extendedHourlyList: [],
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
        data: dailyData,
        currentTime: now,
        suntime: suntime,
        unitSettings: metricUnitSettings,
        extendedHourlyList: [],
      );

      final regularModel = DailyForecastModel(
        dailyTemp: 35,
        feelsLikeDay: 33,
        highTemp: dailyData.tempmax?.round(),
        lowTemp: dailyData.tempmin?.round(),
        precipitationAmount: 0.3,
        windSpeed: 9,
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
        condition: 'Rain',
        suntime: suntime,
        precipIconPath: IconController.getPrecipIconPath(
          precipType: dailyData.preciptype![0]! as String,
        ),
        extendedHourlyList: [],
      );

      expect(regularModel, modelFromResponse);
    });
  });
}
