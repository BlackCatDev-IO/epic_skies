import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_detail_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weekly_forecast_row.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hourly_forecast_controller.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  final _weatherCodeConverter = const WeatherCodeConverter();
  final _dateFormatter = DateTimeFormatter();
  final _iconController = IconController();
  final _unitConverter = const UnitConverter();

  List<Widget> dayColumnList = [];
  List<Widget> dayDetailedWidgetList = [];
  List<String> dayLabelList = [];

  Map _dataMap = {};
  Map _valuesMap = {};

  late String tempNight,
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

  late DateTime now,
      tomorrowSunset,
      tomorrowSunrise,
      day2Sunset,
      day2Sunrise,
      day3Sunset,
      day3Sunrise,
      day4Sunset,
      day4Sunrise;

  late Duration timezoneOffset;

  late int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;
  int? highTemp, lowTemp;

  late num precipitationAmount, windSpeed, precipitation;

  Future<void> buildDailyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    now = DateTime.now();
    today = now.weekday;
    timezoneOffset = TimeZoneController.to.timezoneOffset!;
    _clearWidgetLists();
    _builDailyWidgets();
    update();
  }

  // stores isSelected bools for DayLabelRow to show selected indicator
  List<bool> selectedDayList = [];

  @override
  void onInit() {
    super.onInit();
    _initSelectedDayList();
  }

  void _builDailyWidgets() {
    for (int i = 0; i < 7; i++) {
      _initDailyData(i);
      dayLabelList.add(day);

      List<Widget>? list;

      final dayColumn = DayColumn(
        day: day,
        iconPath: iconPath,
        temp: dailyTemp,
      );

      // range check is to not go over available 108 hrs of hourly temps
      if (i.isInRange(0, 3)) {
        list = HourlyForecastController.to.extendedHourlyColumnList[i];
      }

      final dailyDetailWidget = DailyDetailWidget(
        day: day,
        iconPath: iconPath,
        tempDay: dailyTemp,
        precipitationProbability: precipitation,
        feelsLikeDay: feelsLikeDay,
        condition: dailyCondition,
        precipitationCode: precipitationCode,
        precipitationType: precipitationType,
        precipitationAmount: precipitationAmount,
        sunrise: sunrise,
        sunset: sunset,
        month: month,
        date: date,
        year: year,
        lowTemp: lowTemp,
        highTemp: highTemp,
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
    _valuesMap =
        _dataMap['timelines'][1]['intervals'][interval + 1]['values'] as Map;

    _initTempAndConditions();
    _initAndFormatSunTimes();
    _initPrecipValues();

    // range check is to not go over available 108 hrs of hourly temps
    if (i.isInRange(0, 3)) {
      _initHighAndLowTemp(i);
    }

    windSpeed = _unitConverter
        .convertFeetPerSecondToMph(_valuesMap['windSpeed'] as num)
        .round();

    _handlePotentialConversions(i);

    iconPath = _iconController.getIconImagePath(
        condition: dailyCondition, origin: 'Daily');
  }

  void _initAndFormatSunTimes() {
    final sunriseTime =
        DateTime.parse(_valuesMap['sunriseTime'] as String).add(timezoneOffset);
    final sunsetTime =
        DateTime.parse(_valuesMap['sunsetTime'] as String).add(timezoneOffset);
    sunrise = _dateFormatter.formatFullTime(sunriseTime);
    sunset = _dateFormatter.formatFullTime(sunsetTime);
  }

  void _initPrecipValues() {
    precipitationCode = _valuesMap['precipitationType'] as int;
    precipitationType =
        _weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = _valuesMap['precipitationIntensity'] ?? 0.0;

    precipitation = _valuesMap['precipitationProbability'].round() as num;
    precipitationAmount =
        _unitConverter.roundTo2digitsPastDecimal(precip as num);
  }

  void _initTempAndConditions() {
    weatherCode = _valuesMap['weatherCode'] as int;
    dailyCondition =
        _weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = _valuesMap['temperature'].round() as int;
    feelsLikeDay = _valuesMap['temperatureApparent'].round() as int;
  }

  void _initHighAndLowTemp(int i) {
    final tempList = HourlyForecastController.to.minAndMaxTempList[i];
    tempList.sort();
    lowTemp = tempList.first;
    highTemp = tempList.last;
  }

  void _handlePotentialConversions(int i) {
    if (SettingsController.to.precipInMm) {
      precipitationAmount =
          _unitConverter.convertInchesToMillimeters(precipitationAmount);
    }

    if (SettingsController.to.tempUnitsMetric) {
      dailyTemp = _unitConverter.toCelcius(dailyTemp);
      feelsLikeDay = _unitConverter.toCelcius(feelsLikeDay);
      lowTemp = _unitConverter.toCelcius(lowTemp!);
      highTemp = _unitConverter.toCelcius(highTemp!);
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

  // sets first day of DayLabelRow @ index 0 to selected, as a starting
  // point when user navigates to Daily Tab
  void _initSelectedDayList() {
    for (int i = 0; i <= 6; i++) {
      if (i == 0) {
        selectedDayList.add(true);
      } else {
        selectedDayList.add(false);
      }
    }
  }

  void updateSelectedDayStatus(int index) {
    for (int i = 0; i <= 6; i++) {
      if (index == i) {
        selectedDayList[i] = true;
      } else {
        selectedDayList[i] = false;
      }
    }
    update();
  }
}
