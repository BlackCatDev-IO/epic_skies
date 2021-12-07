import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/storage_getters/settings.dart';
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
    required int index,
  }) {
    final convertedTemp = Settings.tempUnitsCelcius
        ? UnitConverter.toCelcius(temp: data.temperature)
        : data.temperature;

    final iconPath = IconController.getIconImagePath(
      index: index,
      time: data.startTime,
      condition: WeatherCodeConverter.getConditionFromWeatherCode(
        data.weatherCode,
      ),
      temp: convertedTemp,
    );

    return HourlyVerticalWidgetModel(
      temp: convertedTemp,
      precipitation: data.precipitationIntensity.round(),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(time: data.startTime),
    );
  }

  @override
  List<Object?> get props => [temp, iconPath, precipitation, time];
}
