import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/conversions/unit_converter.dart';

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
    required this.precipitationCode,
    required this.precipitationAmount,
    required this.precipitationProbability,
    required this.windSpeed,
  });

  final int temp;
  final int feelsLike;
  final int precipitationCode;

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
    required WeatherData data,
    required String iconPath,
    required UnitSettings unitSettings,
  }) {
    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelsLikeTemp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: data.precipitationIntensity,
      precipitationCode: data.precipitationType,
      precipUnit: unitSettings.precipInMm ? 'mm' : 'in',
      precipitationProbability: data.precipitationProbability.round(),
      windSpeed: UnitConverter.convertSpeed(
        speed: data.temperature,
        speedInKph: unitSettings.tempUnitsMetric,
      ),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: data.startTime,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
      precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
        code: data.precipitationType,
      ),
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      condition:
          WeatherCodeConverter.getConditionFromWeatherCode(data.weatherCode),
    );
  }

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        precipitationAmount,
        precipitationCode,
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
