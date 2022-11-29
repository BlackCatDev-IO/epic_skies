import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_api_responses/mock_weather_responses.dart';

void main() {
  late UnitSettings unitSettings;
  late UnitSettings metricUnitSettings;
  late WeatherDataInitModel dataInitModel;
  late WeatherDataInitModel updatedDataInitModel;

  late WeatherResponseModel modelFromResponse;

  setUpAll(() async {
    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    metricUnitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: true,
      speedInKph: true,
      tempUnitsMetric: true,
      precipInMm: true,
    );

    dataInitModel = WeatherDataInitModel(
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    updatedDataInitModel = WeatherDataInitModel(
      searchIsLocal: true,
      unitSettings: metricUnitSettings,
      oldSettings: unitSettings,
    );

    modelFromResponse = WeatherResponseModel.fromResponse(
      model: dataInitModel,
      response: MockWeatherResponse.bronxWeather,
    );
  });

  group('WeatherResponse model test: ', () {
    test('Current WeatherData initializes as expected', () {
      final todayData =
          modelFromResponse.timelines[Timelines.current].intervals[0].data;

      final startTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-08T16:00:00-05:00',
        searchIsLocal: true,
      );

      final regData = WeatherData(
        startTime: startTime,
        cloudCover: 0,
        humidity: 40,
        timestep: 'current',
        precipitationProbability: 0,
        windDirection: 359,
        visibility: 9.94,
        cloudBase: null,
        unitSettings: unitSettings,
        weatherCode: 1000,
        windSpeed: 5.59.round(),
        precipitationType: 0,
        precipitationIntensity: 0,
        sunriseTime: null,
        sunsetTime: null,
        feelsLikeTemp: 63.73.round(),
        temperature: 63.73.round(),
        cloudCeiling: null,
      );

      expect(regData, todayData);
    });

    test('Hourly WeatherData initializes as expected', () {
      final firstHourlyData =
          modelFromResponse.timelines[Timelines.hourly].intervals[0].data;

      final lastHourlyData =
          modelFromResponse.timelines[Timelines.hourly].intervals[108].data;

      final startTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-08T16:00:00-05:00',
        searchIsLocal: true,
      );

      final regDataFirstHour = WeatherData(
        startTime: startTime,
        cloudCover: 0,
        humidity: 40,
        timestep: '1h',
        precipitationProbability: 0,
        windDirection: 359,
        visibility: 9.94,
        cloudBase: null,
        unitSettings: unitSettings,
        weatherCode: 1000,
        windSpeed: 5.59.round(),
        precipitationType: 0,
        precipitationIntensity: 0,
        sunriseTime: null,
        sunsetTime: null,
        feelsLikeTemp: 63.73.round(),
        temperature: 63.73.round(),
        cloudCeiling: null,
      );

      final regDataLastHour = WeatherData(
        startTime: startTime,
        cloudCover: 3.6,
        humidity: 62.65,
        timestep: '1h',
        precipitationProbability: 0,
        windDirection: 231.69,
        visibility: 15,
        cloudBase: null,
        unitSettings: unitSettings,
        weatherCode: 1000,
        windSpeed: 3.47.round(),
        precipitationType: 0,
        precipitationIntensity: 0,
        sunriseTime: null,
        sunsetTime: null,
        feelsLikeTemp: 52.63.round(),
        temperature: 52.63.round(),
        cloudCeiling: null,
      );

      expect(regDataFirstHour, firstHourlyData);
      expect(regDataLastHour, lastHourlyData);
    });

    test('Daily WeatherData initializes as expected', () {
      final firstDayData =
          modelFromResponse.timelines[Timelines.daily].intervals[0].data;

      final lastDayData =
          modelFromResponse.timelines[Timelines.daily].intervals[14].data;

      final firstDayStartTime =
          TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-08T16:00:00-05:00',
        searchIsLocal: true,
      );

      final lastDayStartTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-22T06:00:00-05:00',
        searchIsLocal: true,
      );

      final firstDaySunsetTime =
          TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-08T16:43:20-05:00',
        searchIsLocal: true,
      );

      final lastDaySunsetTime =
          TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-22T16:33:20-05:00',
        searchIsLocal: true,
      );

      final firstDaySunriseTime =
          TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-08T06:33:20-05:00',
        searchIsLocal: true,
      );

      final lastDaySunriseTime =
          TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
        time: '2021-11-22T06:50:00-05:00',
        searchIsLocal: true,
      );

      final regFirstDayData = WeatherData(
        startTime: firstDayStartTime,
        cloudCover: 1.96,
        humidity: 80,
        timestep: '1d',
        windDirection: 179.32,
        visibility: 9.94,
        cloudBase: 0,
        unitSettings: unitSettings,
        weatherCode: 1000,
        windSpeed: 10.36.round(),
        precipitationType: 0,
        precipitationIntensity: 0,
        precipitationProbability: 0,
        sunriseTime: firstDaySunriseTime,
        sunsetTime: firstDaySunsetTime,
        feelsLikeTemp: 63.73.round(),
        temperature: 63.73.round(),
        cloudCeiling: 0,
      );

      final regLastDayData = WeatherData(
        startTime: lastDayStartTime,
        cloudCover: 63.85,
        humidity: 58.56,
        timestep: '1d',
        windDirection: 297.98,
        visibility: 15,
        cloudBase: 0.71,
        unitSettings: unitSettings,
        weatherCode: 1100,
        windSpeed: 16.2.round(),
        precipitationType: 0,
        precipitationIntensity: 0,
        precipitationProbability: 0,
        sunriseTime: lastDaySunriseTime,
        sunsetTime: lastDaySunsetTime,
        feelsLikeTemp: 46.18.round(),
        temperature: 46.18.round(),
        cloudCeiling: 0,
      );

      expect(regFirstDayData, firstDayData);
      expect(regLastDayData, lastDayData);
    });
  });

  test('Current WeatherData initializes as expected with updated UnitSettings',
      () {
    final modelFromResponseMetric = WeatherResponseModel.fromResponse(
      model: updatedDataInitModel,
      response: MockWeatherResponse.bronxWeather,
    );

    final modelOnUnitSettingsChange = WeatherResponseModel.updatedUnitSettings(
      data: updatedDataInitModel,
      model: modelFromResponse,
    );

    final todayData =
        modelFromResponseMetric.timelines[Timelines.current].intervals[0].data;

    final todayDataFromUnitSettingsChange = modelOnUnitSettingsChange
        .timelines[Timelines.current].intervals[0].data;

    final startTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-08T16:00:00-05:00',
      searchIsLocal: true,
    );

    final regDataMetric = WeatherData(
      startTime: startTime,
      cloudCover: 0.0,
      humidity: 40,
      timestep: 'current',
      precipitationProbability: 0,
      windDirection: 359,
      visibility: 9.94,
      cloudBase: null,
      unitSettings: unitSettings,
      weatherCode: 1000,
      windSpeed: 9,
      precipitationType: 0,
      precipitationIntensity: 0.0,
      sunriseTime: null,
      sunsetTime: null,
      feelsLikeTemp: 18,
      temperature: 18,
      cloudCeiling: null,
    );

    final regDataMetricUpdated = WeatherData(
      startTime: startTime,
      cloudCover: 0.0,
      humidity: 40,
      timestep: 'current',
      precipitationProbability: 0,
      windDirection: 359,
      visibility: 9.94,
      cloudBase: null,
      unitSettings: unitSettings,
      weatherCode: 1000,
      windSpeed: 10,
      precipitationType: 0,
      precipitationIntensity: 0.0,
      sunriseTime: null,
      sunsetTime: null,
      feelsLikeTemp: 18,
      temperature: 18,
      cloudCeiling: null,
    );

    expect(regDataMetric, todayData);
    expect(regDataMetricUpdated, todayDataFromUnitSettingsChange);
  });

  test('Hourly WeatherData initializes as expected', () {
    final modelFromResponseMetric = WeatherResponseModel.fromResponse(
      model: updatedDataInitModel,
      response: MockWeatherResponse.bronxWeather,
    );

    final firstHourlyData =
        modelFromResponseMetric.timelines[Timelines.hourly].intervals[0].data;

    final lastHourlyData =
        modelFromResponseMetric.timelines[Timelines.hourly].intervals[108].data;

    final startTime = TimeZoneUtil.parseTimeBasedOnLocalOrRemoteSearch(
      time: '2021-11-08T16:00:00-05:00',
      searchIsLocal: true,
    );

    final regDataFirstHour = WeatherData(
      startTime: startTime,
      cloudCover: 0.0,
      humidity: 40,
      timestep: '1h',
      precipitationProbability: 0,
      windDirection: 359,
      visibility: 9.94,
      cloudBase: null,
      unitSettings: unitSettings,
      weatherCode: 1000,
      windSpeed: 9,
      precipitationType: 0,
      precipitationIntensity: 0.0,
      sunriseTime: null,
      sunsetTime: null,
      feelsLikeTemp: 18,
      temperature: 18,
      cloudCeiling: null,
    );

    final regDataLastHour = WeatherData(
      startTime: startTime,
      cloudCover: 3.6,
      humidity: 62.65,
      timestep: '1h',
      precipitationProbability: 0,
      windDirection: 231.69,
      visibility: 15,
      cloudBase: null,
      unitSettings: unitSettings,
      weatherCode: 1000,
      windSpeed: 6,
      precipitationType: 0,
      precipitationIntensity: 0.0,
      sunriseTime: null,
      sunsetTime: null,
      feelsLikeTemp: 11,
      temperature: 11,
      cloudCeiling: null,
    );

    expect(regDataFirstHour, firstHourlyData);
    expect(regDataLastHour, lastHourlyData);
  });
}
