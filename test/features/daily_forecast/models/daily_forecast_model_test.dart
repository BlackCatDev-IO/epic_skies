import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_hourly_data.dart';
import '../../../mocks/mock_sun_time_data.dart';

void main() {
  late DateTime now;
  late String dailyCondition;
  late int index;
  late WeatherData data;
  late MockWeatherRepo mockWeatherRepo;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late WeatherDataInitModel dataInitModel;
  late SunTimesModel suntime;
  late List<int> hourlyTempList;
  late int? lowTemp;
  late int? highTemp;

  setUpAll(() async {
    mockStorage = MockStorageController();

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    hourlyTempList = MockHourlyData.minAndMaxTempList[0];
    hourlyTempList.sort();
    lowTemp = hourlyTempList.first;
    highTemp = hourlyTempList.last;
    suntime = MockSunTimeData.sunTime();

    dataInitModel = WeatherDataInitModel(
      timeZoneOffset: 0,
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.bronxWeather,
      model: dataInitModel,
    );

    index = 0;

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.daily].intervals[index].data;

    now = DateTime.now();
    dailyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);
  });

  num initPrecipAmount({
    num? precipIntensity,
  }) {
    final precip = precipIntensity ?? 0.0;

    return num.parse(precip.toStringAsFixed(2));
  }

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
        lowTemp: lowTemp,
        highTemp: highTemp,
        currentTime: now,
        hourlyKey: 'day_1',
        suntime: suntime,
      );

      final regularModel = DailyForecastModel(
        index: index,
        dailyTemp: 64.4.round(),
        feelsLikeDay: 64.4.round(),
        highTemp: hourlyTempList.last,
        lowTemp: hourlyTempList.first,
        precipitationAmount: initPrecipAmount(precipIntensity: 0),
        windSpeed: 10,
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 64.4.round(),
          tempUnitsMetric: unitSettings.tempUnitsMetric,
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

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      final metricUnitSettings = UnitSettings(
        id: 1,
        timeIn24Hrs: true,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      dataInitModel = WeatherDataInitModel(
        timeZoneOffset: 0,
        searchIsLocal: true,
        unitSettings: metricUnitSettings,
        oldSettings: unitSettings,
      );

      mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
        model: mockWeatherRepo.weatherModel!,
        data: dataInitModel,
      );

      lowTemp = UnitConverter.toCelcius(temp: lowTemp!);
      highTemp = UnitConverter.toCelcius(temp: highTemp!);

      data = mockWeatherRepo
          .weatherModel!.timelines[Timelines.daily].intervals[index].data;

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: data,
        lowTemp: lowTemp,
        highTemp: highTemp,
        currentTime: now,
        hourlyKey: 'day_1',
        suntime: suntime,
      );

      final regularModel = DailyForecastModel(
        index: index,
        dailyTemp: UnitConverter.toCelcius(temp: 64.4),
        feelsLikeDay: UnitConverter.toCelcius(temp: 64.4),
        highTemp: highTemp,
        lowTemp: lowTemp,
        precipitationAmount: initPrecipAmount(precipIntensity: 0),
        windSpeed: UnitConverter.convertMphToKph(mph: 10),
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 64.4.round(),
          tempUnitsMetric: unitSettings.tempUnitsMetric,
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
        precipIconPath: null,
      );

      expect(regularModel, modelFromResponse);
    });
  });
}
