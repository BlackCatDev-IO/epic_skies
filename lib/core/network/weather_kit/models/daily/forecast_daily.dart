import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';

import 'package:epic_skies/core/network/weather_kit/models/metadata/metadata.dart';

part 'forecast_daily.mapper.dart';

@MappableClass()
class ForecastDaily with ForecastDailyMappable {
  ForecastDaily({
    required this.metadata,
    required this.days,
  });

  /// Descriptive information about the weather data
  final MetaData metadata;

  /// The daily weather conditions for the next 10 days
  final List<DayWeatherConditions> days;

  /// Returns a new [ForecastDaily] instance from the provided [Map].
  static const fromMap = ForecastDailyMapper.fromMap;
}
