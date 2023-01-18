import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:equatable/equatable.dart';

import '../../utils/conversions/unit_converter.dart';
import '../../utils/timezone/timezone_util.dart';

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
    required HourlyData data,
    required String iconPath,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final time = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.startTimeEpochInSeconds,
      searchIsLocal: searchIsLocal,
    );
    return HourlyVerticalWidgetModel(
      temp: UnitConverter.convertTemp(
        temp: data.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitation: data.precipitationProbability!,
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
    );
  }

  @override
  List<Object?> get props => [temp, iconPath, precipitation, time];
}
