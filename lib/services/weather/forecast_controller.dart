import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import 'weather_controller.dart';

class ForecastController extends GetxController {
  List<Widget> hourColumns = <Widget>[].obs;
  List<Widget> hourRowList = <Widget>[].obs;
  List<Widget> dayColumnList = <Widget>[].obs;

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
      nextDay,
      day;

  int today, now;

  // RxString precipitation = ''.obs;
  // RxString temp = ''.obs;
  // RxString condition = ''.obs;
  // RxString feelsLike = ''.obs;
  // RxString main = ''.obs;
  // RxString iconPath = ''.obs;
  // RxString nextDay = ''.obs;

  Future<void> buildForecastWidgets() async {
    final controller = Get.find<WeatherController>();

    dataMap = controller.dataMap;
    today = controller.today.value;
    now = controller.now.value;

    await _build24HrWidgets();
    _buildWeekWidget();
  }

  Future<void> _build24HrWidgets() async {
    if (hourColumns.isNotEmpty && hourRowList.isNotEmpty) {
      hourColumns.clear();
      hourRowList.clear();
    }

    for (int i = 0; i <= 24; i++) {
      hourlyTemp = dataMap['$hourlyTempKey:$i'].toString();
      hourlyMain = dataMap['$hourlyMainKey:$i'].toString();
      precipitation = dataMap['$precipitationKey:$i'].toString();
      hourlyCondition = dataMap['$hourlyConditionKey:$i'].toString();
      feelsLike = dataMap['$feelsLikeHourlyKey:$i'].toString();

      nextDay = '${now + 1 + i}:00 ';

      final imageController = Get.find<ImageController>();
      // Get.find<WeatherController>().getDayOrNight();

      iconPath = imageController.getImagePath(
          main: hourlyMain, condition: hourlyCondition, origin: '24 function');

      final HourColumn hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: nextDay,
      );

      final HourlyDetailedRow hourlyDetailedRow = HourlyDetailedRow(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: nextDay,
        feelsLike: feelsLike,
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  void _buildWeekWidget() {
    dayColumnList.clear();

    for (int i = 0; i < 7; i++) {
      dailyTemp = dataMap['$dailyTempKey:$i'].toString();
      dailyMain = dataMap['$dailyMainKey:$i'].toString();
      dailyCondition = dataMap['$dailyConditionKey:$i'].toString();

      day = Get.find<ForecastController>().getNext7Days(today + i);
      iconPath = Get.find<ImageController>().getImagePath(
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
