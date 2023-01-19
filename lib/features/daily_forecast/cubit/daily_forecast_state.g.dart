// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'daily_forecast_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyForecastState _$$_DailyForecastStateFromJson(
  Map<String, dynamic> json,
) =>
    _$_DailyForecastState(
      dayColumnModelList: (json['dayColumnModelList'] as List<dynamic>)
          .map(
            (e) => DailyScrollWidgetModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      dailyForecastModelList: (json['dailyForecastModelList'] as List<dynamic>)
          .map((e) => DailyForecastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      week1NavButtonList: (json['week1NavButtonList'] as List<dynamic>)
          .map((e) => DailyNavButtonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      week2NavButtonList: (json['week2NavButtonList'] as List<dynamic>)
          .map((e) => DailyNavButtonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dayLabelList: (json['dayLabelList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      selectedDayList: (json['selectedDayList'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
      selectedDayIndex: json['selectedDayIndex'] as int,
    );

Map<String, dynamic> _$$_DailyForecastStateToJson(
  _$_DailyForecastState instance,
) =>
    <String, dynamic>{
      'dayColumnModelList': instance.dayColumnModelList,
      'dailyForecastModelList': instance.dailyForecastModelList,
      'week1NavButtonList': instance.week1NavButtonList,
      'week2NavButtonList': instance.week2NavButtonList,
      'dayLabelList': instance.dayLabelList,
      'selectedDayList': instance.selectedDayList,
      'selectedDayIndex': instance.selectedDayIndex,
    };
