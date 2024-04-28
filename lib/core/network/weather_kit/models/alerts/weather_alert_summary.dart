import 'package:dart_mappable/dart_mappable.dart';

part 'weather_alert_summary.mapper.dart';

/// Detailed information about the weather alert
@MappableClass()
class WeatherAlertSummary with WeatherAlertSummaryMappable {
  WeatherAlertSummary({
    required this.id,
    required this.certainty,
    required this.countryCode,
    required this.description,
    required this.effectiveTime,
    required this.expireTime,
    required this.issuedTime,
    required this.responses,
    required this.severity,
    required this.source,
    this.areaId,
    this.areaName,
    this.detailsUrl,
    this.eventEndTime,
    this.eventOnsetTime,
    this.urgency,
  });

  /// A unique Uuid identifier of the event
  final String id;

  /// An official designation of the affected area
  final String? areaId;

  /// A human-readable name of the affected area
  final String? areaName;

  /// How likely the event is to occur
  final String certainty;

  /// The ISO code of the reporting country
  final String countryCode;

  /// A human-readable description of the event
  final String description;

  /// The URL to a page containing detailed information about the event
  final String? detailsUrl;

  /// The time the event went into effect
  final DateTime effectiveTime;

  /// The time when the underlying weather event is projected to end
  final DateTime? eventEndTime;

  /// The time when the underlying weather event is projected to start
  final DateTime? eventOnsetTime;

  /// The time when the event expires
  final DateTime expireTime;

  /// The time that event was issued by the reporting agency
  final DateTime issuedTime;

  /// An array of recommended actions from the reporting agency
  final List<String> responses;

  /// The level of danger to life and property
  final String severity;

  /// The name of the reporting agency
  final String source;

  /// An indication of urgency of the event
  final String? urgency;

  /// Creates a new [WeatherAlertSummary] object from the provided [Map]
  static const fromMap = WeatherAlertSummaryMapper.fromMap;
}
