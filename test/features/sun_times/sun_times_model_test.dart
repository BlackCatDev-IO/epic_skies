import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../test_utils.dart';

Future<void> main() async {
  late WeatherData data;

  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();

    await Get.put(StorageController()).initAllStorage();
    Get.put(TimeZoneController());
    Get.put(SunTimeController());
    Get.put(WeatherRepository());

    data = WeatherRepository
        .to.weatherModel!.timelines[Timelines.daily].intervals[0].data;

    Get.put(CurrentWeatherController());
    Get.put(HourlyForecastController());

    StorageController.to
        .storeWeatherData(map: MockWeatherResponse.bronxWeather);

    StorageController.to.storeTempUnitMetricSetting(setting: false);
    StorageController.to.storePrecipInMmSetting(setting: false);
    StorageController.to.storeTimeIn24HrsSetting(setting: false);
    StorageController.to.storeSpeedInKphSetting(setting: false);

    WeatherRepository.to.weatherModel =
        WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

    SunTimeController.to.initSunTimeList();

    CurrentWeatherController.to.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );
  });

  group('SunTimeModel test:', () {
    test('fromWeatherData initializes as expected', () {
      final modelFromResponse = SunTimesModel.fromWeatherData(
        data: data,
      );

      final regularModel = SunTimesModel(
        sunriseTime: data.sunriseTime,
        sunsetTime: data.sunsetTime,
        sunriseString:
            DateTimeFormatter.formatFullTime(time: data.sunriseTime!),
        sunsetString: DateTimeFormatter.formatFullTime(time: data.sunsetTime!),
      );

      expect(regularModel, modelFromResponse);
    });

    test('fromMap initializes as expected', () {
      final map = {
        'sunriseTime': '2021-12-06T07:05:00-05:00',
        'sunsetTime': '2021-12-06T16:28:20-05:00',
      };

      final modelFromMap = SunTimesModel.fromMap(map);

      final regularModel = SunTimesModel(
        sunriseTime: DateTime.parse(map['sunriseTime']!),
        sunsetTime: DateTime.parse(map['sunsetTime']!),
        sunriseString: DateTimeFormatter.formatFullTime(
          time: DateTime.parse(map['sunriseTime']!),
        ),
        sunsetString: DateTimeFormatter.formatFullTime(
          time: DateTime.parse(map['sunsetTime']!),
        ),
      );

      expect(regularModel, modelFromMap);
    });

    test('toMap returns expected map', () {
      final modelFromResponse = SunTimesModel.fromWeatherData(
        data: data,
      );

      final modelToMap = modelFromResponse.toMap();

      final map = {
        'sunriseTime': '2021-11-08 06:33:20.000',
        'sunsetTime': '2021-11-08 16:43:20.000',
        'sunriseString': '6:33 AM',
        'sunsetString': '4:43 PM'
      };

      expect(modelToMap, map);
    });
  });
}
