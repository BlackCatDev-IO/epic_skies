import 'package:dart_mappable/dart_mappable.dart';

import 'package:epic_skies/core/network/weather_kit/models/forecast_period_summary.dart';
import 'package:epic_skies/core/network/weather_kit/models/miinute/forecast_minute.dart';

part 'next_hour_forecast.mapper.dart';

/// The next hour forecast information
@MappableClass()
class NextHourForecast with NextHourForecastMappable {
  NextHourForecast({
    required this.forecastStart,
    required this.forecastEnd,
    required this.minutes,
    required this.summary,
  });

  /// The time the forecast starts
  final DateTime? forecastStart;

  /// The time the forecast ends
  final DateTime? forecastEnd;

  /// A [List] of the forecast minutes
  final List<ForecastMinute> minutes;

  /// A [List] of the forecast summaries
  final List<ForecastPeriodSummary> summary;

  /// Creates a new [NextHourForecast] object from the provided [Map]
  static const fromMap = NextHourForecastMapper.fromMap;
}
