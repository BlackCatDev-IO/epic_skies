// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_scroll_widget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyScrollWidgetModel _$$_DailyScrollWidgetModelFromJson(
        Map<String, dynamic> json) =>
    _$_DailyScrollWidgetModel(
      header: json['header'] as String,
      iconPath: json['iconPath'] as String,
      month: json['month'] as String,
      date: json['date'] as String,
      temp: json['temp'] as int,
      precipitation: json['precipitation'] as num,
      index: json['index'] as int,
    );

Map<String, dynamic> _$$_DailyScrollWidgetModelToJson(
        _$_DailyScrollWidgetModel instance) =>
    <String, dynamic>{
      'header': instance.header,
      'iconPath': instance.iconPath,
      'month': instance.month,
      'date': instance.date,
      'temp': instance.temp,
      'precipitation': instance.precipitation,
      'index': instance.index,
    };
