import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/icon_controller.dart';
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

  Map dataMap = {};
  Map valuesMap = {};

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

  num precipitationAmount, windSpeed;

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
        windSpeed: windSpeed,
        speedUnit: settingsController.speedUnitString,
      );

      dayColumnList.add(dayColumn);
      dayDetailedWidgetList.add(dailyDetailWidget);
    }
  }

  void _initDailyData(int i) {
    _formatDates(i);
    valuesMap = dataMap['timelines'][1]['intervals'][i + 1]['values'] as Map;
    weatherCode = valuesMap['weatherCode'] as int;
    dailyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
    dailyTemp = valuesMap['temperature'].round() as int;
    feelsLikeDay = valuesMap['temperatureApparent'].round() as int;
    sunrise = valuesMap['sunriseTime'] as String;
    sunset = valuesMap['sunsetTime'] as String;
    precipitationCode = valuesMap['precipitationType'] as int;
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    precipitation = valuesMap['precipitationProbability'].round().toString();
    windSpeed = conversionController
        .convertSpeedUnitsToPerHour(valuesMap['windSpeed'] as num);

    if (settingsController.settingHasChanged ||
        settingsController.mismatchedMetricSettings()) {
      conversionController.handlePotentialDailyConversions(i);
    }

    iconPath = iconController.getIconImagePath(
        condition: dailyCondition, origin: 'Daily');
  }

  void _formatDates(int i) {
    dateFormatter.initNextDay(i);
    day = dateFormatter.getNext7Days(today + i + 1);
    date = dateFormatter.getNextDaysDate();
    month = dateFormatter.getNextDaysMonth();
    year = dateFormatter.getNextDaysYear();
  }
}
