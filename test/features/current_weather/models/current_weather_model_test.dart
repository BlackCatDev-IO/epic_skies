import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';

Future<void> main() async {
  late CurrentWeatherData currentConditionData;

  late UnitSettings unitSettings;

  setUpAll(() async {
    currentConditionData = CurrentWeatherData.fromMap(
      MockWeatherResponse.weatherKitCurrentWeather,
    );

    unitSettings = const UnitSettings();
  });

  group('CurrentWeatherModel test: ', () {
    test('CurrentWeatherModel.fromWeatherData initializes as expected', () {
      final modelFromResponse = CurrentWeatherModel.fromWeatherKit(
        data: currentConditionData,
        unitSettings: unitSettings,
      );

      final regularModel = CurrentWeatherModel(
        temp: 40,
        feelsLike: 32,
        windSpeed: 13,
        condition: 'Mostly cloudy',
        unitSettings: unitSettings,
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      const metricUnitSettings = UnitSettings(
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      const metricModel = CurrentWeatherModel(
        temp: 4, // converted from 40 F
        feelsLike: 0, // converted from 33 F
        windSpeed: 20, // converted from 13 mph
        condition: 'Mostly cloudy',
        unitSettings: metricUnitSettings,
      );

      final modelFromResponse = CurrentWeatherModel.fromWeatherKit(
        data: currentConditionData,
        unitSettings: metricUnitSettings,
      );

      expect(metricModel, modelFromResponse);
    });
  });
}
