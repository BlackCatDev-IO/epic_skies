import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';

import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

part 'daily_forecast_model.mapper.dart';

@MappableClass()
class DailyForecastModel with DailyForecastModelMappable {
  DailyForecastModel({
    required this.dailyTemp,
    required this.feelsLikeDay,
    required this.precipitationAmount,
    required this.windSpeed,
    required this.precipitationProbability,
    required this.precipitationType,
    required this.iconPath,
    required this.day,
    required this.month,
    required this.year,
    required this.date,
    required this.condition,
    required this.suntime,
    this.highTemp,
    this.lowTemp,
    this.precipIconPath,
    this.extendedHourlyList,
  });

  factory DailyForecastModel.fromWeatherKitDaily({
    required DayWeatherConditions data,
    required int index,
    required DateTime currentTime,
    required SunTimesModel suntime,
    required UnitSettings unitSettings,
    List<HourlyVerticalWidgetModel>? extendedHourlyList,
  }) {
    DateTimeFormatter.initNextDay(i: index, currentTime: currentTime);

    final temp = _getDailyAverage(data.temperatureMax, data.temperatureMin);

    final dailyCondition = data.conditionCode;

    final today = currentTime.weekday;

    final iconImagePath = IconController.getIconImagePath(
      condition: dailyCondition,
      temp: temp,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
      isDay:
          true, // DailyForecastWidget always shows the day version of the icon
    );

    return DailyForecastModel(
      dailyTemp: UnitConverter.convertTemp(
        temp: temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLikeDay: UnitConverter.convertTemp(
        temp: temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      highTemp: UnitConverter.convertTemp(
        temp: data.temperatureMax.round(),
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      lowTemp: UnitConverter.convertTemp(
        temp: data.temperatureMin.round(),
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: _initPrecipAmount(
        precipIntensity: data.precipitationAmount,
        precipInMm: unitSettings.precipInMm,
      ),
      windSpeed: UnitConverter.convertSpeed(
        speed: data.daytimeForecast?.windSpeed ?? 0,
        speedInKph: unitSettings.speedInKph,
      ),
      precipitationProbability: data.precipitationChance.round(),
      precipitationType: data.precipitationType,
      iconPath: iconImagePath,
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: WeatherCodeConverter.convertWeatherKitCodes(dailyCondition),
      extendedHourlyList: extendedHourlyList,
      suntime: suntime,
      precipIconPath: IconController.getPrecipIconPath(
        precipType: data.precipitationType,
      ),
    );
  }

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

    var precipType = data.preciptype?[0] as String? ?? '';
    if (precipType == 'freezingrain') {
      precipType = 'freezing rain';
    }

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
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: unitSettings.speedInKph,
      ),
      precipitationProbability: data.precipprob!.round(),
      precipitationType: precipType,
      iconPath: iconImagePath,
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: dailyCondition,
      extendedHourlyList: extendedHourlyList,
      suntime: suntime,
      precipIconPath: data.preciptype == null
          ? null
          : IconController.getPrecipIconPath(
              precipType: data.preciptype![0]! as String,
            ),
    );
  }

  final int dailyTemp;
  final int feelsLikeDay;
  final int? highTemp;
  final int? lowTemp;
  final num precipitationAmount;
  final int windSpeed;
  final num precipitationProbability;
  final String precipitationType;
  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String condition;
  final String? precipIconPath;
  final SunTimesModel suntime;
  final List<HourlyVerticalWidgetModel>? extendedHourlyList;

  static int _getDailyAverage(num high, num low) {
    return ((high + low) / 2).round();
  }

  static num _initPrecipAmount({
    required bool precipInMm,
    num? precipIntensity,
  }) {
    final precip = precipIntensity ?? 0.0;

    final convertedPreceip = UnitConverter.convertPrecipUnits(
      precip: precip,
      precipInMm: precipInMm,
    );

    return num.parse(convertedPreceip.toStringAsFixed(2));
  }

  static const fromMap = DailyForecastModelMapper.fromMap;
}
