// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_weather_button_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalWeatherButtonModelImpl _$$LocalWeatherButtonModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LocalWeatherButtonModelImpl(
      temp: json['temp'] as int? ?? 0,
      condition: json['condition'] as String? ?? '',
      isDay: json['isDay'] as bool? ?? true,
      tempUnitsMetric: json['tempUnitsMetric'] as bool? ?? false,
    );

Map<String, dynamic> _$$LocalWeatherButtonModelImplToJson(
        _$LocalWeatherButtonModelImpl instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'condition': instance.condition,
      'isDay': instance.isDay,
      'tempUnitsMetric': instance.tempUnitsMetric,
    };
