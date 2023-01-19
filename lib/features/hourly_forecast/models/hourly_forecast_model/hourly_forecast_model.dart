import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/conversions/unit_converter.dart';
import '../../../../utils/formatters/date_time_formatter.dart';
import '../../../../utils/timezone/timezone_util.dart';
import '../../../main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';

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
      secondsSinceEpoch: data.datetimeEpoch,
      searchIsLocal: searchIsLocal,
    );

    String condition = data.conditions;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }

    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelslike,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: data.precip?.round() ?? 0,
      precipUnit: unitSettings.precipInMm ? 'mm' : 'in',
      precipitationProbability: data.precipprob?.round() ?? 0,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: unitSettings.timeIn24Hrs,
      ),
      precipitationType: data.preciptype?[0] as String? ?? '',
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      condition: condition,
    );
  }
}
