import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/conversions/unit_converter.dart';
import '../../../../utils/timezone/timezone_util.dart';
import '../../../main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';

part 'hourly_vertical_widget_model.freezed.dart';
part 'hourly_vertical_widget_model.g.dart';

@freezed
class HourlyVerticalWidgetModel with _$HourlyVerticalWidgetModel {
  factory HourlyVerticalWidgetModel({
    required int temp,
    required String iconPath,
    required num precipitation,
    required String time,
    String? suntimeString,
    bool? isSunrise,
  }) = _HourlyVerticalWidgetModel;

  factory HourlyVerticalWidgetModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyVerticalWidgetModelFromJson(json);

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
      precipitation: data.precipprob ?? 0,
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
    );
  }
}
