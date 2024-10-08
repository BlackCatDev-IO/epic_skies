// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/hour_weather_conditions.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';

part 'hourly_forecast_model.mapper.dart';

@MappableClass()
class HourlyForecastModel with HourlyForecastModelMappable {
  HourlyForecastModel({
    required this.temp,
    required this.feelsLike,
    required this.precipitationAmount,
    required this.precipitationProbability,
    required this.windSpeed,
    required this.iconPath,
    required this.time,
    required this.precipitationType,
    required this.condition,
    this.suntime,
    this.isSunrise,
  });

  final int temp;
  final int feelsLike;
  final num precipitationAmount;
  final num precipitationProbability;
  final int windSpeed;
  final String iconPath;
  final DateTime time;
  final DateTime? suntime;
  final String precipitationType;
  final String condition;
  final bool? isSunrise;

  factory HourlyForecastModel.fromWeatherKitData({
    required String iconPath,
    required UnitSettings unitSettings,
    required HourWeatherConditions hourlyData,
    required DateTime time,
  }) {
    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: hourlyData.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: hourlyData.temperatureApparent,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: _precipAmount(
        precip: hourlyData.precipitationAmount,
        precipInMm: unitSettings.precipInMm,
      ),
      precipitationProbability: (hourlyData.precipitationChance * 100).toInt(),
      windSpeed: UnitConverter.convertSpeed(
        speed: hourlyData.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: time,
      precipitationType: hourlyData.precipitationType,
      condition:
          WeatherCodeConverter.convertWeatherKitCodes(hourlyData.conditionCode),
    );
  }

  factory HourlyForecastModel.fromVisualCrossing({
    required HourlyData data,
    required String iconPath,
    required WeatherState weatherState,
  }) {
    final offset =
        Duration(milliseconds: weatherState.refTimes.timezoneOffsetInMs);
    final time = DateTime.fromMillisecondsSinceEpoch(data.datetimeEpoch * 1000)
        .toUtc()
        .add(offset);

    var condition = data.conditions;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }

    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: weatherState.unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelslike,
        tempUnitsMetric: weatherState.unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: data.precip?.round() ?? 0,
      precipitationProbability: data.precipprob?.round() ?? 0,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: weatherState.unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: time,
      precipitationType: data.preciptype?[0] as String? ?? '',
      condition: condition,
    );
  }

  static num _precipAmount({required num? precip, required bool precipInMm}) {
    final convertedPrecip = UnitConverter.convertPrecipUnits(
      precip: precip ?? 0,
      precipInMm: precipInMm,
    );

    if (precip == 0.0 || precip == 0) {
      return 0;
    }

    final roundedNum = num.parse(convertedPrecip.toStringAsFixed(1));
    // If the rounded precipitation amount is 0.0, return 0.1 to avoid showing
    // 0.0 when the probably of precipitation is greater than 0
    if (roundedNum == 0.0) {
      return 0.1;
    }

    return roundedNum;
  }
}
