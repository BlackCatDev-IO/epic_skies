import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_storage_return_values.dart';
import '../../../mocks/mock_sun_time_data.dart';

Future<void> main() async {
  late WeatherData weatherData;
  late String condition;
  late MockWeatherRepo mockWeatherRepo;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;

  setUpAll(() async {
    mockStorage = MockStorageController();

    WidgetsFlutterBinding.ensureInitialized();
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

    Get.put(
      CurrentWeatherController(
        weatherRepository: mockWeatherRepo,
        storage: mockStorage,
      ),
    );

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromMap(
      map: MockWeatherResponse.bronxWeather,
      unitSettings: unitSettings,
    );

    Get.put(SunTimeController(storage: mockStorage))
        .initSunTimeList(weatherModel: mockWeatherRepo.weatherModel!);

    CurrentWeatherController.to.currentTime =
        TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-03T18:08:00-04:00',
    );

    weatherData = mockWeatherRepo
        .weatherModel!.timelines[Timelines.current].intervals[0].data;

    condition = WeatherCodeConverter.getConditionFromWeatherCode(
      weatherData.weatherCode,
    );
  });

  group('CurrentWeatherModel test: ', () {
    test('CurrentWeatherModel.fromWeatherData initializes as expected', () {
      final modelFromResponse =
          CurrentWeatherModel.fromWeatherData(data: weatherData);

      final regularModel = CurrentWeatherModel(
        temp: 64,
        feelsLike: 64,
        windSpeed: 6,
        condition: condition,
        tempUnit: 'F',
        speedUnit: 'mph',
        unitSettings: unitSettings,
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      final metricUnitSettings = UnitSettings(
        id: 1,
        timeIn24Hrs: false,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: false,
      );

      mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
        model: mockWeatherRepo.weatherModel!,
        updatedSettings: metricUnitSettings,
        oldSettings: unitSettings,
      );

      weatherData = mockWeatherRepo
          .weatherModel!.timelines[Timelines.current].intervals[0].data;

      final modelFromResponse =
          CurrentWeatherModel.fromWeatherData(data: weatherData);

      expect(
        modelFromResponse.temp,
        18,
      ); // 18 is converted from 64 deg Fahrenheit
      expect(modelFromResponse.windSpeed, 10); // 9 is converted from 5.59 mph
    });

    test(
      'conditon gets updated to non snowy condition when weatherCode returns a snowy condition in above freezing temps',
      () {
        mockWeatherRepo.weatherModel = WeatherResponseModel.fromMap(
          map: MockWeatherResponse.falseSnowResponse,
          unitSettings: unitSettings,
        );

        weatherData = mockWeatherRepo
            .weatherModel!.timelines[Timelines.current].intervals[0].data;

        final modelFromResponse = CurrentWeatherModel.fromWeatherData(
          data: weatherData,
        );

        expect(modelFromResponse.condition, 'Cloudy');
      },
    );
  });
}
