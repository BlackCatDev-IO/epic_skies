import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';

Future<void> main() async {
  late CurrentConditionData currentConditionData;

  late UnitSettings unitSettings;

  setUpAll(() async {
    currentConditionData = CurrentConditionData.fromMap(
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
        tempUnit: 'F',
        speedUnit: 'mph',
        unitSettings: unitSettings,
      );

      expect(regularModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      const metricUnitSettings = UnitSettings(
        timeIn24Hrs: false,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: false,
      );

      const metricModel = CurrentWeatherModel(
        temp: 5,
        feelsLike: 3,
        windSpeed: 6,
        condition: 'Partially cloudy',
        tempUnit: 'C',
        speedUnit: 'kph',
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
