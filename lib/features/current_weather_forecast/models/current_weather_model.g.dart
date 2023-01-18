// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'current_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentWeatherModel _$$_CurrentWeatherModelFromJson(
  Map<String, dynamic> json,
) =>
    _$_CurrentWeatherModel(
      temp: json['temp'] as int,
      feelsLike: json['feelsLike'] as int,
      windSpeed: json['windSpeed'] as int,
      tempUnit: json['tempUnit'] as String,
      condition: json['condition'] as String,
      speedUnit: json['speedUnit'] as String,
      unitSettings:
          UnitSettings.fromJson(json['unitSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CurrentWeatherModelToJson(
  _$_CurrentWeatherModel instance,
) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'windSpeed': instance.windSpeed,
      'tempUnit': instance.tempUnit,
      'condition': instance.condition,
      'speedUnit': instance.speedUnit,
      'unitSettings': instance.unitSettings,
    };
