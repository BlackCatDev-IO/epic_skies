import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyForecastController extends GetxController {
  final weatherCodeConverter = const WeatherCodeConverter();
  final unitConverter = const UnitConverter();
  final iconController = IconController();
  final weatherRepository = Get.find<WeatherRepository>();
  final storageController = Get.find<StorageController>();

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
      nextHour;

  int today, now, precipitationCode;

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
    } else if (nextHour > 24) {
      nextHour -= 24;
      formattedTime = now < 12 ? '$nextHour:00 AM' : '$nextHour:00 PM';
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
      _initHourlyData(i);
      final HourColumn hourColumn = HourColumn(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitation: precipitation,
        time: nextHour,
      );

      final HourlyDetailedRow hourlyDetailedRow = HourlyDetailedRow(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitationProbability: precipitation,
        time: nextHour,
        feelsLike: feelsLike,
        condition: hourlyCondition,
        precipitationType: precipitationType,
        precipitationCode: precipitationCode,
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  void _initHourlyData(int i) {
    final settingsController = Get.find<SettingsController>();
    if (settingsController.tempUnitsCelcius.value &&
        !settingsController.convertingUnits.value) {
      _convertToCelcius(i);
    } else if (!settingsController.tempUnitsCelcius.value &&
        !settingsController.convertingUnits.value) {
      _convertToFahrenHeight(i);
    } else {
      valuesMap = dataMap['timelines'][0]['intervals'][i]['values'];
      nextHour = _format24hrTime(time: now + i);
      final weatherCode = valuesMap['weatherCode'];
      hourlyCondition =
          weatherCodeConverter.getConditionFromWeatherCode(weatherCode);
      hourlyTemp = valuesMap['temperature'].round().toString();
      precipitation = valuesMap['precipitationProbability'].round().toString();
      precipitationCode = valuesMap['precipitationType'];
      precipitationType =
          weatherCodeConverter.getPrecipitationTypeFromCode(precipitationCode);
      feelsLike = valuesMap['temperatureApparent'].round().toString();
      iconPath = iconController.getIconImagePath(
          condition: hourlyCondition, origin: '24 function');
    }
  }

  void _convertToCelcius(int i) {
    hourlyTemp =
        unitConverter.convertToCelcius(int.parse(hourlyTemp)).toString();

    feelsLike = unitConverter.convertToCelcius(int.parse(feelsLike)).toString();
    _storeUpdatedTempUnits(i);
    Get.find<SettingsController>().convertingUnits(false);
  }

  void _convertToFahrenHeight(int i) {
    hourlyTemp =
        unitConverter.convertToFahrenHeight(int.parse(hourlyTemp)).toString();
    feelsLike =
        unitConverter.convertToFahrenHeight(int.parse(feelsLike)).toString();
    _storeUpdatedTempUnits(i);
    Get.find<SettingsController>().convertingUnits(false);
  }

  void _storeUpdatedTempUnits(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperature'] = hourlyTemp;
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperatureApparent'] = feelsLike;

    storageController.updateDatamapStorage();
  }
}
