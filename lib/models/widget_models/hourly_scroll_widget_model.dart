import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
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
    required TimestepInterval interval,
    required int index,
  }) {
    final iconPath = IconController.getIconImagePath(
      index: index,
      hourly: true,
      time: interval.startTime,
      condition: WeatherCodeConverter.getConditionFromWeatherCode(
        interval.data.weatherCode,
      ),
    );

    return HourlyVerticalWidgetModel(
      temp: interval.data.temperature,
      precipitation: interval.data.precipitationIntensity.round(),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(time: interval.startTime),
    );
  }

  @override
  List<Object?> get props => [temp, iconPath, precipitation, time];
}
