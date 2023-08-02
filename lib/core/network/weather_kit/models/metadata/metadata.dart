import 'package:dart_mappable/dart_mappable.dart';

part 'metadata.mapper.dart';

/// Descriptive information about the weather data
/// https://developer.apple.com/documentation/weatherkitrestapi/metadata
@MappableClass()
class MetaData with MetaDataMappable {
  MetaData({
    required this.attributionURL,
    required this.expireTime,
    required this.language,
    required this.latitude,
    required this.longitude,
    required this.providerLogo,
    required this.providerName,
    required this.readTime,
    required this.reportedTime,
    required this.temporarilyUnavailable,
    required this.units,
    required this.version,
  });

  /// The URL of the legal attribution for the data source
  final String? attributionURL;

  /// The time when the weather data is no longer valid
  final DateTime expireTime;

  /// The ISO language code for localizable fields
  final String? language;

  /// The latitude of the relevant location
  final double latitude;

  /// The longitude of the relevant location
  final double longitude;

  /// The URL of a logo for the data provider
  final String? providerLogo;

  /// The name of the data provider
  final String? providerName;

  /// The time the weather data was procured
  final DateTime readTime;

  /// The time the provider reported the weather data
  final DateTime? reportedTime;

  /// The weather data is temporarily unavailable from the provider
  final bool? temporarilyUnavailable;

  /// The system of units that the weather data is reported in. This is set to
  /// metric
  final String? units;

  /// The data format version
  final int version;

  /// Creates a new [MetaData] instance from the provided [Map].
  static const fromMap = MetaDataMapper.fromMap;
}
