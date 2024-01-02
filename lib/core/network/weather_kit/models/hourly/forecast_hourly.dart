import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/hour_weather_conditions.dart';
import 'package:epic_skies/core/network/weather_kit/models/metadata/metadata.dart'
    as meta;

part 'forecast_hourly.mapper.dart';

@MappableClass()
class ForecastHourly with ForecastHourlyMappable {
  ForecastHourly({
    required this.metadata,
    required this.hours,
  });

  /// Descriptive information about the weather data
  final meta.MetaData metadata;

  /// The hourly weather conditions for the next 249 hours
  final List<HourWeatherConditions> hours;

  /// Returns a new [ForecastHourly] instance from the given [Map]
  static const fromMap = ForecastHourlyMapper.fromMap;
}
