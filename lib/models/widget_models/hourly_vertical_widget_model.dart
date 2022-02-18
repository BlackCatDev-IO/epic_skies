import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

class HourlyVerticalWidgetModel extends Equatable {
  final int temp;
  final String iconPath;
  final num precipitation;
  final String time;

  const HourlyVerticalWidgetModel({
    required this.temp,
    required this.iconPath,
    required this.precipitation,
    required this.time,
  });

  factory HourlyVerticalWidgetModel.fromWeatherData({
    required WeatherData data,
    required String iconPath,
  }) {
    return HourlyVerticalWidgetModel(
      temp: data.temperature,
      precipitation: data.precipitationProbability.round(),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: data.startTime,
        timeIn24hrs: data.unitSettings.timeIn24Hrs,
      ),
    );
  }

  @override
  List<Object?> get props => [temp, iconPath, precipitation, time];
}
