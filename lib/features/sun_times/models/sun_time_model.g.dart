// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'sun_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SunTimesModel _$$_SunTimesModelFromJson(Map<String, dynamic> json) =>
    _$_SunTimesModel(
      sunsetString: json['sunsetString'] as String,
      sunriseString: json['sunriseString'] as String,
      sunriseTime: json['sunriseTime'] == null
          ? null
          : DateTime.parse(json['sunriseTime'] as String),
      sunsetTime: json['sunsetTime'] == null
          ? null
          : DateTime.parse(json['sunsetTime'] as String),
    );

Map<String, dynamic> _$$_SunTimesModelToJson(_$_SunTimesModel instance) =>
    <String, dynamic>{
      'sunsetString': instance.sunsetString,
      'sunriseString': instance.sunriseString,
      'sunriseTime': instance.sunriseTime?.toIso8601String(),
      'sunsetTime': instance.sunsetTime?.toIso8601String(),
    };
