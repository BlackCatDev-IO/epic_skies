// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'daily_forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyForecastModel _$$_DailyForecastModelFromJson(
  Map<String, dynamic> json,
) =>
    _$_DailyForecastModel(
      dailyTemp: json['dailyTemp'] as int,
      feelsLikeDay: json['feelsLikeDay'] as int,
      highTemp: json['highTemp'] as int?,
      lowTemp: json['lowTemp'] as int?,
      precipitationAmount: json['precipitationAmount'] as num,
      windSpeed: json['windSpeed'] as int,
      precipitationProbability: json['precipitationProbability'] as num,
      precipitationType: json['precipitationType'] as String,
      iconPath: json['iconPath'] as String,
      day: json['day'] as String,
      month: json['month'] as String,
      year: json['year'] as String,
      date: json['date'] as String,
      condition: json['condition'] as String,
      tempUnit: json['tempUnit'] as String,
      speedUnit: json['speedUnit'] as String,
      precipUnit: json['precipUnit'] as String,
      precipIconPath: json['precipIconPath'] as String?,
      suntime: SunTimesModel.fromJson(json['suntime'] as Map<String, dynamic>),
      extendedHourlyList: (json['extendedHourlyList'] as List<dynamic>?)
          ?.map(
            (e) =>
                HourlyVerticalWidgetModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$$_DailyForecastModelToJson(
  _$_DailyForecastModel instance,
) =>
    <String, dynamic>{
      'dailyTemp': instance.dailyTemp,
      'feelsLikeDay': instance.feelsLikeDay,
      'highTemp': instance.highTemp,
      'lowTemp': instance.lowTemp,
      'precipitationAmount': instance.precipitationAmount,
      'windSpeed': instance.windSpeed,
      'precipitationProbability': instance.precipitationProbability,
      'precipitationType': instance.precipitationType,
      'iconPath': instance.iconPath,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'date': instance.date,
      'condition': instance.condition,
      'tempUnit': instance.tempUnit,
      'speedUnit': instance.speedUnit,
      'precipUnit': instance.precipUnit,
      'precipIconPath': instance.precipIconPath,
      'suntime': instance.suntime,
      'extendedHourlyList': instance.extendedHourlyList,
    };
