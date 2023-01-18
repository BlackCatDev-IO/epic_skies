import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/conversions/unit_converter.dart';

part 'daily_forecast_model.freezed.dart';
part 'daily_forecast_model.g.dart';

@freezed
class DailyForecastModel with _$DailyForecastModel {
  factory DailyForecastModel({
    required int dailyTemp,
    required int feelsLikeDay,
    required int? highTemp,
    required int? lowTemp,
    required num precipitationAmount,
    required int windSpeed,
    required num precipitationProbability,
    required String precipitationType,
    required String iconPath,
    required String day,
    required String month,
    required String year,
    required String date,
    required String condition,
    required String tempUnit,
    required String speedUnit,
    required String precipUnit,
    required String? extendedHourlyForecastKey,
    required String? precipIconPath,
    required SunTimesModel suntime,
  }) = _DailyForecastModel;

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastModelFromJson(json);

  factory DailyForecastModel.fromWeatherData({
    required DailyData data,
    required int index,
    required DateTime currentTime,
    required String? hourlyKey,
    required SunTimesModel suntime,
    required UnitSettings unitSettings,
  }) {
    DateTimeFormatter.initNextDay(i: index, currentTime: currentTime);

    final dailyCondition = data.condition;

    final today = currentTime.weekday;

    final iconImagePath = IconController.getIconImagePath(
      condition: dailyCondition,
      temp: data.temp,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
      isDay:
          true, // DailyForecastWidget always shows the day version of the icon
    );

    return DailyForecastModel(
      dailyTemp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLikeDay: UnitConverter.convertTemp(
        temp: data.feelslike,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      highTemp: data.tempMax,
      lowTemp: data.tempMin,
      precipitationAmount: _initPrecipAmount(
        precipIntensity: data.precipAmount,
        precipInMm: unitSettings.precipInMm,
      ),
      precipUnit: unitSettings.precipInMm ? 'mm' : 'in',
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      precipitationProbability: data.precipitationProbability!.round(),
      precipitationType: data.precipitationType?[0] as String? ?? '',
      iconPath: iconImagePath,
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      tempUnit: unitSettings.tempUnitsMetric ? 'C' : 'F',
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      extendedHourlyForecastKey: hourlyKey,
      suntime: suntime,
      precipIconPath: data.precipitationType == null
          ? null
          : IconController.getPrecipIconPath(
              precipType: data.precipitationType![0]! as String,
            ),
    );
  }

  static num _initPrecipAmount({
    num? precipIntensity,
    required bool precipInMm,
  }) {
    final precip = precipIntensity ?? 0.0;

    final convertedPreceip = UnitConverter.convertPrecipUnits(
      precip: precip,
      precipInMm: precipInMm,
    );

    return num.parse(convertedPreceip.toStringAsFixed(2));
  }
}
