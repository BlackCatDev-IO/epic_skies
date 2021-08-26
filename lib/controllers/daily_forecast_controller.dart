import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/view_controllers/scroll_position_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_detail_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/scroll_widget_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'current_weather_controller.dart';
import 'hourly_forecast_controller.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  List<Widget> dayColumnList = [];
  List<Widget> dayDetailedWidgetList = [];
  List<DailyNavButtonModel> week1NavButtonList = [];
  List<DailyNavButtonModel> week2NavButtonList = [];
  List<String> dayLabelList = [];

  Map _dataMap = {};
  Map _valuesMap = {};
  Map _settingsMap = {};

  late String _dailyCondition,
      iconPath,
      precipitationType,
      date,
      month,
      monthAbbreviation,
      year,
      day,
      dayNumber,
      sunset,
      sunrise;

  late DateTime now, sunsetTime, sunriseTime;

  late int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;

  int? highTemp, lowTemp;

  late num precipitationAmount, windSpeed, precipitation;

  Future<void> buildDailyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    _settingsMap = StorageController.to.settingsMap;
    now = DateTime.now();
    today = now.weekday;
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
    for (int i = 0; i < 14; i++) {
      _initDailyData(i);
      dayLabelList.add(day);

      List<Widget>? list;

      final dayColumn = ScrollWidgetColumn(
          time: day,
          iconPath: iconPath,
          temp: dailyTemp,
          precipitation: precipitation,
          month: monthAbbreviation,
          date: dayNumber,
          onPressed: () =>
              ScrollPositionController.to.jumpToDayFromHomeScreen(index: i));

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
        condition: _dailyCondition,
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
        tempUnit: CurrentWeatherController.to.tempUnitString,
        windSpeed: windSpeed,
        speedUnit: CurrentWeatherController.to.speedUnitString,
        list: list,
        index: i,
      );
      final _dailyNavButtonModel =
          DailyNavButtonModel(day: day, month: month, date: date, index: i);

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(_dailyNavButtonModel);
      } else if (i.isInRange(7, 13)) {
        week2NavButtonList.add(_dailyNavButtonModel);
      }

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
    //TODO: FIX THIS RANGE ERROR
    _valuesMap =
        _dataMap['timelines'][1]['intervals'][interval + 1]['values'] as Map;

    _initTempAndConditions();
    _initAndFormatSunTimes();
    _initPrecipValues();

    // range check is to not go over available 108 hrs of hourly temps
    if (i.isInRange(0, 3)) {
      _initHighAndLowTemp(i);
    }

    windSpeed = UnitConverter.convertFeetPerSecondToMph(
            feetPerSecond: _valuesMap['windSpeed'] as num)
        .round();

    _handlePotentialConversions(i);

    iconPath = IconController.getIconImagePath(
        hourly: false, condition: _dailyCondition);
  }

  void _initAndFormatSunTimes() {
    sunriseTime = TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
        time: _valuesMap['sunriseTime'] as String);
    sunsetTime = TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
        time: _valuesMap['sunsetTime'] as String);
    dayNumber = sunsetTime.day.toString();
    monthAbbreviation =
        DateTimeFormatter.getMonthAbbreviation(time: sunsetTime);

    sunrise = DateTimeFormatter.formatFullTime(
        time: sunriseTime, timeIs24Hrs: _settingsMap[timeIs24HrsKey]! as bool);
    sunset = DateTimeFormatter.formatFullTime(
        time: sunsetTime, timeIs24Hrs: _settingsMap[timeIs24HrsKey]! as bool);
  }

  void _initPrecipValues() {
    precipitationCode = _valuesMap['precipitationType'] as int;
    precipitationType =
        WeatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = _valuesMap['precipitationIntensity'] ?? 0.0;

    precipitation = _valuesMap['precipitationProbability'].round() as num;
    precipitationAmount = precip.round() as int;
  }

  void _initTempAndConditions() {
    weatherCode = _valuesMap['weatherCode'] as int;
    _dailyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(weatherCode);
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
    if (_settingsMap[precipInMmKey]! as bool) {
      precipitationAmount =
          UnitConverter.convertInchesToMillimeters(inches: precipitationAmount);
    }

    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      dailyTemp = UnitConverter.toCelcius(dailyTemp);
      feelsLikeDay = UnitConverter.toCelcius(feelsLikeDay);
      lowTemp = UnitConverter.toCelcius(lowTemp!);
      highTemp = UnitConverter.toCelcius(highTemp!);
    }

    if (_settingsMap[speedInKphKey]! as bool) {
      windSpeed = UnitConverter.convertMilesToKph(miles: windSpeed);
    }
  }

  void _formatDates(int i) {
    DateTimeFormatter.initNextDay(i);
    day = DateTimeFormatter.getNext7Days(today + i + 1);
    date = DateTimeFormatter.getNextDaysDate();
    month = DateTimeFormatter.getNextDaysMonth();
    year = DateTimeFormatter.getNextDaysYear();
  }

  void _clearWidgetLists() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();
    week1NavButtonList.clear();
    week2NavButtonList.clear();
  }

  /// sets first day of DayLabelRow @ index 0 to selected, as a starting
  /// point when user navigates to Daily Tab
  void _initSelectedDayList() {
    for (int i = 0; i <= 13; i++) {
      if (i == 0) {
        selectedDayList.add(true);
      } else {
        selectedDayList.add(false);
      }
    }
  }

  void updateSelectedDayStatus({required int index}) {
    for (int i = 0; i <= 13; i++) {
      if (index == i) {
        selectedDayList[i] = true;
      } else {
        selectedDayList[i] = false;
      }
    }
    update();
  }
}

class DailyNavButtonModel {
  final String day, month, date;
  final int index;

  DailyNavButtonModel(
      {required this.day,
      required this.month,
      required this.date,
      required this.index});
}
