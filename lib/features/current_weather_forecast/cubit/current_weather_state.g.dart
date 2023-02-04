// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentWeatherState _$$_CurrentWeatherStateFromJson(
        Map<String, dynamic> json) =>
    _$_CurrentWeatherState(
      currentTimeString: json['currentTimeString'] as String,
      data: json['data'] == null
          ? null
          : CurrentWeatherModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CurrentWeatherStateToJson(
        _$_CurrentWeatherState instance) =>
    <String, dynamic>{
      'currentTimeString': instance.currentTimeString,
      'data': instance.data,
    };
