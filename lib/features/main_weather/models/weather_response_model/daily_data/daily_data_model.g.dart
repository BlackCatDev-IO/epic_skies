// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'daily_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyData _$$_DailyDataFromJson(Map<String, dynamic> json) => _$_DailyData(
      datetimeEpoch: json['datetimeEpoch'] as int,
      conditions: json['conditions'] as String,
      temp: json['temp'] as num,
      feelslike: json['feelslike'] as num,
      windspeed: json['windspeed'] as num?,
      tempmax: json['tempmax'] as num?,
      tempmin: json['tempmin'] as num?,
      feelslikemax: (json['feelslikemax'] as num?)?.toDouble(),
      feelslikemin: (json['feelslikemin'] as num?)?.toDouble(),
      dew: (json['dew'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      precip: (json['precip'] as num?)?.toDouble(),
      precipprob: (json['precipprob'] as num?)?.toDouble(),
      precipcover: (json['precipcover'] as num?)?.toDouble(),
      precipitationType: json['precipitationType'] as List<dynamic>?,
      snow: json['snow'] as num?,
      snowdepth: json['snowdepth'] as num?,
      windgust: (json['windgust'] as num?)?.toDouble(),
      winddir: (json['winddir'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      cloudCover: (json['cloudCover'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      solarradiation: (json['solarradiation'] as num?)?.toDouble(),
      solarenergy: (json['solarenergy'] as num?)?.toDouble(),
      uvindex: json['uvindex'] as num?,
      severerisk: json['severerisk'] as num?,
      sunriseEpoch: json['sunriseEpoch'] as num?,
      sunsetEpoch: json['sunsetEpoch'] as num?,
      moonphase: (json['moonphase'] as num?)?.toDouble(),
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      source: json['source'] as String?,
      hours: (json['hours'] as List<dynamic>?)
          ?.map((e) => HourlyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DailyDataToJson(_$_DailyData instance) =>
    <String, dynamic>{
      'datetimeEpoch': instance.datetimeEpoch,
      'conditions': instance.conditions,
      'temp': instance.temp,
      'feelslike': instance.feelslike,
      'windspeed': instance.windspeed,
      'tempmax': instance.tempmax,
      'tempmin': instance.tempmin,
      'feelslikemax': instance.feelslikemax,
      'feelslikemin': instance.feelslikemin,
      'dew': instance.dew,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'precipprob': instance.precipprob,
      'precipcover': instance.precipcover,
      'precipitationType': instance.precipitationType,
      'snow': instance.snow,
      'snowdepth': instance.snowdepth,
      'windgust': instance.windgust,
      'winddir': instance.winddir,
      'pressure': instance.pressure,
      'cloudCover': instance.cloudCover,
      'visibility': instance.visibility,
      'solarradiation': instance.solarradiation,
      'solarenergy': instance.solarenergy,
      'uvindex': instance.uvindex,
      'severerisk': instance.severerisk,
      'sunriseEpoch': instance.sunriseEpoch,
      'sunsetEpoch': instance.sunsetEpoch,
      'moonphase': instance.moonphase,
      'description': instance.description,
      'icon': instance.icon,
      'source': instance.source,
      'hours': instance.hours,
    };
