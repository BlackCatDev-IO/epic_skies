// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_local_weather_button_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchLocalWeatherButtonModel _$$_SearchLocalWeatherButtonModelFromJson(
        Map<String, dynamic> json) =>
    _$_SearchLocalWeatherButtonModel(
      temp: json['temp'] as int? ?? 0,
      condition: json['condition'] as String? ?? '',
      isDay: json['isDay'] as bool? ?? true,
      tempUnitsMetric: json['tempUnitsMetric'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SearchLocalWeatherButtonModelToJson(
        _$_SearchLocalWeatherButtonModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'condition': instance.condition,
      'isDay': instance.isDay,
      'tempUnitsMetric': instance.tempUnitsMetric,
    };
