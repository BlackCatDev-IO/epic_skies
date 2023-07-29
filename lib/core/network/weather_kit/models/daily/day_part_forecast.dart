import 'package:dart_mappable/dart_mappable.dart';

part 'day_part_forecast.mapper.dart';

/// A summary forecast for a daytime or overnight period
@MappableClass()
class DayPartForecast with DayPartForecastMappable {
  DayPartForecast({
    required this.cloudCover,
    required this.conditionCode,
    required this.forecastEnd,
    required this.forecastStart,
    required this.humidity,
    required this.precipitationAmount,
    required this.precipitationChance,
    required this.precipitationType,
    required this.snowfallAmount,
    required this.windDirection,
    required this.windSpeed,
  });

  /// The percentage of the sky covered with clouds during the period,
  /// from 0 to 1
  final num cloudCover;

  /// An enumeration value indicating the condition at the time
  final String conditionCode;

  /// The ending date and time of the forecast
  final DateTime forecastEnd;

  /// The starting date and time of the forecast
  final DateTime forecastStart;

  /// The relative humidity during the period, from 0 to 1
  final num humidity;

  /// The amount of precipitation forecasted to occur during the period, in
  /// millimeters
  final num precipitationAmount;

  /// The chance of precipitation forecasted to occur during the period.
  final num precipitationChance;

  /// The type of precipitation forecasted to occur during the period.
  final String precipitationType;

  /// The depth of snow as ice crystals forecasted to occur during the period,
  /// in millimeters.
  final num snowfallAmount;

  /// The direction the wind is forecasted to come from during the period,
  /// in degrees.
  final int windDirection;

  /// The average speed the wind is forecasted to be during the period,
  /// in kilometers per hour.
  final num windSpeed;

  /// Creates a new [DayPartForecast] object from the provided [Map]
  static const fromMap = DayPartForecastMapper.fromMap;
}
