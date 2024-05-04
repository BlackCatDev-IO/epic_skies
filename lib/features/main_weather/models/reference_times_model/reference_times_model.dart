import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';

part 'reference_times_model.mapper.dart';

@MappableClass()
class ReferenceTimesModel with ReferenceTimesModelMappable {
  const ReferenceTimesModel({
    this.now,
    this.timezoneOffset = Duration.zero,
    this.timezone = '',
    this.refererenceSuntimes = const [],
    this.isDay = true,
  });

  /// Single app-wide reference time for now to be used in all time calculations
  /// Changes on each refresh depending on the timezone of the search
  final DateTime? now;

  /// Single app-wide timezone offset set based on coordinates of the search
  final Duration timezoneOffset;

  /// String representation of the timezone of the search
  final String timezone;

  /// List of reference sun times for determining day or night
  final List<SunTimesModel> refererenceSuntimes;

  /// Whether it is day or night at the time and location of the search
  final bool isDay;
}
