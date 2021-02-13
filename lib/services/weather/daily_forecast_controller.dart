import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/utils/weather_code_converter.dart';
import 'package:epic_skies/widgets/weather_info_display/daily_detail_widget.dart';
import 'package:epic_skies/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../network/weather_repository.dart';

class DailyForecastController extends GetxController {
  final weatherRepository = Get.find<WeatherRepository>();
  final converter = const WeatherCodeConverter();
  RxList<Widget> dayColumnList = <Widget>[].obs;
  RxList<Widget> dayDetailedWidgetList = <Widget>[].obs;
  List<String> dayLabelList = [];

  Map<String, dynamic> dataMap = {};
  Map<String, dynamic> valuesMap = {};

  String precipitation,
      dailyTemp,
      tempNight,
      tempMin,
      tempMax,
      dailyCondition,
      feelsLike,
      iconPath,
      nextDay,
      feelsLikeDay,
      feelsLikeNight,
      precipitationType;

  int today, weatherCode, precipitationCode;

  Future<void> buildDailyForecastWidgets() async {
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;

    await _builDailyWidgets();
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
        precipitationProbability: precipitation,
        feelsLikeDay: feelsLikeDay,
        feelsLikeNight: feelsLikeNight,
        condition: dailyCondition,
        precipitationCode: precipitationCode,
        precipitationType: precipitationType,
      );

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
    }
  }

  void _populateDailyData(int i) {
    valuesMap = dataMap['timelines'][1]['intervals'][i]['values'];
    weatherCode = valuesMap['weatherCode'];
    dailyCondition = converter.getConditionFromWeatherCode(weatherCode);

    dailyTemp = valuesMap['temperature'].round().toString();
    feelsLikeDay = valuesMap['temperatureApparent'].round().toString();
    precipitationCode = valuesMap['precipitationType'];
    precipitationType =
        converter.getPrecipitationTypeFromCode(precipitationCode);
    precipitation = valuesMap['precipitationProbability'].round().toString();

    iconPath = Get.find<ImageController>().getIconImagePath(
        condition: dailyCondition, origin: 'Build Daily Widgets Function');
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
