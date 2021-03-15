import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/date_time_formatter.dart';
import 'package:epic_skies/services/utils/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/daily_detail_widget.dart';
import 'package:epic_skies/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyForecastController extends GetxController {
  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  final conversionController = ConversionController();
  SettingsController settingsController;

  RxList<Widget> dayColumnList = <Widget>[].obs;
  RxList<Widget> dayDetailedWidgetList = <Widget>[].obs;
  List<String> dayLabelList = [];

  Map<String, dynamic> dataMap = {};
  Map<String, dynamic> valuesMap = {};

  String precipitation,
      tempNight,
      tempMin,
      tempMax,
      dailyCondition,
      iconPath,
      nextDay,
      feelsLikeNight,
      precipitationType,
      date,
      month,
      year,
      day,
      tempUnit,
      sunset,
      sunrise;

  int today, weatherCode, precipitationCode, dailyTemp, feelsLikeDay;

  num precipitationAmount;

  Future<void> buildDailyForecastWidgets() async {
    settingsController = Get.find<SettingsController>();
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;

    _builDailyWidgets();
  }

  void _builDailyWidgets() {
    dayColumnList.clear();
    dayLabelList.clear();
    dayDetailedWidgetList.clear();

    final tempUnitsCelcius = settingsController.tempUnitsMetric.value;

    tempUnit = tempUnitsCelcius ? 'C' : 'F';

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
        precipitationAmount: precipitationAmount,
        sunrise: sunrise,
        sunset: sunset,
        month: month,
        date: date,
        year: year,
        tempUnit: tempUnit,
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

    valuesMap = dataMap['timelines'][1]['intervals'][i + 1]['values'];
    weatherCode = valuesMap['weatherCode'];
    dailyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = valuesMap['temperature'].round();
    feelsLikeDay = valuesMap['temperatureApparent'].round();
    sunrise = valuesMap['sunriseTime'];
    sunset = valuesMap['sunsetTime'];
    precipitationCode = valuesMap['precipitationType'];
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    precipitation = valuesMap['precipitationProbability'].round().toString();

    if (settingsController.converting) {
      conversionController.handlePotentialDailyConversions(i);
    }

    iconPath = iconController.getIconImagePath(
        condition: dailyCondition, origin: 'Build Daily Widgets Function');
  }
}
