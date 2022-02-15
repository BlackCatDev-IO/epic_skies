import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';
import '../../mocks/mock_storage_return_values.dart';
import '../../mocks/mock_sun_time_data.dart';
import '../../test_utils.dart';

Future<void> main() async {
  late MockWeatherRepo mockWeatherRepo;
  late WeatherData data;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;

  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    mockStorage = MockStorageController();

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

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

    Get.put(TimeZoneController(storage: mockStorage));
    Get.put(SunTimeController(storage: mockStorage));

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromMap(
      map: MockWeatherResponse.bronxWeather,
      unitSettings: unitSettings,
    );

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.daily].intervals[0].data;

    SunTimeController.to
        .initSunTimeList(weatherModel: mockWeatherRepo.weatherModel!);
  });

  group('SunTimeModel test:', () {
    test('fromWeatherData initializes as expected', () {
      final modelFromResponse = SunTimesModel.fromWeatherData(
        data: data,
      );

      final regularModel = SunTimesModel(
        sunriseTime: data.sunriseTime,
        sunsetTime: data.sunsetTime,
        sunriseString: DateTimeFormatter.formatFullTime(
          time: data.sunriseTime!,
          timeIn24Hrs: unitSettings.timeIn24Hrs,
        ),
        sunsetString: DateTimeFormatter.formatFullTime(
          time: data.sunsetTime!,
          timeIn24Hrs: unitSettings.timeIn24Hrs,
        ),
      );

      expect(regularModel, modelFromResponse);
    });

    test('fromMap initializes as expected', () {
      final map = {
        'sunriseTime': '2021-12-06T07:05:00-05:00',
        'sunsetTime': '2021-12-06T16:28:20-05:00',
      };

      final modelFromMap = SunTimesModel.fromMap(
        map: map,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      );

      final regularModel = SunTimesModel(
        sunriseTime: DateTime.parse(map['sunriseTime']!),
        sunsetTime: DateTime.parse(map['sunsetTime']!),
        sunriseString: DateTimeFormatter.formatFullTime(
          time: DateTime.parse(map['sunriseTime']!),
          timeIn24Hrs: unitSettings.timeIn24Hrs,
        ),
        sunsetString: DateTimeFormatter.formatFullTime(
          time: DateTime.parse(map['sunsetTime']!),
          timeIn24Hrs: unitSettings.timeIn24Hrs,
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
