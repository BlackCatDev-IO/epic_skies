import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/settings/unit_settings/unit_settings_model.dart';

part 'current_weather_model.freezed.dart';
part 'current_weather_model.g.dart';

@freezed
class CurrentWeatherModel with _$CurrentWeatherModel {
  const factory CurrentWeatherModel({
    required int temp,
    required int feelsLike,
    required int windSpeed,
    required String tempUnit,
    required String condition,
    required String speedUnit,
    required UnitSettings unitSettings,
  }) = _CurrentWeatherModel;

  factory CurrentWeatherModel.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherModelFromJson(json);

  factory CurrentWeatherModel.fromWeatherData({
    required CurrentConditionData data,
    required UnitSettings unitSettings,
  }) {
    String condition = data.condition;

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

  factory CurrentWeatherModel.initial() => CurrentWeatherModel(
        temp: 0,
        feelsLike: 0,
        windSpeed: 0,
        tempUnit: 'F',
        condition: '',
        speedUnit: 'mph',
        unitSettings: UnitSettings.initial(),
      );

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
}
