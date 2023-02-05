import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';

Future<void> main() async {
  late CurrentData currentConditionData;

  late UnitSettings unitSettings;

  setUpAll(() async {
    currentConditionData = CurrentData.fromJson(
      MockWeatherResponse.nycCurrentWeatherCondition,
    );

    unitSettings = const UnitSettings(
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );
  });

  group('CurrentWeatherModel test: ', () {
    test('CurrentWeatherModel.fromWeatherData initializes as expected', () {
      final modelFromResponse = CurrentWeatherModel.fromWeatherData(
        data: currentConditionData,
        unitSettings: unitSettings,
      );

      final regularModel = CurrentWeatherModel(
        temp: 41,
        feelsLike: 37,
        windSpeed: 4,
        condition: 'Partially cloudy',
        unitSettings: unitSettings,
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      const metricUnitSettings = UnitSettings(
        timeIn24Hrs: false,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      const metricModel = CurrentWeatherModel(
        temp: 5, // converted from 41 F
        feelsLike: 3, // converted from 37.7 F
        windSpeed: 8, // converted from 5.8 mph
        condition: 'Partially cloudy',
        unitSettings: metricUnitSettings,
      );

      final modelFromResponse = CurrentWeatherModel.fromWeatherData(
        data: currentConditionData,
        unitSettings: metricUnitSettings,
      );

      expect(metricModel, modelFromResponse);
    });
  });
}
