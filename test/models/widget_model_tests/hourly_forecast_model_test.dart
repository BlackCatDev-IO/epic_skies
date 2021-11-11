import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/hourly_forecast_widget_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/weather_forecast/forecast_controllers.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../test_utils.dart';

Future<void> main() async {
  late Map settingsMap;
  late String hourlyCondition;
  late int index;
  late WeatherData hourlyValue;
  late DateTime startTime;

  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    Get.put(CurrentWeatherController());
    Get.put(TimeZoneController());
    Get.put(WeatherRepository());
    Get.put(HourlyForecastController());

    StorageController.to
        .storeWeatherData(map: MockWeatherResponse.bronxWeather);
    StorageController.to.storeTempUnitMetricSetting(setting: false);
    StorageController.to.storePrecipInMmSetting(setting: false);
    StorageController.to.storeTimeIn24HrsSetting(setting: false);
    StorageController.to.storeSpeedInKphSetting(setting: false);

    WeatherRepository.to.weatherModel =
        WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

    settingsMap = StorageController.to.settingsMap;

    startTime = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: '2021-11-08T16:43:20-05:00');

    CurrentWeatherController.to.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );

    index = 0;

    hourlyValue = WeatherRepository
        .to.weatherModel!.timelines[Timelines.hourly].intervals[index].data;

    hourlyCondition = WeatherCodeConverter.getConditionFromWeatherCode(1000);
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

  num _initWindSpeed({required num speed}) {
    final setting = settingsMap[speedInKphKey] as bool;
    num convertedSpeed =
        UnitConverter.convertFeetPerSecondToMph(feetPerSecond: speed);
    if (setting) {
      convertedSpeed = UnitConverter.convertMilesToKph(miles: convertedSpeed);
    }
    return convertedSpeed;
  }

  group('hourly forecast widget model test: ', () {
    test('HourlyForecastModel.fromWeatherData initializes as expected', () {
      DateTimeFormatter.initNextDay(index);

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(index: index, data: hourlyValue);

      final regularModel = HourlyForecastModel(
        temp: 63.73.round(),
        feelsLike: 63.73.round(),
        precipitationAmount:
            initPrecipAmount(precipIntensity: 0, precipInMm: false),
        windSpeed: _initWindSpeed(
          speed: 5.59,
        ),
        precipitationProbability: 0,
        precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
          code: 0,
        ),
        iconPath: IconController.getIconImagePath(
          hourly: false,
          condition: hourlyCondition,
        ),
        speedUnit: CurrentWeatherController.to.speedUnitString,
        condition: WeatherCodeConverter.getConditionFromWeatherCode(1000),
        precipUnit: CurrentWeatherController.to.precipUnitString,
        precipitationCode: 0,
        time: DateTimeFormatter.formatTimeToHour(time: startTime),
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      StorageController.to.storeTempUnitMetricSetting(setting: true);
      StorageController.to.storePrecipInMmSetting(setting: true);
      StorageController.to.storeTimeIn24HrsSetting(setting: true);
      StorageController.to.storeSpeedInKphSetting(setting: true);

      final modelFromResponse =
          HourlyForecastModel.fromWeatherData(index: index, data: hourlyValue);

      final tempInCelius =
          UnitConverter.toCelcius(temp: hourlyValue.temperature.round());

      final speedInKm = _initWindSpeed(
        speed: hourlyValue.windSpeed,
      );

      final precipInMm = UnitConverter.convertInchesToMillimeters(
        inches: hourlyValue.precipitationIntensity,
      );

      expect(modelFromResponse.precipitationAmount, precipInMm);
      expect(modelFromResponse.temp, tempInCelius);
      expect(modelFromResponse.windSpeed, speedInKm);
    });
  });
}
