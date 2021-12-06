import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../test_utils.dart';

Future<void> main() async {
  late WeatherData weatherData;
  late int windSpeed;
  late String condition;

  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    Get.put(CurrentWeatherController());
    Get.put(TimeZoneController());
    Get.put(WeatherRepository());

    StorageController.to
        .storeWeatherData(map: MockWeatherResponse.bronxWeather);
    StorageController.to.storeTempUnitMetricSetting(setting: false);
    StorageController.to.storePrecipInMmSetting(setting: false);
    StorageController.to.storeTimeIn24HrsSetting(setting: false);
    StorageController.to.storeSpeedInKphSetting(setting: false);

    WeatherRepository.to.weatherModel =
        WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

    Get.put(SunTimeController()).initSunTimeList();

    CurrentWeatherController.to.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );

    weatherData = WeatherRepository
        .to.weatherModel!.timelines[Timelines.current].intervals[0].data;
    windSpeed = UnitConverter.convertFeetPerSecondToMph(
      feetPerSecond: weatherData.windSpeed,
    ).round();

    condition = WeatherCodeConverter.getConditionFromWeatherCode(
      weatherData.weatherCode,
    );
  });

  group('CurrentWeatherModel test: ', () {
    test('CurrentWeatherModel.fromWeatherData initializes as expected', () {
      final modelFromResponse = CurrentWeatherModel.fromWeatherData(
        data: weatherData,
      );

      final regularModel = CurrentWeatherModel(
        temp: 64,
        feelsLike: 64,
        windSpeed: windSpeed,
        condition: condition,
        tempUnit: 'F',
        speedUnit: 'mph',
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      StorageController.to.storeTempUnitMetricSetting(setting: true);
      StorageController.to.storePrecipInMmSetting(setting: true);
      StorageController.to.storeTimeIn24HrsSetting(setting: true);
      StorageController.to.storeSpeedInKphSetting(setting: true);
      SunTimeController.to.initSunTimeList();

      final modelFromResponse = CurrentWeatherModel.fromWeatherData(
        data: weatherData,
      );
      final tempInCelius =
          UnitConverter.toCelcius(temp: weatherData.temperature);
      final speedInKm = UnitConverter.convertMilesToKph(miles: windSpeed);

      expect(modelFromResponse.temp, tempInCelius);
      expect(modelFromResponse.windSpeed, speedInKm);
    });

    test(
      'conditon gets updated to non snowy condition when weatherCode returns a snowy condition in above freezing temps',
      () {
        WeatherRepository.to.weatherModel =
            WeatherResponseModel.fromMap(MockWeatherResponse.falseSnowResponse);

        weatherData = WeatherRepository
            .to.weatherModel!.timelines[Timelines.current].intervals[0].data;

        final modelFromResponse = CurrentWeatherModel.fromWeatherData(
          data: weatherData,
        );

        expect(modelFromResponse.condition, 'Cloudy');
      },
    );
  });
}
