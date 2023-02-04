import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';

Future<void> main() async {
  late String hourlyCondition;
  late int index;
  late HourlyData data;
  late DateTime startTime;
  late UnitSettings unitSettings;
  late String iconPath;
  late WeatherResponseModel weatherModel;

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

    data = weatherModel.days[0].hours![0];

    startTime = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.datetimeEpoch,
      searchIsLocal: true,
    );

    hourlyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);

    iconPath = IconController.getIconImagePath(
      condition: hourlyCondition,
      temp: 30,
      tempUnitsMetric: false,
      isDay: true,
    );
  });

  group('hourly vertical widget model test: ', () {
    test('HourlyVerticalWidgetModel.fromWeatherData initializes as expected',
        () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: DateTime.now(),
      );

      final modelFromResponse = HourlyVerticalWidgetModel.fromWeatherData(
        iconPath: iconPath,
        data: data,
        unitSettings: unitSettings,
        searchIsLocal: true,
      );

      final regularModel = HourlyVerticalWidgetModel(
        temp: 30,
        iconPath: IconController.getIconImagePath(
          condition: hourlyCondition,
          temp: 30,
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        precipitation: 0,
        time: DateTimeFormatter.formatTimeToHour(
          time: startTime,
          timeIn24hrs: unitSettings.timeIn24Hrs,
        ),
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

      data = weatherModel.days[0].hours![16];

      iconPath = IconController.getIconImagePath(
        condition: hourlyCondition,
        temp: data.temp.round(),
        tempUnitsMetric: metricUnitSettings.tempUnitsMetric,
        isDay: true,
      );

      final modelFromResponse = HourlyVerticalWidgetModel.fromWeatherData(
        iconPath: iconPath,
        data: data,
        unitSettings: metricUnitSettings,
        searchIsLocal: true,
      );

      expect(modelFromResponse.precipitation, 0);
      expect(modelFromResponse.temp, 7); // converted from 44 Fahrenheight
      expect(modelFromResponse.time, '16:00'); // from 4 PM
    });
  });
}
