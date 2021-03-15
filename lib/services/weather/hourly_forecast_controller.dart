import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/icon_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/date_formatter.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyForecastController extends GetxController {
  final weatherCodeConverter = const WeatherCodeConverter();
  final unitConverter = const UnitConverter();
  final dateFormatter = DateFormatter();
  final iconController = IconController();
  final weatherRepository = Get.find<WeatherRepository>();
  final storageController = Get.find<StorageController>();
  SettingsController settingsController;

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

  num precipitationAmount;

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
        time: nextHour,
      );

      final hourlyDetailedRow = HourlyDetailedRow(
        temp: hourlyTemp,
        iconPath: iconPath,
        precipitationProbability: precipitation,
        time: nextHour,
        feelsLike: feelsLike,
        condition: hourlyCondition,
        precipitationType: precipitationType,
        precipitationCode: precipitationCode,
        precipitationAmount: precipitationAmount,
        precipUnit: settingsController.precipUnitString,
      );
      hourColumns.add(hourColumn);
      hourRowList.add(hourlyDetailedRow);
    }
  }

  void _initHourlyData(int i) {
    valuesMap = dataMap['timelines'][0]['intervals'][i]['values'];
    nextHour = dateFormatter.format12hrTime(hour: now + i);
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
    iconPath = iconController.getIconImagePath(
        condition: hourlyCondition, origin: '24 function');

    if (settingsController.convertingTempUnits) {
      _convertTempUnits(i);
    }
    if (settingsController.convertingMeasurementUnits) {
      _convertMeasurementUnits(i);
    }
  }

  void _convertTempUnits(int i) {
    if (settingsController.tempUnitsMetric.value) {
      hourlyTemp =
          unitConverter.convertToCelcius(int.parse(hourlyTemp)).toString();
      feelsLike =
          unitConverter.convertToCelcius(int.parse(feelsLike)).toString();
    } else {
      hourlyTemp =
          unitConverter.convertToFahrenHeight(int.parse(hourlyTemp)).toString();
      feelsLike =
          unitConverter.convertToFahrenHeight(int.parse(feelsLike)).toString();
    }
    _storeUpdatedTempUnits(i);
  }

  void _convertMeasurementUnits(int i) {
    final bool needsConversion =
        settingsController.unitSettingChangesSinceRefresh.isOdd;

    if (needsConversion) {
      switch (settingsController.precipInMm.value) {
        case true:
          {
            precipitationAmount =
                unitConverter.convertInchesToMillimeters(precipitationAmount);
          }
          break;
        case false:
          {
            precipitationAmount =
                unitConverter.convertMillimetersToInches(precipitationAmount);
          }
          break;
      }
    }
    _storeUpdatedMeasurementUnits(i);
  }

  void _storeUpdatedTempUnits(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperature'] = int.parse(hourlyTemp);
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['temperatureApparent'] = int.parse(feelsLike);

    storageController.updateDatamapStorage();
  }

  void _storeUpdatedMeasurementUnits(int i) {
    storageController.dataMap['timelines'][0]['intervals'][i]['values']
        ['precipitationIntensity'] = precipitationAmount;

    storageController.updateDatamapStorage();
  }
}
