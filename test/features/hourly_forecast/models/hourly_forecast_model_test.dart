import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late String hourlyCondition;
  late int index;
  late WeatherData data;
  late DateTime startTime;
  late MockWeatherRepo mockWeatherRepo;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late WeatherDataInitModel dataInitModel;
  late String iconPath;

  setUpAll(() async {
    mockStorage = MockStorageController();

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    dataInitModel = WeatherDataInitModel(
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.bronxWeather,
      model: dataInitModel,
    );

    startTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-08T16:43:20-05:00',
      searchIsLocal: true,
    );

    index = 0;

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.hourly].intervals[index].data;

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

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(iconPath: iconPath, data: data);

      final regularModel = HourlyForecastModel(
        temp: 63.73.round(),
        feelsLike: 63.73.round(),
        precipitationAmount: 0,
        windSpeed: 5.59.round(),
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
        speedUnit: data.unitSettings.speedInKph ? 'kph' : 'mph',
        condition: WeatherCodeConverter.getConditionFromWeatherCode(1000),
        precipUnit: data.unitSettings.precipInMm ? 'mm' : 'in',
        precipitationCode: 0,
        time: DateTimeFormatter.formatTimeToHour(
          time: startTime,
          timeIn24hrs: data.unitSettings.timeIn24Hrs,
        ),
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
        searchIsLocal: true,
        unitSettings: metricUnitSettings,
        oldSettings: unitSettings,
      );

      mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
        model: mockWeatherRepo.weatherModel!,
        data: dataInitModel,
      );

      data = mockWeatherRepo
          .weatherModel!.timelines[Timelines.hourly].intervals[index].data;

      iconPath = IconController.getIconImagePath(
        condition: hourlyCondition,
        temp: data.temperature,
        tempUnitsMetric: data.unitSettings.tempUnitsMetric,
        isDay: true,
      );

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(iconPath: iconPath, data: data);

      expect(modelFromResponse.precipitationAmount, 0.0);
      expect(modelFromResponse.temp, 18); // converted from 63.73 Fahrenheight
      expect(modelFromResponse.feelsLike, 18);
      expect(modelFromResponse.windSpeed, 10); // converted from 5.59 mph
      expect(modelFromResponse.time, '16:00'); // from 4 PM
    });
  });
}
