import 'package:dart_mappable/dart_mappable.dart';

part 'hour_weather_conditions.mapper.dart';

/// The historical or forecasted weather conditions for a specified hour.
@MappableClass()
class HourWeatherConditions with HourWeatherConditionsMappable {
  HourWeatherConditions({
    required this.cloudCover,
    required this.conditionCode,
    required this.daylight,
    required this.forecastStart,
    required this.humidity,
    required this.precipitationChance,
    required this.precipitationType,
    required this.pressure,
    required this.pressureTrend,
    required this.snowfallIntensity,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    required this.visibility,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
    required this.precipitationAmount,
  });

  /// The percentage of the sky covered with clouds during the period,
  /// from 0 to 1
  final num cloudCover;

  /// An enumeration value indicating the condition at the time
  final String conditionCode;

  /// Indicates whether the hour starts during the day or night
  final bool? daylight;

  /// The starting date and time of the forecast
  final DateTime forecastStart;

  /// The relative humidity at the start of the hour, from 0 to 1
  final num humidity;

  /// The chance of precipitation forecasted to occur during the hour,
  /// from 0 to 1
  final num precipitationChance;

  /// The type of precipitation that is forecasted to occur during the hour
  final String precipitationType;

  /// The atmospheric pressure at the start of the hour, in millibars
  final num pressure;

  /// The direction of change of the sea-level air pressure
  final String? pressureTrend;

  /// The rate at which snow crystals are falling, in millimeters per hour
  final num? snowfallIntensity;

  /// The temperature at the start of the hour, in degrees Celsius
  final num temperature;

  /// The feels-like temperature when considering wind and humidity,
  /// in degrees Celsius
  final num temperatureApparent;

  /// The temperature at which relative humidity is 100% at the top of the hour
  /// in degrees Celsius
  final num? temperatureDewPoint;

  /// The level of ultraviolet radiation at the start of the hour
  final int uvIndex;

  /// The distance at which terrain is visible at the start of the hour,
  /// in meters
  final num visibility;

  /// The direction of the wind at the start of the hour, in degrees
  final int? windDirection;

  /// The maximum wind gust speed during the hour, in kilometers per hour
  final num? windGust;

  /// The wind speed at the start of the hour, in kilometers per hour
  final num windSpeed;

  /// The amount of precipitation forecasted to occur during period, in
  /// millimeters
  final num? precipitationAmount;

  /// Creates a new [HourWeatherConditions] object from the provided [Map]
  static const fromMap = HourWeatherConditionsMapper.fromMap;
}
