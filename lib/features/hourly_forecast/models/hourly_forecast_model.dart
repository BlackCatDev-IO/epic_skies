import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/conversions/unit_converter.dart';
import '../../../utils/formatters/date_time_formatter.dart';
import '../../../utils/timezone/timezone_util.dart';

part 'hourly_forecast_model.freezed.dart';
part 'hourly_forecast_model.g.dart';

@freezed
class HourlyForecastModel with _$HourlyForecastModel {
  factory HourlyForecastModel({
    required int temp,
    required int feelsLike,
    required num precipitationAmount,
    required num precipitationProbability,
    required int windSpeed,
    required String iconPath,
    required String time,
    required String precipitationType,
    required String precipUnit,
    required String speedUnit,
    required String condition,
  }) = _HourlyForecastModel;

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastModelFromJson(json);

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
}
