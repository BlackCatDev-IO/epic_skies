import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
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

  final _weatherCodeConverter = const WeatherCodeConverter();
  final _dateFormatter = DateTimeFormatter();
  final _iconController = IconController();
  final _unitConverter = UnitConverter();

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

  DateTime now,
      tomorrowSunset,
      tomorrowSunrise,
      day2Sunset,
      day2Sunrise,
      day3Sunset,
      day3Sunrise,
      day4Sunset,
      day4Sunrise;

  Duration timezoneOffset;

  int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;

  num precipitationAmount, windSpeed;

  Future<void> buildDailyForecastWidgets() async {
    dataMap = StorageController.to.dataMap;
    now = DateTime.now();
    today = now.weekday;
    timezoneOffset = TimeZoneController.to.timezoneOffset;
    _clearWidgetLists();
    _builDailyWidgets();
    update();
  }

  void _builDailyWidgets() {
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
    int interval = i;

    // between 12am and 6am day @ index 0 is yesterday due
    // to Tomorrow.io defining days from 6am to 6am, this accounts for that
    if (now.hour.isInRange(0, 6)) {
      interval++;
    }
    valuesMap =
        dataMap['timelines'][1]['intervals'][interval + 1]['values'] as Map;

    _initTempAndConditions();
    _initAndFormatSunTimes();
    _initPrecipValues();

    windSpeed = _unitConverter
        .convertFeetPerSecondToMph(valuesMap['windSpeed'] as num);

    _handlePotentialConversions(i);

    iconPath = _iconController.getIconImagePath(
        condition: dailyCondition, origin: 'Daily');
  }

  void _initAndFormatSunTimes() {
    final sunriseTime =
        DateTime.parse(valuesMap['sunriseTime'] as String).add(timezoneOffset);
    final sunsetTime =
        DateTime.parse(valuesMap['sunsetTime'] as String).add(timezoneOffset);
    sunrise = _dateFormatter.formatFullTime(sunriseTime);
    sunset = _dateFormatter.formatFullTime(sunsetTime);
  }

  void _initPrecipValues() {
    precipitationCode = valuesMap['precipitationType'] as int;
    precipitationType =
        _weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = valuesMap['precipitationIntensity'] ?? 0.0;

    precipitation = valuesMap['precipitationProbability'].round().toString();
    precipitationAmount =
        _unitConverter.roundTo2digitsPastDecimal(precip as num);
  }

  void _initTempAndConditions() {
    weatherCode = valuesMap['weatherCode'] as int;
    dailyCondition =
        _weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = valuesMap['temperature'].round() as int;
    feelsLikeDay = valuesMap['temperatureApparent'].round() as int;
  }

  void _handlePotentialConversions(int i) {
    if (SettingsController.to.precipInMm) {
      precipitationAmount =
          _unitConverter.convertInchesToMillimeters(precipitationAmount);
    }

    if (SettingsController.to.tempUnitsMetric) {
      dailyTemp = _unitConverter.toCelcius(dailyTemp);
    }

    if (SettingsController.to.speedInKm) {
      windSpeed = _unitConverter.convertMilesToKph(windSpeed);
    }
  }

  void _formatDates(int i) {
    _dateFormatter.initNextDay(i);
    day = _dateFormatter.getNext7Days(today + i + 1);
    date = _dateFormatter.getNextDaysDate();
    month = _dateFormatter.getNextDaysMonth();
    year = _dateFormatter.getNextDaysYear();
  }

  void _clearWidgetLists() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();
  }
}
