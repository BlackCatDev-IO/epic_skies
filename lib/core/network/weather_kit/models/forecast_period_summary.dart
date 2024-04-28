import 'package:dart_mappable/dart_mappable.dart';

part 'forecast_period_summary.mapper.dart';

/// The summary for a specified period in the minute forecast
@MappableClass()
class ForecastPeriodSummary with ForecastPeriodSummaryMappable {
  ForecastPeriodSummary({
    required this.startTime,
    required this.endTime,
    required this.condition,
    required this.precipitationChance,
    required this.precipitationIntensity,
  });

  /// The type of precipitation forecasted
  final DateTime startTime;

  /// The start time of the forecast
  final DateTime? endTime;

  /// The end time of the forecast
  final String condition;

  /// The probability of precipitation during this period
  final double precipitationChance;

  /// The precipitation intensity in millimeters per hour
  final double precipitationIntensity;

  /// Returns a new [ForecastPeriodSummary] object from the provided [Map]
  static const fromMap = ForecastPeriodSummaryMapper.fromMap;
}
