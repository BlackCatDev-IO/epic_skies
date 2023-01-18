import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/conversions/unit_converter.dart';
import '../../../utils/formatters/date_time_formatter.dart';
import '../../../utils/timezone/timezone_util.dart';

class HourlyForecastModel extends Equatable {
  const HourlyForecastModel({
    required this.iconPath,
    required this.time,
    required this.feelsLike,
    required this.precipitationType,
    required this.precipUnit,
    required this.speedUnit,
    required this.condition,
    required this.temp,
    required this.precipitationAmount,
    required this.precipitationProbability,
    required this.windSpeed,
  });

  final int temp;
  final int feelsLike;

  final num precipitationAmount;
  final num precipitationProbability;
  final int windSpeed;

  final String iconPath;
  final String time;
  final String precipitationType;
  final String precipUnit;
  final String speedUnit;
  final String condition;

  factory HourlyForecastModel.fromWeatherData({
    required HourlyData data,
    required String iconPath,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final time = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.startTimeEpochInSeconds,
      searchIsLocal: searchIsLocal,
    );
    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelsLike,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: data.precipitationIntensity!,
      precipUnit: unitSettings.precipInMm ? 'mm' : 'in',
      precipitationProbability: data.precipitationProbability!,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
      precipitationType: data.precipitationType?[0] as String? ?? '',
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      condition: data.condition,
    );
  }

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        precipitationAmount,
        precipUnit,
        precipitationProbability,
        windSpeed,
        iconPath,
        time,
        precipitationType,
        speedUnit,
        condition
      ];
}
