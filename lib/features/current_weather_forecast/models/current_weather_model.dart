import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:equatable/equatable.dart';

import '../../../services/settings/unit_settings/unit_settings_model.dart';

class CurrentWeatherModel extends Equatable {
  final int temp;
  final String tempUnit;
  final int feelsLike;
  final String condition;
  final int windSpeed;
  final String speedUnit;
  final UnitSettings unitSettings;

  const CurrentWeatherModel({
    required this.temp,
    required this.tempUnit,
    required this.feelsLike,
    required this.condition,
    required this.windSpeed,
    required this.speedUnit,
    required this.unitSettings,
  });

  factory CurrentWeatherModel.fromWeatherData({
    required WeatherData data,
    required UnitSettings unitSettings,
  }) {
    String condition =
        WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode);

    final isSnowyCondition = _isSnowyCondition(condition);

    if (isSnowyCondition) {
      condition = _falseSnowCorrectedCondition(
        condition: condition,
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      );
    }

    return CurrentWeatherModel(
      temp: UnitConverter.convertTemp(
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      tempUnit: unitSettings.tempUnitsMetric ? 'C' : 'F',
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelsLikeTemp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      condition: condition,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      unitSettings: unitSettings,
    );
  }

  static bool _isSnowyCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'snow':
      case 'flurries':
      case 'light snow':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
        return true;
      default:
        return false;
    }
  }

  /// Sometimes weather code returns snow or flurries when its above freezing
  /// this prevents a snow image background & snow icons when its not actually
  /// snowing

  static String _falseSnowCorrectedCondition({
    required bool tempUnitsMetric,
    required int temp,
    required String condition,
  }) {
    final falseSnow = WeatherCodeConverter.falseSnow(
      temp: temp,
      condition: condition,
      tempUnitsMetric: tempUnitsMetric,
    );
    if (falseSnow) {
      return 'Cloudy';
    } else {
      return condition;
    }
  }

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        condition,
        windSpeed,
        tempUnit,
        speedUnit,
        unitSettings
      ];
}
