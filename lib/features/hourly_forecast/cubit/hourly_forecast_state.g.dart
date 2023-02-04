// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HourlyForecastState _$$_HourlyForecastStateFromJson(
        Map<String, dynamic> json) =>
    _$_HourlyForecastState(
      houryForecastModelList: (json['houryForecastModelList'] as List<dynamic>?)
              ?.map((e) =>
                  HourlyForecastModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sortedHourlyList: json['sortedHourlyList'] == null
          ? const SortedHourlyList()
          : SortedHourlyList.fromJson(
              json['sortedHourlyList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_HourlyForecastStateToJson(
        _$_HourlyForecastState instance) =>
    <String, dynamic>{
      'houryForecastModelList': instance.houryForecastModelList,
      'sortedHourlyList': instance.sortedHourlyList,
    };
