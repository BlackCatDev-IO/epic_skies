import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
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

  factory CurrentWeatherModel.fromWeatherKit({
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
      condition: WeatherCodeConverter.convertWeatherKitCodes(conditionCode),
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

  factory CurrentWeatherModel.fromBackupApi({
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

  final int temp;
  final int feelsLike;
  final int windSpeed;
  final String condition;
  final UnitSettings unitSettings;

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

  static const fromMap = CurrentWeatherModelMapper.fromMap;
}
