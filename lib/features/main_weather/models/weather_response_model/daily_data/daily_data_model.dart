import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';

part 'daily_data_model.mapper.dart';

@MappableClass()
class DailyData with DailyDataMappable {
  DailyData({
    required this.datetimeEpoch,
    required this.conditions,
    required this.temp,
    required this.feelslike,
    this.windspeed,
    this.tempmax,
    this.tempmin,
    this.feelslikemax,
    this.feelslikemin,
    this.dew,
    this.humidity,
    this.precip,
    this.precipprob,
    this.precipcover,
    this.preciptype,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.winddir,
    this.pressure,
    this.cloudcover,
    this.visibility,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.sunriseEpoch,
    this.sunsetEpoch,
    this.moonphase,
    this.description,
    this.icon,
    this.source,
    this.hours,
  });

  final int datetimeEpoch;
  final String conditions;
  final num temp;
  final num feelslike;
  final num? windspeed;
  final num? tempmax;
  final num? tempmin;
  final double? feelslikemax;
  final double? feelslikemin;
  final double? dew;
  final double? humidity;
  final double? precip;
  final double? precipprob;
  final double? precipcover;
  final List<dynamic>? preciptype;
  final num? snow;
  final num? snowdepth;
  final double? windgust;
  final double? winddir;
  final double? pressure;
  final double? cloudcover;
  final double? visibility;
  final double? solarradiation;
  final double? solarenergy;
  final num? uvindex;
  final num? severerisk;
  final num? sunriseEpoch;
  final num? sunsetEpoch;
  final double? moonphase;
  final String? description;
  final String? icon;
  final String? source;
  final List<HourlyData>? hours;

  static const fromMap = DailyDataMapper.fromMap;
}
