import 'package:epic_skies/services/utils/date_formatter.dart';
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
  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateFormatter();

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
      precipitationType,
      date,
      month,
      year,
      day,
      sunset,
      sunrise;

  int today, weatherCode, precipitationCode;

  Future<void> buildDailyForecastWidgets() async {
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;

    _builDailyWidgets();
  }

  void _builDailyWidgets() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();

    for (int i = 0; i < 7; i++) {
      _initDailyData(i);
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
        sunrise: sunrise,
        sunset: sunset,
        month: month,
        date: date,
        year: year,
      );

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
    }
  }

  void _initDailyData(int i) {
    dateFormatter.initNextDay(i);
    day = dateFormatter.getNext7Days(today + i + 1);
    date = dateFormatter.getNextDaysDate();
    month = dateFormatter.getNextDaysMonth();
    year = dateFormatter.getNextDaysYear();

    valuesMap = dataMap['timelines'][1]['intervals'][i]['values'];
    weatherCode = valuesMap['weatherCode'];
    dailyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = valuesMap['temperature'].round().toString();
    feelsLikeDay = valuesMap['temperatureApparent'].round().toString();
    sunrise = valuesMap['sunriseTime'];
    sunset = valuesMap['sunsetTime'];
    precipitationCode = valuesMap['precipitationType'];
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    precipitation = valuesMap['precipitationProbability'].round().toString();

    iconPath = Get.find<ImageController>().getIconImagePath(
        condition: dailyCondition, origin: 'Build Daily Widgets Function');
  }
}
