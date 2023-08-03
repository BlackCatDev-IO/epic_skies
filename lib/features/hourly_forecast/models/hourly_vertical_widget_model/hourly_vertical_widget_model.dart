import 'package:dart_mappable/dart_mappable.dart';

import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

part 'hourly_vertical_widget_model.mapper.dart';

@MappableClass()
class HourlyVerticalWidgetModel with HourlyVerticalWidgetModelMappable {
  HourlyVerticalWidgetModel({
    required this.temp,
    required this.iconPath,
    required this.precipitation,
    required this.time,
    this.suntimeString,
    this.isSunrise,
  });

  factory HourlyVerticalWidgetModel.fromWeatherData({
    required HourlyData data,
    required String iconPath,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final time = TimeZoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.datetimeEpoch,
      searchIsLocal: searchIsLocal,
    );
    return HourlyVerticalWidgetModel(
      temp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitation: (data.precipprob)?.toInt() ?? 0,
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
    );
  }

  final int temp;
  final String iconPath;
  final int precipitation;
  final String time;
  final String? suntimeString;
  final bool? isSunrise;
}
