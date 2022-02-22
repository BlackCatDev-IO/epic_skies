import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

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
  }) {
    return HourlyForecastModel(
      temp: data.temperature,
      feelsLike: data.feelsLikeTemp,
      precipitationAmount: data.precipitationIntensity,
      precipitationCode: data.precipitationType,
      precipUnit: data.unitSettings.precipInMm ? 'mm' : 'in',
      precipitationProbability: data.precipitationProbability.round(),
      windSpeed: data.windSpeed,
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: data.startTime,
        timeIn24hrs: data.unitSettings.timeIn24Hrs,
      ),
      precipitationType: WeatherCodeConverter.getPrecipitationTypeFromCode(
        code: data.precipitationType,
      ),
      speedUnit: data.unitSettings.speedInKph ? 'kph' : 'mph',
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
