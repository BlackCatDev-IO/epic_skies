import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';

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
      condition: conditionCode.splitPascalCase,
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
      );

  final int temp;
  final int feelsLike;
  final int windSpeed;
  final String condition;
  final UnitSettings unitSettings;

  static const fromMap = CurrentWeatherModelMapper.fromMap;
}
