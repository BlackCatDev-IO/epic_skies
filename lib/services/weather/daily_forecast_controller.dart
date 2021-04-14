import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/daily_detail_widget.dart';
import 'package:epic_skies/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'hourly_forecast_controller.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  final conversionController = ConversionController();

  List<Widget> dayColumnList = [];
  List<Widget> dayDetailedWidgetList = [];
  List<String> dayLabelList = [];

  Map dataMap = {};
  Map valuesMap = {};

  String precipitation,
      tempNight,
      tempMin,
      tempMax,
      dailyCondition,
      iconPath,
      nextDay,
      feelsLikeNight,
      precipitationType,
      date,
      month,
      year,
      day,
      sunset,
      sunrise;

  DateTime tomorrowSunset,
      tomorrowSunrise,
      day2Sunset,
      day2Sunrise,
      day3Sunset,
      day3Sunrise,
      day4Sunset,
      day4Sunrise;

  int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;

  num precipitationAmount, windSpeed;

  Future<void> buildDailyForecastWidgets() async {
    dataMap = StorageController.to.dataMap;
    today = DateTime.now().weekday;

    _builDailyWidgets();
    update();
  }

  void _builDailyWidgets() {
    if (dayColumnList.isNotEmpty &&
        dayLabelList.isNotEmpty &&
        dayDetailedWidgetList.isNotEmpty) {
      dayColumnList.clear();
      dayLabelList.clear();
      dayDetailedWidgetList.clear();
    }

    for (int i = 0; i < 7; i++) {
      _initDailyData(i);
      dayLabelList.add(day);

      List<Widget> list;

      final dayColumn = DayColumn(
        day: day,
        iconPath: iconPath,
        temp: dailyTemp,
      );

      if (i.isInRange(0, 3)) {
        list = HourlyForecastController.to.extendedHourlyColumnList[i];
      }

      final dailyDetailWidget = DailyDetailWidget(
        day: day,
        iconPath: iconPath,
        tempDay: dailyTemp,
        tempNight: tempNight,
        tempMin: tempMin,
        tempHigh: tempMax,
        precipitationProbability: precipitation,
        feelsLikeDay: feelsLikeDay,
        feelsLikeNight: feelsLikeNight,
        condition: dailyCondition,
        precipitationCode: precipitationCode,
        precipitationType: precipitationType,
        precipitationAmount: precipitationAmount,
        sunrise: sunrise,
        sunset: sunset,
        month: month,
        date: date,
        year: year,
        tempUnit: SettingsController.to.tempUnitString,
        windSpeed: windSpeed,
        speedUnit: SettingsController.to.speedUnitString,
        list: list,
      );

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
    }
  }

  void _initDailyData(int i) {
    _formatDates(i);
    valuesMap = dataMap['timelines'][1]['intervals'][i + 1]['values'] as Map;
    weatherCode = valuesMap['weatherCode'] as int;
    dailyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = valuesMap['temperature'].round() as int;
    feelsLikeDay = valuesMap['temperatureApparent'].round() as int;
    sunrise = valuesMap['sunriseTime'] as String;
    sunset = valuesMap['sunsetTime'] as String;
    precipitationCode = valuesMap['precipitationType'] as int;
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = valuesMap['precipitationIntensity'] ?? 0.0;

    precipitation = valuesMap['precipitationProbability'].round().toString();
    precipitationAmount =
        conversionController.roundTo2digitsPastDecimal(precip as num);
    windSpeed = conversionController
        .convertFeetPerSecondToMph(valuesMap['windSpeed'] as num);

    _handlePotentialConversions(i);

    iconPath = iconController.getIconImagePath(
        condition: dailyCondition, origin: 'Daily');
  }

  void _handlePotentialConversions(int i) {
    if (SettingsController.to.precipInMm) {
      conversionController.convertDailyPrecipValues(i);
    }

    if (SettingsController.to.tempUnitsMetric) {
      conversionController.convertDailyTempUnits(i);
    }

    if (SettingsController.to.speedInKm) {
      conversionController.convertDailyWindSpeed(i);
    }
  }

  void _initExtendedSunsetAndSunriseTimes() {
    Map map = {};
    final timezoneOffset = TimeZoneController.to.timezoneOffset;

    for (int i = 0; i < 4; i++) {
      map = StorageController.to.dataMap['timelines'][1]['intervals'][i]
          ['values'] as Map;

      switch (i) {
        case 0:
          tomorrowSunset =
              DateTime.parse(map['sunsetTime'] as String).add(timezoneOffset);
          tomorrowSunrise =
              DateTime.parse(map['sunriseTime'] as String).add(timezoneOffset);
          break;
        case 1:
          day2Sunrise =
              DateTime.parse(map['sunriseTime'] as String).add(timezoneOffset);
          day2Sunset =
              DateTime.parse(map['sunsetTime'] as String).add(timezoneOffset);
          break;
        case 2:
          day3Sunrise =
              DateTime.parse(map['sunriseTime'] as String).add(timezoneOffset);
          day3Sunset =
              DateTime.parse(map['sunsetTime'] as String).add(timezoneOffset);
          break;
        case 3:
          day4Sunrise =
              DateTime.parse(map['sunriseTime'] as String).add(timezoneOffset);
          day4Sunset =
              DateTime.parse(map['sunsetTime'] as String).add(timezoneOffset);
          break;
      }
    }
  }

  void _formatDates(int i) {
    dateFormatter.initNextDay(i);
    day = dateFormatter.getNext7Days(today + i + 1);
    date = dateFormatter.getNextDaysDate();
    month = dateFormatter.getNextDaysMonth();
    year = dateFormatter.getNextDaysYear();
  }
}
