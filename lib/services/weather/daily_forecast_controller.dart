import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/daily_detail_widget.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:epic_skies/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'weather_controller.dart';

class DailyForecastController extends GetxController {
  RxList<Widget> hourColumns = <Widget>[].obs;
  RxList<Widget> hourRowList = <Widget>[].obs;
  RxList<Widget> dayColumnList = <Widget>[].obs;
  RxList<Widget> dayDetailedWidgetList = <Widget>[].obs;
  List<String> dayLabelList = [];

  Map<String, dynamic> dataMap = {};

  String precipitation,
      hourlyTemp,
      dailyTemp,
      tempNight,
      tempMin,
      tempMax,
      hourlyCondition,
      dailyCondition,
      feelsLike,
      dailyMain,
      iconPath,
      nextDay,
      nextHour,
      feelsLikeDay,
      feelsLikeNight,
      rain,
      snow;

  int today, now;

  var dailyMap;
  var feelsLikeMap;
  var dailyTempMap;
  var conditionMap;
  // var hourlyMap;
  Map<String, dynamic> valuesMap;

  Future<void> buildDailyForecastWidgets() async {
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;
    now = DateTime.now().hour;

    await _build24HrWidgets();
    await _builDailyWidgets();
  }

  String _format24hrTime({int time}) {
    int nextHour = time + 1;
    String formattedTime;
    if (nextHour < 12) {
      formattedTime = '$nextHour:00 AM';
    } else if (nextHour == 12) {
      formattedTime = '$nextHour:00 PM';
    } else if (nextHour == 24) {
      nextHour -= 12;
      formattedTime = '$nextHour:00 AM';
    } else {
      nextHour -= 12;
      formattedTime = '$nextHour:00 PM';
    }
    return formattedTime;
  }

  Future<void> _build24HrWidgets() async {
    if (hourColumns.isNotEmpty && hourRowList.isNotEmpty) {
      hourColumns.clear();
      hourRowList.clear();
    }

    for (int i = 1; i <= 24; i++) {
      _populateHourlyData(i);
      final HourColumn hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: nextHour,
      );

      final HourlyDetailedRow hourlyDetailedRow = HourlyDetailedRow(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: nextHour,
        feelsLike: feelsLike,
        condition: hourlyCondition,
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  Future<void> _builDailyWidgets() async {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();

    for (int i = 0; i < 7; i++) {
      final day = _getNext7Days(today + i + 1);
      _populateDailyData(i);
      dayLabelList.add(day);

      final dayColumn = DayColumn(
        day: day,
        iconPath: iconPath,
        temp: dailyTemp,
      );

      final dailyDetailWidget = DailyDetailWidget(
        day: day,
        iconPath: iconPath,
        tempDay: dailyTemp,
        tempNight: tempNight,
        tempMin: tempMin,
        tempHigh: tempMax,
        precipitation: precipitation,
        feelsLikeDay: feelsLikeDay,
        feelsLikeNight: feelsLikeNight,
        condition: dailyCondition,
        snow: snow,
        rain: rain,
        main: dailyMain,
      );

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
    }
  }

  void _populateDailyData(int i) {
    dailyMap = dataMap['daily'][i + 1];
    feelsLikeMap = dailyMap['feels_like'];
    dailyTempMap = dailyMap['temp'];
    conditionMap = dailyMap['weather'][0];
    dailyTemp = dailyMap['temp']['day'].round().toString();
    dailyCondition = conditionMap['description'].toString();
    dailyMain = conditionMap['main'].toString();
    dailyCondition = conditionMap['description'].toString();
    feelsLikeDay = feelsLikeMap['day'].round().toString();
    feelsLikeNight = feelsLikeMap['night'].round().toString();
    tempNight = dailyTempMap['night'].round().toString();
    tempMin = dailyTempMap['min'].round().toString();
    tempMax = dailyTempMap['max'].round().toString();
    precipitation = (dailyMap['pop'] * 100).round().toString();

    snow = dailyMap['snow'].round().toString() ?? '';

    rain = dailyMap['rain'].round().toString() ?? '';
    // }

    iconPath = Get.find<ImageController>().getIconImagePath(
        condition: dailyCondition, origin: 'Build Daily Widgets Function');
  }

  void _populateHourlyData(int i) {
    final parsedTime = DateTime.parse(dataMap['timelines'][0]['intervals'][i]
            ['startTime']
        .round()
        .toString());
    final hour = parsedTime.hour;
    nextHour = _format24hrTime(time: hour);

    valuesMap = dataMap['timelines'][0]['intervals'][i]['values'];
    final weatherCode = valuesMap['weatherCode'];
    hourlyCondition =
        Get.find<WeatherController>().getConditionFromWeatherCode(weatherCode);

    hourlyTemp = valuesMap['temperature'].round().toString();

    precipitation =
        (valuesMap['precipitationProbability'] * 100).round().toString();

    feelsLike = valuesMap['temperatureApparent'].round().toString();

    iconPath = Get.find<ImageController>()
        .getIconImagePath(condition: hourlyCondition, origin: '24 function');
  }

  String _getNext7Days(int day) {
    final nextDay = _getNextDayCode(day);

    switch (nextDay) {
      case 1:
        return 'Mon';
        break;
      case 2:
        return 'Tue';
        break;

      case 3:
        return 'Wed';
        break;

      case 4:
        return 'Thu';
        break;

      case 5:
        return 'Fri';
        break;

      case 6:
        return 'Sat';
        break;

      case 7:
        return 'Sun';
        break;

      default:
        return '';
    }
  }

  int _getNextDayCode(int day) {
    if (day == today) {
      return today;
    } else if (day < 8) {
      return day;
    } else {
      return day - 7;
    }
  }
}
