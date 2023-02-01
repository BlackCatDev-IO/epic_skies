// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorted_hourly_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SortedHourlyList _$$_SortedHourlyListFromJson(Map<String, dynamic> json) =>
    _$_SortedHourlyList(
      next24Hours: (json['next24Hours'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      day1: (json['day1'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      day2: (json['day2'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      day3: (json['day3'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      day4: (json['day4'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_SortedHourlyListToJson(_$_SortedHourlyList instance) =>
    <String, dynamic>{
      'next24Hours': instance.next24Hours,
      'day1': instance.day1,
      'day2': instance.day2,
      'day3': instance.day3,
      'day4': instance.day4,
    };
