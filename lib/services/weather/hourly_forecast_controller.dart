import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/date_time_formatter.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyForecastController extends GetxController {
  final weatherCodeConverter = const WeatherCodeConverter();
  final dateFormatter = DateTimeFormatter();
  final iconController = IconController();
  SettingsController settingsController;
  final conversionController = ConversionController();

  RxList<Widget> hourColumns = <Widget>[].obs;
  RxList<Widget> hourRowList = <Widget>[].obs;

  Map<String, dynamic> dataMap = {};
  Map<String, dynamic> valuesMap = {};

  String precipitation,
      precipitationType,
      hourlyTemp,
      hourlyCondition,
      feelsLike,
      iconPath,
      timeAtNextHour;

  int today, now, precipitationCode;

  num precipitationAmount, windSpeed;

  Future<void> buildHourlyForecastWidgets() async {
    settingsController = Get.find<SettingsController>();
    dataMap = Get.find<StorageController>().dataMap;
    today = DateTime.now().weekday;
    now = DateTime.now().hour;

    await _build24HrWidgets();
  }

  Future<void> _build24HrWidgets() async {
    if (hourColumns.isNotEmpty && hourRowList.isNotEmpty) {
      hourColumns.clear();
      hourRowList.clear();
    }

    for (int i = 0; i <= 24; i++) {
      _initHourlyData(i);
      final hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: timeAtNextHour,
      );

      final hourlyDetailedRow = HourlyDetailedRow(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitationProbability: precipitation,
        time: timeAtNextHour,
        feelsLike: feelsLike,
        condition: hourlyCondition,
        precipitationType: precipitationType,
        precipitationCode: precipitationCode,
        precipitationAmount: precipitationAmount,
        precipUnit: settingsController.precipUnitString,
        windSpeed: windSpeed,
        speedUnit: settingsController.speedUnitString,
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  void _initHourlyData(int i) {
    valuesMap = dataMap['timelines'][0]['intervals'][i]['values'];
    final bool timeSetting = settingsController.timeIs24Hrs.value;

    timeAtNextHour =
        dateFormatter.formatTime(hour: now + 1 + i, timeIs24hrs: timeSetting);

    final weatherCode = valuesMap['weatherCode'];
    hourlyCondition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode);

    hourlyTemp = valuesMap['temperature'].round().toString();
    feelsLike = valuesMap['temperatureApparent'].round().toString();

    precipitation = valuesMap['precipitationProbability'].round().toString();
    precipitationCode = valuesMap['precipitationType'];
    precipitationType =
        weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
    precipitationAmount = valuesMap['precipitationIntensity'];
    windSpeed = valuesMap['windSpeed'];
    iconPath = iconController.getIconImagePath(
        condition: hourlyCondition, origin: '24 function');

    if (settingsController.converting) {
      conversionController.handlePotentialHourlyConversions(i);
    }
  }
}
