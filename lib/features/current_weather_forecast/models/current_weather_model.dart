import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';

part 'current_weather_model.mapper.dart';

@MappableClass()
class CurrentWeatherModel with CurrentWeatherModelMappable {
  const CurrentWeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.windSpeed,
    required this.condition,
    required this.unitSettings,
  });
@MappableClass()
class CurrentWeatherModel with CurrentWeatherModelMappable {
  const CurrentWeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.windSpeed,
    required this.condition,
    required this.unitSettings,
  });

  factory CurrentWeatherModel.fromWeatherData({
    required UnitSettings unitSettings,
    required CurrentWeatherData data,
  }) {
    final conditionCode = data.conditionCode;

    return CurrentWeatherModel(
      temp: UnitConverter.convertTemp(
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.temperatureApparent,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      condition: _splitPascalCase(conditionCode),
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      unitSettings: unitSettings,
    );
  }

  factory CurrentWeatherModel.initial() => const CurrentWeatherModel(
        temp: 0,
        feelsLike: 0,
        windSpeed: 0,
        condition: '',
        unitSettings: UnitSettings(),
        unitSettings: UnitSettings(),
      );

  final int temp;
  final int feelsLike;
  final int windSpeed;
  final String condition;
  final UnitSettings unitSettings;

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

  final stringBuffer = StringBuffer();

  for (var i = 0; i < input.length; i++) {
    if (i > 0 && input[i].toUpperCase() == input[i]) {
      stringBuffer.write(' ');
    }
    stringBuffer.write(input[i]);
  }

  static const fromMap = CurrentWeatherModelMapper.fromMap;
}
