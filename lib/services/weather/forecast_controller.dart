import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import 'weather_controller.dart';

class ForecastController extends GetxController {
  RxList<Widget> hourColumns = <Widget>[].obs;
  RxList<Widget> hourRowList = <Widget>[].obs;
  RxList<Widget> dayColumnList = <Widget>[].obs;

  var dataMap = {}.obs;

  String precipitation,
      hourlyTemp,
      dailyTemp,
      hourlyCondition,
      dailyCondition,
      feelsLike,
      hourlyMain,
      dailyMain,
      iconPath,
      nextDay;

  int today, now;

  Future<void> buildForecastWidgets() async {
    final controller = Get.find<WeatherController>();

    dataMap = controller.dataMap;
    today = controller.today.value;
    now = controller.now;

    await _build24HrWidgets();
    await _buildWeekWidget();
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

    var hourlyMap;

    for (int i = 0; i <= 24; i++) {
      hourlyMap = dataMap['hourly'][i];
      final condition = hourlyMap['weather'];
      hourlyMain = condition[0]['main'];
      hourlyCondition = condition[0]['description'];

      hourlyTemp = hourlyMap['temp'].round().toString();
      precipitation = hourlyMap['pop'].round().toString();
      feelsLike = hourlyMap[feelsLikeKey].round().toString();
      final hourlyTime = int.parse(hourlyMap['dt'].round().toString());

      // hourlyMain = dataMap['$hourlyMainKey:$i'].toString();
      // hourlyMain = dataMap['$hourlyMainKey:$i'].toString();
      // feelsLike = dataMap['$feelsLikeHourlyKey:$i'].toString();
      // hourlyTemp = dataMap['$hourlyTempKey:$i'].toString();
      // precipitation = dataMap['$precipitationKey:$i'].toString();
      // hourlyCondition = dataMap['$hourlyConditionKey:$i'].toString();
      // final hourlyTime = int.parse(dataMap['$hourlyTimeKey:$i']);

      final nextHour = _format24hrTime(time: hourlyTime);

      final imageController = Get.find<ImageController>();
      // Get.find<WeatherController>().getDayOrNight();

      iconPath = imageController.getIconImagePath(
          main: hourlyMain, condition: hourlyCondition, origin: '24 function');

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
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  Future<void> _buildWeekWidget() async {
    dayColumnList.clear();

    var dailyMap;

    for (int i = 0; i < 7; i++) {
      dailyMap = dataMap['daily'][i];
      final conditionMap = dailyMap['weather'][0];

      dailyTemp = dailyMap['temp']['day'].round().toString();
      dailyMain = conditionMap['main'].toString();
      dailyCondition = conditionMap['description'].toString();

      final day = Get.find<ForecastController>().getNext7Days(today + i);
      iconPath = Get.find<ImageController>().getIconImagePath(
          main: dailyMain, condition: dailyCondition, origin: 'Week Function');

      final dayColumn = DayColumn(
        day: day,
        iconPath: iconPath,
        temp: dailyTemp,
      );

      dayColumnList.add(dayColumn);
    }
  }

  String getNext7Days(int day) {
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
        return ' ';
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
