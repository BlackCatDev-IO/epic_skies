import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
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

  factory HourlyVerticalWidgetModel.fromInterval({
    required WeatherData data,
    required int index,
  }) {
    final tempUnitsMetric =
        StorageController.to.settingsMap[tempUnitsMetricKey] as bool;

    final convertedTemp = tempUnitsMetric
        ? UnitConverter.toCelcius(temp: data.temperature)
        : data.temperature;

    final iconPath = IconController.getIconImagePath(
      index: index,
      hourly: true,
      time: data.startTime,
      condition: WeatherCodeConverter.getConditionFromWeatherCode(
        data.weatherCode,
      ),
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
