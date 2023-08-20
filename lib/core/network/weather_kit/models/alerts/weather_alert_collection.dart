import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/alerts/weather_alert_summary.dart';

part 'weather_alert_collection.mapper.dart';

@MappableClass()
class WeatherAlertCollection with WeatherAlertCollectionMappable {
  WeatherAlertCollection({
    required this.alerts,
    this.detailsUrl,
  });

  /// An array of weather alert summaries
  final List<WeatherAlertSummary> alerts;

  /// A URL that provides more information about the alerts
  final String? detailsUrl;

  static const fromMap = WeatherAlertCollectionMapper.fromMap;
}
