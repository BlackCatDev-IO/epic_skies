import 'package:dart_mappable/dart_mappable.dart';

part 'forecast_minute.mapper.dart';

/// The precipitation forecast for a specified minute.
@MappableClass()
class ForecastMinute with ForecastMinuteMappable {
  ForecastMinute({
    required this.precipitationChance,
    required this.precipitationIntensity,
    required this.startTime,
  });

  /// The probability of precipitation during this minute
  final num precipitationChance;

  /// The precipitation intensity in millimeters per hour
  final num precipitationIntensity;

  /// The start time of the minute
  final DateTime startTime;

  /// Creates a new [ForecastMinute] object from the provided [Map]
  static const fromMap = ForecastMinuteMapper.fromMap;
}
