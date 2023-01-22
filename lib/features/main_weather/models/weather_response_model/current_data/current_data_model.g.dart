// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentData _$$_CurrentDataFromJson(Map<String, dynamic> json) =>
    _$_CurrentData(
      datetimeEpoch: json['datetimeEpoch'] as int,
      conditions: json['conditions'] as String,
      temp: json['temp'] as num,
      feelslike: json['feelslike'] as num,
      windspeed: json['windspeed'] as num?,
      humidity: (json['humidity'] as num?)?.toDouble(),
      dew: (json['dew'] as num?)?.toDouble(),
      precip: json['precip'] as num?,
      precipprob: json['precipprob'] as num?,
      snow: json['snow'] as num?,
      snowdepth: json['snowdepth'] as num?,
      preciptype: json['preciptype'] as List<dynamic>?,
      windgust: json['windgust'] as num?,
      winddir: json['winddir'] as num?,
      pressure: json['pressure'] as num?,
      visibility: json['visibility'] as num?,
      cloudcover: json['cloudcover'] as num?,
      solarradiation: json['solarradiation'] as num?,
      solarenergy: (json['solarenergy'] as num?)?.toDouble(),
      uvindex: json['uvindex'] as num?,
      icon: json['icon'] as String?,
      source: json['source'] as String?,
      sunrise: json['sunrise'] as String?,
      sunriseEpoch: json['sunriseEpoch'] as num?,
      sunset: json['sunset'] as String?,
      sunsetEpoch: json['sunsetEpoch'] as num?,
      moonphase: (json['moonphase'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_CurrentDataToJson(_$_CurrentData instance) =>
    <String, dynamic>{
      'datetimeEpoch': instance.datetimeEpoch,
      'conditions': instance.conditions,
      'temp': instance.temp,
      'feelslike': instance.feelslike,
      'windspeed': instance.windspeed,
      'humidity': instance.humidity,
      'dew': instance.dew,
      'precip': instance.precip,
      'precipprob': instance.precipprob,
      'snow': instance.snow,
      'snowdepth': instance.snowdepth,
      'preciptype': instance.preciptype,
      'windgust': instance.windgust,
      'winddir': instance.winddir,
      'pressure': instance.pressure,
      'visibility': instance.visibility,
      'cloudcover': instance.cloudcover,
      'solarradiation': instance.solarradiation,
      'solarenergy': instance.solarenergy,
      'uvindex': instance.uvindex,
      'icon': instance.icon,
      'source': instance.source,
      'sunrise': instance.sunrise,
      'sunriseEpoch': instance.sunriseEpoch,
      'sunset': instance.sunset,
      'sunsetEpoch': instance.sunsetEpoch,
      'moonphase': instance.moonphase,
    };
