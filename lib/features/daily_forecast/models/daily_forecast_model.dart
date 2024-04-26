// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';

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
    required this.extendedHourlyList,
    this.highTemp,
    this.lowTemp,
    this.precipIconPath,
  });

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
  final int date;
  final String condition;
  final String? precipIconPath;
  final SunTimesModel suntime;
  final List<HourlyForecastModel> extendedHourlyList;

  factory DailyForecastModel.fromWeatherKit({
    required DayWeatherConditions data,
    required int index,
    required DateTime currentTime,
    required SunTimesModel suntime,
    required UnitSettings unitSettings,
    required List<HourlyForecastModel> hourlyList,
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

    final precipAmount = _initPrecipAmount(
      hourlyList: hourlyList,
      precipInMm: unitSettings.precipInMm,
    );

    final precipProbability = _precipProbability(hourlyList);

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
      precipitationAmount: precipAmount,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.daytimeForecast?.windSpeed ?? 0,
        speedInKph: unitSettings.speedInKph,
      ),
      precipitationProbability: precipProbability,
      precipitationType: _precipType(
        precipAmount,
        precipProbability,
        data.precipitationType,
      ),
      iconPath: iconImagePath,
      day: DateTimeFormatter.getNext7Days(
        day: currentTime.weekday + index,
        today: today,
      ),
      month: DateTimeFormatter.getNextDaysMonth(),
      year: DateTimeFormatter.getNextDaysYear(),
      date: DateTimeFormatter.getNextDaysDate(),
      condition: WeatherCodeConverter.convertWeatherKitCodes(dailyCondition),
      extendedHourlyList: hourlyList,
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
    required List<HourlyForecastModel> extendedHourlyList,
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
        hourlyList: extendedHourlyList,
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

  static String _precipType(num amount, num probability, String precip) {
    if (precip == 'clear') return 'none';

    if (amount == 0.0 && probability == 0.0 && precip == 'rain') {
      return 'none';
    }

    return precip;
  }

  static int _precipProbability(List<HourlyForecastModel> hourlyList) {
    final precipChanceList =
        hourlyList.map((hourly) => hourly.precipitationProbability).toList();

    final precipChanceSum = precipChanceList.reduce((a, b) => a + b);

    return (precipChanceSum / precipChanceList.length).round();
  }

  static int _getDailyAverage(num high, num low) {
    return ((high + low) / 2).round();
  }

  static num _initPrecipAmount({
    required bool precipInMm,
    required List<HourlyForecastModel> hourlyList,
  }) {
    final precipAmountList =
        hourlyList.map((hourly) => hourly.precipitationAmount).toList();

    final precipSum = precipAmountList.reduce((a, b) => a + b);

    final convertedPrecip = UnitConverter.convertPrecipUnits(
      precip: precipSum / precipAmountList.length,
      precipInMm: precipInMm,
    );

    return num.parse(convertedPrecip.toStringAsFixed(2));
  }

  static const fromMap = DailyForecastModelMapper.fromMap;
}
