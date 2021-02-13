import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/utils/weather_code_converter.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyForecastController extends GetxController {
  final converter = const WeatherCodeConverter();
  RxList<Widget> hourColumns = <Widget>[].obs;
  RxList<Widget> hourRowList = <Widget>[].obs;

  Map dataMap = {};

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
  Future<void> buildHourlyForecastWidgets() async {
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;
    now = DateTime.now().hour;

    await _build24HrWidgets();
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

    for (int i = 0; i <= 24; i++) {
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

  void _populateHourlyData(int i) {
    final valuesMap = dataMap['timelines'][0]['intervals'][i]['values'];

    nextHour = _format24hrTime(time: now + i);

    final weatherCode = valuesMap['weatherCode'];
    hourlyCondition = converter.getConditionFromWeatherCode(weatherCode);

    hourlyTemp = valuesMap['temperature'].round().toString();

    precipitation = valuesMap['precipitationProbability'].round().toString();

    feelsLike = valuesMap['temperatureApparent'].round().toString();

    iconPath = Get.find<ImageController>()
        .getIconImagePath(condition: hourlyCondition, origin: '24 function');
  }
}
