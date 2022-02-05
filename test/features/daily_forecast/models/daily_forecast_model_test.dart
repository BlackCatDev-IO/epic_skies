import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:epic_skies/utils/storage_getters/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../test_utils.dart';

Future<void> main() async {
  late DateTime now;
  late String dailyCondition;
  late int index;
  late WeatherData dailyValue;
  late WeatherRepository mockWeatherRepo;

  List<int> hourlyTempList = [];
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    mockWeatherRepo = WeatherRepository();

    Get.put(StorageController());
    await StorageController.to
        .initAllStorage(path: 'daily_forecast_model_test');
    Get.put(CurrentWeatherController(weatherRepository: mockWeatherRepo));
    Get.put(TimeZoneController());
    Get.put(WeatherRepository());
    Get.put(HourlyForecastController(weatherRepository: mockWeatherRepo));

    StorageController.to
        .storeWeatherData(map: MockWeatherResponse.bronxWeather);
    StorageController.to.storeTempUnitMetricSetting(setting: false);
    StorageController.to.storePrecipInMmSetting(setting: false);
    StorageController.to.storeTimeIn24HrsSetting(setting: false);
    StorageController.to.storeSpeedInKphSetting(setting: false);

    mockWeatherRepo.weatherModel =
        WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

    WeatherRepository.to.weatherModel =
        WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

    Get.put(SunTimeController()).initSunTimeList();

    CurrentWeatherController.to.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );
    
    index = 0;

    dailyValue = WeatherRepository
        .to.weatherModel!.timelines[Timelines.daily].intervals[index].data;

    now = CurrentWeatherController.to.currentTime;
    dailyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);

    /// Below setup is to init HourlyForecastController.to.minAndMaxTempList which
    /// the model builds min and max daily temp from. Also to
    ///  not have null returned from the isDay bools in storage
    for (int i = 0; i < 108; i++) {
      StorageController.to.storeForecastIsDay(isDay: false, index: i);
    }
    HourlyForecastController.to.buildHourlyForecastModels();
  });

  num initPrecipAmount({
    num? precipIntensity,
    required bool precipInMm,
  }) {
    final precip = precipIntensity ?? 0.0;
    num convertedPrecip = num.parse(precip.toStringAsFixed(2));
    if (precipInMm) {
      convertedPrecip = UnitConverter.convertInchesToMillimeters(
        inches: convertedPrecip,
      );
    }
    return convertedPrecip;
  }

  int initWindSpeed({required num speed}) {
    if (Settings.speedInKph) {
      return UnitConverter.convertMilesToKph(miles: speed);
    } else {
      return UnitConverter.convertFeetPerSecondToMph(feetPerSecond: speed)
          .round();
    }
  }

  group('daily detail widget model test: ', () {
    test('dailyDetailWidgetModel.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(index);

      hourlyTempList = HourlyForecastController.to.minAndMaxTempList[index];

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: dailyValue,
        hourlyIndex: index,
      );

      final regularModel = DailyForecastModel(
        index: index,
        dailyTemp: 64.4.round(),
        feelsLikeDay: 64.4.round(),
        highTemp: hourlyTempList.last,
        lowTemp: hourlyTempList.first,
        precipitationAmount:
            initPrecipAmount(precipIntensity: 0, precipInMm: false),
        windSpeed: initWindSpeed(
          speed: 10.76,
        ),
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 64.4.round(),
        ),
        day: DateTimeFormatter.getNext7Days(now.weekday + index),
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
      StorageController.to.storeTempUnitMetricSetting(setting: true);
      StorageController.to.storePrecipInMmSetting(setting: true);
      StorageController.to.storeTimeIn24HrsSetting(setting: true);
      StorageController.to.storeSpeedInKphSetting(setting: true);
      SunTimeController.to.initSunTimeList();

      final modelFromResponse = DailyForecastModel.fromWeatherData(
        index: index,
        data: dailyValue,
        hourlyIndex: index,
      );
      final tempInCelius =
          UnitConverter.toCelcius(temp: dailyValue.temperature);
      final speedInKm =
          UnitConverter.convertMilesToKph(miles: dailyValue.windSpeed);
      final precipInMm = UnitConverter.convertInchesToMillimeters(
        inches: dailyValue.precipitationIntensity,
      );
      final sunTime = SunTimeController.to.sunTimeList[index];

      expect(modelFromResponse.dailyTemp, tempInCelius);
      expect(modelFromResponse.windSpeed, speedInKm);
      expect(modelFromResponse.precipitationAmount, precipInMm);
      expect(modelFromResponse.sunTime, sunTime);
    });

    test(
      'index out of HourlyForecastController.to.minAndMaxTempList range returns null extendedHourlyForecastKey, highTemp and lowTemp',
      () {
        index = 4;

        final modelFromResponse = DailyForecastModel.fromWeatherData(
          index: index,
          data: dailyValue,
          hourlyIndex: index,
        );

        expect(modelFromResponse.extendedHourlyForecastKey, null);
        expect(modelFromResponse.highTemp, null);
        expect(modelFromResponse.lowTemp, null);
      },
    );
  });
}
