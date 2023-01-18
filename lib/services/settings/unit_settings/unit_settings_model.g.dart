// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'unit_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UnitSettings _$$_UnitSettingsFromJson(Map<String, dynamic> json) =>
    _$_UnitSettings(
      tempUnitsMetric: json['tempUnitsMetric'] as bool,
      timeIn24Hrs: json['timeIn24Hrs'] as bool,
      precipInMm: json['precipInMm'] as bool,
      speedInKph: json['speedInKph'] as bool,
    );

Map<String, dynamic> _$$_UnitSettingsToJson(_$_UnitSettings instance) =>
    <String, dynamic>{
      'tempUnitsMetric': instance.tempUnitsMetric,
      'timeIn24Hrs': instance.timeIn24Hrs,
      'precipInMm': instance.precipInMm,
      'speedInKph': instance.speedInKph,
    };
