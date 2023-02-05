import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String speedUnit,
    required String precipUnit,
    required String? precipIconPath,
    required SunTimesModel suntime,
    List<HourlyVerticalWidgetModel>? extendedHourlyList,
  }) = _DailyForecastModel;

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastModelFromJson(json);

  factory DailyForecastModel.fromWeatherData({
    required DailyData data,
    required int index,
    required DateTime currentTime,
    required SunTimesModel suntime,
    required UnitSettings unitSettings,
    List<HourlyVerticalWidgetModel>? extendedHourlyList,
  }) {
    DateTimeFormatter.initNextDay(i: index, currentTime: currentTime);

    var dailyCondition = data.conditions;

    /// condition string from API can have more than one word
    if (dailyCondition.contains(',')) {
      final commaIndex = dailyCondition.indexOf(',');
      dailyCondition = dailyCondition.substring(0, commaIndex);
    }
    final today = currentTime.weekday;

    final iconImagePath = IconController.getIconImagePath(
      condition: dailyCondition,
      temp: data.temp.round(),
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
      highTemp: data.tempmax?.round(),
      lowTemp: data.tempmin?.round(),
      precipitationAmount: _initPrecipAmount(
        precipIntensity: data.precip,
        precipInMm: unitSettings.precipInMm,
      ),
      precipUnit: unitSettings.precipInMm ? 'mm' : 'in',
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: unitSettings.speedInKph,
      ),
      precipitationProbability: data.precipprob!.round(),
      precipitationType: data.preciptype?[0] as String? ?? '',
      iconPath: iconImagePath,
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      speedUnit: unitSettings.speedInKph ? 'kph' : 'mph',
      extendedHourlyList: extendedHourlyList,
      suntime: suntime,
      precipIconPath: data.preciptype == null
          ? null
          : IconController.getPrecipIconPath(
              precipType: data.preciptype![0]! as String,
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
