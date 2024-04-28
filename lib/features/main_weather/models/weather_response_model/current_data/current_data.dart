import 'package:dart_mappable/dart_mappable.dart';

part 'current_data.mapper.dart';

@MappableClass()
class CurrentData with CurrentDataMappable {
  CurrentData({
    required this.datetimeEpoch,
    required this.conditions,
    required this.temp,
    required this.feelslike,
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
    this.icon,
    this.source,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
  });

  final int datetimeEpoch;
  final String conditions;
  final num temp;
  final num feelslike;
  final num? windspeed;
  final double? humidity;
  final double? dew;
  final num? precip;
  final num? precipprob;
  final num? snow;
  final num? snowdepth;
  final List<dynamic>? preciptype;
  final num? windgust;
  final num? winddir;
  final num? pressure;
  final num? visibility;
  final num? cloudcover;
  final num? solarradiation;
  final double? solarenergy;
  final num? uvindex;
  final String? icon;
  final String? source;
  final String? sunrise;
  final num? sunriseEpoch;
  final String? sunset;
  final num? sunsetEpoch;
  final double? moonphase;

  static const fromMap = CurrentDataMapper.fromMap;
}
