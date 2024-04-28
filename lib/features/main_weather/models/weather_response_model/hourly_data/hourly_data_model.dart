import 'package:dart_mappable/dart_mappable.dart';

part 'hourly_data_model.mapper.dart';

@MappableClass()
class HourlyData with HourlyDataMappable {
  HourlyData({
    required this.datetimeEpoch,
    required this.temp,
    required this.feelslike,
    required this.conditions,
    this.windspeed,
    this.humidity,
    this.dew,
    this.precip,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.preciptype,
    this.windgust,
    this.winddir,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.icon,
    this.source,
  });

  final int datetimeEpoch;
  final num temp;
  final num feelslike;
  final String conditions;
  final num? windspeed;
  final double? humidity;
  final double? dew;
  final num? precip;
  final num? precipprob;
  final num? snow;
  final double? snowdepth;
  final List<dynamic>? preciptype;
  final double? windgust;
  final double? winddir;
  final double? pressure;
  final double? visibility;
  final double? cloudcover;
  final double? solarradiation;
  final double? solarenergy;
  final num? uvindex;
  final num? severerisk;
  final String? icon;
  final String? source;

  static const fromMap = HourlyDataMapper.fromMap;
}
