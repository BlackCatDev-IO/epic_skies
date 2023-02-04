// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_vertical_widget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HourlyVerticalWidgetModel _$$_HourlyVerticalWidgetModelFromJson(
        Map<String, dynamic> json) =>
    _$_HourlyVerticalWidgetModel(
      temp: json['temp'] as int,
      iconPath: json['iconPath'] as String,
      precipitation: json['precipitation'] as int,
      time: json['time'] as String,
      suntimeString: json['suntimeString'] as String?,
      isSunrise: json['isSunrise'] as bool?,
    );

Map<String, dynamic> _$$_HourlyVerticalWidgetModelToJson(
        _$_HourlyVerticalWidgetModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'iconPath': instance.iconPath,
      'precipitation': instance.precipitation,
      'time': instance.time,
      'suntimeString': instance.suntimeString,
      'isSunrise': instance.isSunrise,
    };
