import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_weather_model.freezed.dart';
part 'current_weather_model.g.dart';

@freezed
class CurrentWeatherModel with _$CurrentWeatherModel {
  const factory CurrentWeatherModel({
    required int temp,
    required int feelsLike,
    required int windSpeed,
    required String condition,
    required UnitSettings unitSettings,
  }) = _CurrentWeatherModel;

  factory CurrentWeatherModel.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherModelFromJson(json);

  factory CurrentWeatherModel.fromWeatherData({
    required CurrentData data,
    required UnitSettings unitSettings,
  }) {
    var condition = data.conditions;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }

    final isSnowyCondition = _isSnowyCondition(condition);

    if (isSnowyCondition) {
      condition = _falseSnowCorrectedCondition(
        condition: condition,
        temp: data.temp.round(),
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      );
    }

    return CurrentWeatherModel(
      temp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelslike,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      condition: condition,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: unitSettings.speedInKph,
      ),
      unitSettings: unitSettings,
    );
  }

  factory CurrentWeatherModel.initial() => CurrentWeatherModel(
        temp: 0,
        feelsLike: 0,
        windSpeed: 0,
        condition: '',
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
