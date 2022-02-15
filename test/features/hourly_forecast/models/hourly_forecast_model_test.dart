import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_storage_return_values.dart';
import '../../../mocks/mock_sun_time_data.dart';

void main() {
  late String hourlyCondition;
  late int index;
  late WeatherData data;
  late DateTime startTime;
  late MockWeatherRepo mockWeatherRepo;
  late MockStorageController mockStorage;
  late MockCurrentWeatherController mockCurrentWeatherController;
  late UnitSettings unitSettings;

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

    mockCurrentWeatherController =
        MockCurrentWeatherController(weatherRepository: mockWeatherRepo);

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreTimezoneOffset()).thenReturn(4);
    when(() => mockStorage.restoreTodayData())
        .thenReturn(MockStorageReturns.todayData);
    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);
    when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(true);
    when(() => mockStorage.restoreSunTimeList())
        .thenReturn(MockSunTimeData.data);
    when(() => mockStorage.restoreWeatherData())
        .thenReturn(MockWeatherResponse.bronxWeather);

    Get.put(TimeZoneController(storage: mockStorage));

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromMap(
      map: MockWeatherResponse.bronxWeather,
      unitSettings: unitSettings,
    );

    startTime = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: '2021-11-08T16:43:20-05:00');

    mockCurrentWeatherController.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );

    index = 0;

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.hourly].intervals[index].data;

    hourlyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);
  });

  group('hourly forecast model test: ', () {
    test('.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: mockCurrentWeatherController.currentTime,
      );

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(index: index, data: data);

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

      mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
        model: mockWeatherRepo.weatherModel!,
        updatedSettings: metricUnitSettings,
        oldSettings: unitSettings,
      );

      data = mockWeatherRepo
          .weatherModel!.timelines[Timelines.hourly].intervals[index].data;

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(index: index, data: data);

      expect(modelFromResponse.precipitationAmount, 0.0);
      expect(modelFromResponse.temp, 18); // converted from 63.73 Fahrenheight
      expect(modelFromResponse.feelsLike, 18);
      expect(modelFromResponse.windSpeed, 10); // converted from 5.59 mph
      expect(modelFromResponse.time, '16:00'); // from 4 PM
    });
  });
}
