import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/controllers/sun_time_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
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
      _iconPath,
      _precipitationType,
      _date,
      _month,
      _monthAbbreviation,
      _year,
      _day;

  late DateTime _now;

  late int _today, _weatherCode, _precipitationCode, _dailyTemp, _feelsLikeDay;

  late int _highTemp, _lowTemp;

  late num _precipitationAmount, _windSpeed, _precipitation;

  Future<void> buildDailyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    _settingsMap = StorageController.to.settingsMap;
    _now = DateTime.now();
    _today = _now.weekday;
    _clearWidgetLists();
    _builDailyWidgets();
    update();
  }

  /// stores isSelected bools for DayLabelRow to show selected indicator
  List<bool> selectedDayList = [];

  @override
  void onInit() {
    super.onInit();
    _initSelectedDayList();
  }

  void _builDailyWidgets() {
    for (int i = 0; i < 14; i++) {
      _initDailyData(i);
      dayLabelList.add(_day);

      List? hourlyForecastList;

      final dayColumn = ScrollWidgetColumn(
          header: _day,
          iconPath: _iconPath,
          temp: _dailyTemp,
          precipitation: _precipitation,
          month: _monthAbbreviation,
          date: _date,
          onPressed: () =>
              ScrollPositionController.to.jumpToDayFromHomeScreen(index: i));

      /// range check is to not go over available 108 hrs of hourly temps
      /// this list populates the hourly forecast for the first 4 days of
      /// the forecast
      if (i.isInRange(0, 3)) {
        final key = _hourlyForecastMapKey(index: i);
        hourlyForecastList = HourlyForecastController
            .to.hourlyForecastHorizontalScrollWidgetMap[key];
      }

      final dailyDetailWidget = DailyDetailWidget(
        day: _day,
        iconPath: _iconPath,
        tempDay: _dailyTemp,
        precipitationProbability: _precipitation,
        feelsLikeDay: _feelsLikeDay,
        condition: _dailyCondition,
        precipitationCode: _precipitationCode,
        precipitationType: _precipitationType,
        precipitationAmount: _precipitationAmount,
        sunTime: SunTimeController.to.sunTimeList[i],
        month: _month,
        date: _date,
        year: _year,
        lowTemp: _lowTemp,
        highTemp: _highTemp,
        tempUnit: CurrentWeatherController.to.tempUnitString,
        windSpeed: _windSpeed,
        speedUnit: CurrentWeatherController.to.speedUnitString,
        list: hourlyForecastList,
        index: i,
      );
      final _dailyNavButtonModel =
          DailyNavButtonModel(day: _day, month: _month, date: _date, index: i);

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

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that
    if (TimeZoneController.to.isBetweenMidnightAnd6Am()) {
      interval++;
    }

    _valuesMap =
        _dataMap['timelines'][1]['intervals'][interval + 1]['values'] as Map;

    _initTempAndConditions();
    _initAndFormatDateStrings(i);
    _initPrecipValues();

    // range check is to not go over available 108 hrs of hourly temps
    if (i.isInRange(0, 3)) {
      _initHighAndLowTemp(i);
    }

    _windSpeed = UnitConverter.convertFeetPerSecondToMph(
            feetPerSecond: _valuesMap['windSpeed'] as num)
        .round();

    _handlePotentialConversions(i);

    _iconPath = IconController.getIconImagePath(
        hourly: false, condition: _dailyCondition);
  }

  void _initAndFormatDateStrings(int i) {
    final dateString =
        _dataMap['timelines'][1]['intervals'][i]['startTime'] as String;
    final displayDate = TimeZoneController.to
        .parseTimeBasedOnLocalOrRemoteSearch(time: dateString);
    _monthAbbreviation =
        DateTimeFormatter.getMonthAbbreviation(time: displayDate);
  }

  void _initPrecipValues() {
    _precipitationCode = _valuesMap['precipitationType'] as int;
    _precipitationType =
        WeatherCodeConverter.getPrecipitationTypeFromCode(_precipitationCode);
    final precip = _valuesMap['precipitationIntensity'] as num? ?? 0.0;
    _precipitationAmount = num.parse(precip.toStringAsFixed(2));

    _precipitation = _valuesMap['precipitationProbability'].round() as num;
  }

  void _initTempAndConditions() {
    _weatherCode = _valuesMap['weatherCode'] as int;
    _dailyCondition =
        WeatherCodeConverter.getConditionFromWeatherCode(_weatherCode);
    _dailyTemp = _valuesMap['temperature'].round() as int;
    _feelsLikeDay = _valuesMap['temperatureApparent'].round() as int;
  }

  void _initHighAndLowTemp(int i) {
    final tempList = HourlyForecastController.to.minAndMaxTempList[i];
    tempList.sort();
    _lowTemp = tempList.first;
    _highTemp = tempList.last;
  }

  void _handlePotentialConversions(int i) {
    if (_settingsMap[precipInMmKey]! as bool) {
      _precipitationAmount = UnitConverter.convertInchesToMillimeters(
          inches: _precipitationAmount);
    }

    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      _dailyTemp = UnitConverter.toCelcius(_dailyTemp);
      _feelsLikeDay = UnitConverter.toCelcius(_feelsLikeDay);
      _lowTemp = UnitConverter.toCelcius(_lowTemp);
      _highTemp = UnitConverter.toCelcius(_highTemp);
    }

    if (_settingsMap[speedInKphKey]! as bool) {
      _windSpeed = UnitConverter.convertMilesToKph(miles: _windSpeed);
    }
  }

  void _formatDates(int i) {
    DateTimeFormatter.initNextDay(i);
    _day = DateTimeFormatter.getNext7Days(_today + i + 1);
    _date = DateTimeFormatter.getNextDaysDate();
    _month = DateTimeFormatter.getNextDaysMonth();
    _year = DateTimeFormatter.getNextDaysYear();
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

  String _hourlyForecastMapKey({required int index}) {
    switch (index) {
      case 0:
        return 'day_1';
      case 1:
        return 'day_2';
      case 2:
        return 'day_3';
      case 3:
        return 'day_4';

      default:
        throw 'Invalid value sent to hourlyMapKey function';
    }
  }

  void _clearWidgetLists() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();
    week1NavButtonList.clear();
    week2NavButtonList.clear();
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
