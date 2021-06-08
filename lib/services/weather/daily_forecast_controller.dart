import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_detail_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_nav_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/scroll_widget_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'current_weather_controller.dart';
import 'hourly_forecast_controller.dart';

class DailyForecastController extends GetxController {
  static DailyForecastController get to => Get.find();

  final _weatherCodeConverter = const WeatherCodeConverter();
  final _dateFormatter = DateTimeFormatter();
  final _iconController = IconController();
  final _unitConverter = const UnitConverter();

  List<Widget> dayColumnList = [];
  List<Widget> dayDetailedWidgetList = [];
  List<Widget> week1NavButtonList = [];
  List<Widget> week2NavButtonList = [];
  List<String> dayLabelList = [];

  Map _dataMap = {};
  Map _valuesMap = {};
  Map _settingsMap = {};

  late String tempNight,
      dailyCondition,
      iconPath,
      nextDay,
      feelsLikeNight,
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

  late Duration timezoneOffset;

  late int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;
  int? highTemp, lowTemp;

  late num precipitationAmount, windSpeed, precipitation;

  Future<void> buildDailyForecastWidgets() async {
    _dataMap = StorageController.to.dataMap;
    _settingsMap = StorageController.to.settingsMap;
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
          date: dayNumber);

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
        tempUnit: CurrentWeatherController.to.tempUnitString,
        windSpeed: windSpeed,
        speedUnit: CurrentWeatherController.to.speedUnitString,
        list: list,
      );
      final navWidget =
          DailyNavButton(time: day, month: month, date: date, index: i);

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(navWidget);
      } else if (i.isInRange(7, 14)) {
        week2NavButtonList.add(navWidget);
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
    sunriseTime =
        DateTime.parse(_valuesMap['sunriseTime'] as String).add(timezoneOffset);
    sunsetTime =
        DateTime.parse(_valuesMap['sunsetTime'] as String).add(timezoneOffset);
    dayNumber = sunsetTime.day.toString();
    monthAbbreviation = _dateFormatter.getMonthAbbreviation(sunsetTime);

    sunrise = _dateFormatter.formatFullTime(
        time: sunriseTime, timeIs24Hrs: _settingsMap[timeIs24HrsKey]! as bool);
    sunset = _dateFormatter.formatFullTime(
        time: sunsetTime, timeIs24Hrs: _settingsMap[timeIs24HrsKey]! as bool);
  }

  void _initPrecipValues() {
    precipitationCode = _valuesMap['precipitationType'] as int;
    precipitationType =
        _weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    final precip = _valuesMap['precipitationIntensity'] ?? 0.0;

    precipitation = _valuesMap['precipitationProbability'].round() as num;
    precipitationAmount = precip.round() as int;
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
    if (_settingsMap[precipInMmKey]! as bool) {
      precipitationAmount =
          _unitConverter.convertInchesToMillimeters(precipitationAmount);
    }

    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      dailyTemp = _unitConverter.toCelcius(dailyTemp);
      feelsLikeDay = _unitConverter.toCelcius(feelsLikeDay);
      lowTemp = _unitConverter.toCelcius(lowTemp!);
      highTemp = _unitConverter.toCelcius(highTemp!);
    }

    if (_settingsMap[speedInKphKey]! as bool) {
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
    week1NavButtonList.clear();
    week2NavButtonList.clear();
  }

  // sets first day of DayLabelRow @ index 0 to selected, as a starting
  // point when user navigates to Daily Tab
  void _initSelectedDayList() {
    for (int i = 0; i <= 13; i++) {
      if (i == 0) {
        selectedDayList.add(true);
      } else {
        selectedDayList.add(false);
      }
    }
  }

  void updateSelectedDayStatus(int index) {
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
