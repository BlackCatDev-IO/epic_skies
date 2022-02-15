import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
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
  late DateTime now;
  late String dailyCondition;
  late int index;
  late WeatherData data;
  late MockWeatherRepo mockWeatherRepo;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late MockCurrentWeatherController mockCurrentWeatherController;
  late MockHourlyForecastController mockHourlyForecastController;

  List<int> hourlyTempList = [];
  setUpAll(() async {
    mockStorage = MockStorageController();

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);

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

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);

    mockCurrentWeatherController =
        MockCurrentWeatherController(weatherRepository: mockWeatherRepo);
    mockHourlyForecastController = MockHourlyForecastController(
      weatherRepository: mockWeatherRepo,
      currentWeatherController: mockCurrentWeatherController,
    );

    Get.put(TimeZoneController(storage: mockStorage));

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromMap(
      map: MockWeatherResponse.bronxWeather,
      unitSettings: unitSettings,
    );

    Get.put(SunTimeController(storage: mockStorage))
        .initSunTimeList(weatherModel: mockWeatherRepo.weatherModel!);

    mockCurrentWeatherController.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );

    index = 0;

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.daily].intervals[index].data;

    now = mockCurrentWeatherController.currentTime;
    dailyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);

    /// Below setup is to init HourlyForecastController.to.minAndMaxTempList which
    /// the model builds min and max daily temp from. Also to
    ///  not have null returned from the isDay bools in storage
    for (int i = 0; i < 108; i++) {
      when(() => mockStorage.restoreForecastIsDay(index: i)).thenReturn(false);
    }
    mockHourlyForecastController.buildHourlyForecastModels();
  });

  num initPrecipAmount({
    num? precipIntensity,
  }) {
    final precip = precipIntensity ?? 0.0;

    return num.parse(precip.toStringAsFixed(2));
  }

  group('daily detail widget model test: ', () {
    test('dailyDetailWidgetModel.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: mockCurrentWeatherController.currentTime,
      );

      hourlyTempList = mockHourlyForecastController.minAndMaxTempList[index];

      final today = mockCurrentWeatherController.currentTime.weekday;

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: data,
        hourlyIndex: index,
        currentTime: mockCurrentWeatherController.currentTime,
        minAndMaxTempList: mockHourlyForecastController.minAndMaxTempList,
        hourlyKey: 'day_1',
      );

      final regularModel = DailyForecastModel(
        index: index,
        dailyTemp: 64.4.round(),
        feelsLikeDay: 64.4.round(),
        highTemp: hourlyTempList.last,
        lowTemp: hourlyTempList.first,
        precipitationAmount: initPrecipAmount(precipIntensity: 0),
        windSpeed: data.windSpeed,
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
        sunTime: SunTimeController.to.sunTimeList[index],
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

      mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
        model: mockWeatherRepo.weatherModel!,
        updatedSettings: metricUnitSettings,
        oldSettings: unitSettings,
      );

      SunTimeController.to.initSunTimeList(
        weatherModel: mockWeatherRepo.weatherModel!,
      );

      data = mockWeatherRepo
          .weatherModel!.timelines[Timelines.daily].intervals[index].data;

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: data,
        hourlyIndex: index,
        currentTime: mockCurrentWeatherController.currentTime,
        minAndMaxTempList: mockHourlyForecastController.minAndMaxTempList,
        hourlyKey: 'day_1',
      );

      final sunTime = SunTimeController.to.sunTimeList[index];

      expect(
        modelFromResponse.dailyTemp,
        18,
      ); // converted from 63.73 Fahrenheight
      expect(modelFromResponse.windSpeed, 16);
      expect(modelFromResponse.precipitationAmount, 0.0);
      expect(modelFromResponse.sunTime, sunTime);
    });

    test(
      'highTemp, lowTemp and extendedHourlyForecastKey return null when index is out of range of 0-3',
      () {
        index = 4;

        final modelFromResponse = DailyForecastModel.fromWeatherData(
          index: index,
          data: data,
          hourlyIndex: index,
          currentTime: mockCurrentWeatherController.currentTime,
          minAndMaxTempList: mockHourlyForecastController.minAndMaxTempList,
          hourlyKey: null,
        );

        expect(modelFromResponse.extendedHourlyForecastKey, null);
        expect(modelFromResponse.highTemp, null);
        expect(modelFromResponse.lowTemp, null);
      },
    );
  });
}
