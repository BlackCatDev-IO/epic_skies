import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'master_getx_controller.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  final conversionController = UnitConverter();

  int tempUnitSettingChangesSinceRefresh = 0;

  bool tempUnitsMetric = false;
  bool timeIs24Hrs = false;
  bool precipInMm = false;
  bool speedInKm = false;

  Color selectedColor = Colors.green[400];
  Color unSelectedColor = Colors.grey;

  String tempUnitString = '';
  String precipUnitString = '';
  String speedUnitString = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initSettingsFromStorage();

    _setTempUnitString();
    _setPrecipUnitString();
    _setSpeedUnitString();
  }

  Future<void> _initSettingsFromStorage() async {
    tempUnitsMetric = StorageController.to.restoreTempUnitSetting();
    precipInMm = StorageController.to.restorePrecipUnitSetting();
    timeIs24Hrs = StorageController.to.restoreTimeFormatSetting();
    speedInKm = StorageController.to.restoreSpeedUnitSetting();
  }

  Future<void> updateTempUnits() async {
    tempUnitsMetric = !tempUnitsMetric;
    StorageController.to.storeTempUnitSetting(setting: tempUnitsMetric);
    tempUnitSettingChangesSinceRefresh++;

    _setTempUnitString();

    if (!WeatherRepository.to.isLoading.value) {
      MasterController.to.initUiValues();
    }
    update();
    tempUnitsUpdateSnackbar();
  }

  void updateTimeFormat() {
    timeIs24Hrs = !timeIs24Hrs;
    StorageController.to.storeTimeFormatSetting(setting: timeIs24Hrs);
    _rebuildForecastWidgets();
    update();
    timeUnitsUpdateSnackbar();
  }

  Future<void> updatePrecipUnits() async {
    precipInMm = !precipInMm;
    StorageController.to.storePrecipUnitSetting(setting: precipInMm);
    _setPrecipUnitString();

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }
    update();
    precipitationUnitsUpdateSnackbar();
  }

  Future<void> updateSpeedUnits() async {
    speedInKm = !speedInKm;
    StorageController.to.storeSpeedUnitSetting(setting: speedInKm);
    _setSpeedUnitString();

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    update();
    windSpeedUnitsUpdateSnackbar();
  }

  void _setTempUnitString() {
    tempUnitString = tempUnitsMetric ? 'C' : 'F';
    update();
  }

  void _setPrecipUnitString() {
    precipUnitString = precipInMm ? 'mm' : 'in';
    update();
  }

  void _setSpeedUnitString() {
    speedUnitString = speedInKm ? 'kph' : 'mph';
    update();
  }

  Future<void> _rebuildForecastWidgets() async {
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }
}
