// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HourlyForecastModel _$$_HourlyForecastModelFromJson(
        Map<String, dynamic> json) =>
    _$_HourlyForecastModel(
      temp: json['temp'] as int,
      feelsLike: json['feelsLike'] as int,
      precipitationAmount: json['precipitationAmount'] as num,
      precipitationProbability: json['precipitationProbability'] as num,
      windSpeed: json['windSpeed'] as int,
      iconPath: json['iconPath'] as String,
      time: json['time'] as String,
      precipitationType: json['precipitationType'] as String,
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$$_HourlyForecastModelToJson(
        _$_HourlyForecastModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'precipitationAmount': instance.precipitationAmount,
      'precipitationProbability': instance.precipitationProbability,
      'windSpeed': instance.windSpeed,
      'iconPath': instance.iconPath,
      'time': instance.time,
      'precipitationType': instance.precipitationType,
      'condition': instance.condition,
    };
