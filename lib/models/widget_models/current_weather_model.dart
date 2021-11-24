import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:equatable/equatable.dart';

class CurrentWeatherModel extends Equatable {
  final int temp;
  final int feelsLike;
  final String condition;
  final int windSpeed;

  const CurrentWeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.condition,
    required this.windSpeed,
  });

  factory CurrentWeatherModel.fromWeatherData({required WeatherData data}) {
    final settingsMap = StorageController.to.settingsMap;
    final tempUnitsMetric = settingsMap[tempUnitsMetricKey] as bool;
    final speedInKm = settingsMap[speedInKphKey] as bool;
    final speed =
        UnitConverter.convertFeetPerSecondToMph(feetPerSecond: data.windSpeed)
            .round();

    final temp = tempUnitsMetric
        ? UnitConverter.toCelcius(temp: data.temperature)
        : data.temperature;

    String condition =
        WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode);

    final isSnowyCondition = _isSnowyCondition(condition);

    if (isSnowyCondition) {
      condition = _falseSnowCorrectedCondition(
        condition: condition,
        temp: temp,
        tempUnitsMetric: tempUnitsMetric,
      );
    }

    return CurrentWeatherModel(
      temp: temp,
      feelsLike: tempUnitsMetric
          ? UnitConverter.toCelcius(temp: data.feelsLikeTemp)
          : data.feelsLikeTemp,
      condition: condition,
      windSpeed:
          speedInKm ? UnitConverter.convertMilesToKph(miles: speed) : speed,
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
    final falseSnow =
        WeatherCodeConverter.falseSnow(temp: temp, condition: condition);
    if (falseSnow) {
      return 'Cloudy';
    } else {
      return condition;
    }
  }

  @override
  List<Object?> get props => [temp, feelsLike, condition, windSpeed];
}
