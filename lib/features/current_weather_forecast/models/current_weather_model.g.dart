// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentWeatherModel _$$_CurrentWeatherModelFromJson(
        Map<String, dynamic> json) =>
    _$_CurrentWeatherModel(
      temp: json['temp'] as int,
      feelsLike: json['feelsLike'] as int,
      windSpeed: json['windSpeed'] as int,
      condition: json['condition'] as String,
      unitSettings:
          UnitSettings.fromJson(json['unitSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CurrentWeatherModelToJson(
        _$_CurrentWeatherModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'windSpeed': instance.windSpeed,
      'condition': instance.condition,
      'unitSettings': instance.unitSettings,
    };
