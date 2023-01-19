// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'hourly_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HourlyData _$$_HourlyDataFromJson(Map<String, dynamic> json) =>
    _$_HourlyData(
      datetimeEpoch: json['datetimeEpoch'] as int,
      temp: json['temp'] as num,
      feelslike: json['feelslike'] as num,
      conditions: json['conditions'] as String,
      windspeed: json['windspeed'] as num?,
      humidity: (json['humidity'] as num?)?.toDouble(),
      dew: (json['dew'] as num?)?.toDouble(),
      precip: json['precip'] as num?,
      precipprob: json['precipprob'] as num?,
      snow: json['snow'] as num?,
      snowDepth: (json['snowDepth'] as num?)?.toDouble(),
      precipitationType: json['precipitationType'] as List<dynamic>?,
      windgust: (json['windgust'] as num?)?.toDouble(),
      winddir: (json['winddir'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      cloudcover: (json['cloudcover'] as num?)?.toDouble(),
      solarradiation: (json['solarradiation'] as num?)?.toDouble(),
      solarenergy: (json['solarenergy'] as num?)?.toDouble(),
      uvindex: json['uvindex'] as num?,
      severerisk: json['severerisk'] as num?,
      icon: json['icon'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$_HourlyDataToJson(_$_HourlyData instance) =>
    <String, dynamic>{
      'datetimeEpoch': instance.datetimeEpoch,
      'temp': instance.temp,
      'feelslike': instance.feelslike,
      'conditions': instance.conditions,
      'windspeed': instance.windspeed,
      'humidity': instance.humidity,
      'dew': instance.dew,
      'precip': instance.precip,
      'precipprob': instance.precipprob,
      'snow': instance.snow,
      'snowDepth': instance.snowDepth,
      'precipitationType': instance.precipitationType,
      'windgust': instance.windgust,
      'winddir': instance.winddir,
      'pressure': instance.pressure,
      'visibility': instance.visibility,
      'cloudcover': instance.cloudcover,
      'solarradiation': instance.solarradiation,
      'solarenergy': instance.solarenergy,
      'uvindex': instance.uvindex,
      'severerisk': instance.severerisk,
      'icon': instance.icon,
      'source': instance.source,
    };
