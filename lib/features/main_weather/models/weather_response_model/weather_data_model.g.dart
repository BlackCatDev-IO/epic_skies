// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'weather_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherResponseModel _$$_WeatherResponseModelFromJson(
        Map<String, dynamic> json,) =>
    _$_WeatherResponseModel(
      currentCondition: CurrentData.fromJson(
          json['currentCondition'] as Map<String, dynamic>,),
      days: (json['days'] as List<dynamic>)
          .map((e) => DailyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      queryCost: json['queryCost'] as num?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      resolvedAddress: json['resolvedAddress'] as String?,
      address: json['address'] as String?,
      timezone: json['timezone'] as String?,
      tzoffset: json['tzoffset'] as int?,
    );

Map<String, dynamic> _$$_WeatherResponseModelToJson(
        _$_WeatherResponseModel instance,) =>
    <String, dynamic>{
      'currentCondition': instance.currentCondition,
      'days': instance.days,
      'description': instance.description,
      'queryCost': instance.queryCost,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'resolvedAddress': instance.resolvedAddress,
      'address': instance.address,
      'timezone': instance.timezone,
      'tzoffset': instance.tzoffset,
    };
