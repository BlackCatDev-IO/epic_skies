import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  final conversionController = ConversionController();

  int tempUnitSettingChangesSinceRefresh = 0;

  bool convertingTempUnits = false;
  bool convertingPrecipUnits = false;
  bool convertingSpeedUnits = false;
  bool settingHasChanged = false;
  bool allUnitsMetric = false;
  bool allUnitsImperial = true;

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
    _updateAllUnitsMetric();
    _updateAllUnitsImperial();
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
    settingHasChanged = true;
    convertingTempUnits = true;
    tempUnitSettingChangesSinceRefresh++;
    _updateAllUnitsMetric();
    _updateAllUnitsImperial();
    _setTempUnitString();

    if (!WeatherRepository.to.isLoading.value) {
      await conversionController.convertAppTempUnit();
    }

    convertingTempUnits = false;
    settingHasChanged = false;
    update();
    tempUnitsUpdateSnackbar();
  }

  void updateTimeFormat() {
    StorageController.to.storeTimeFormatSetting(setting: timeIs24Hrs);
    HourlyForecastController.to.buildHourlyForecastWidgets();
    update();
    timeUnitsUpdateSnackbar();
  }

  Future<void> updatePrecipUnits() async {
    StorageController.to.storePrecipUnitSetting(setting: precipInMm);
    settingHasChanged = true;
    convertingPrecipUnits = true;
    _setPrecipUnitString();
    _updateAllUnitsMetric();
    _updateAllUnitsImperial();

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingPrecipUnits = false;
    settingHasChanged = false;
    update();
    precipitationUnitsUpdateSnackbar();
  }

  Future<void> updateSpeedUnits() async {
    StorageController.to.storeSpeedUnitSetting(setting: speedInKm);
    settingHasChanged = true;
    convertingSpeedUnits = true;
    _updateAllUnitsMetric();

    _setSpeedUnitString();

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingSpeedUnits = false;
    settingHasChanged = false;
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

  void resetSettingChangeCounters() => tempUnitSettingChangesSinceRefresh = 0;

  // bool needsConversion() => tempUnitSettingChangesSinceRefresh.isOdd;

  bool needsConversion() {
    if ((allUnitsMetric || allUnitsImperial) && !settingHasChanged) {
      return false;
    } else {
      return true;
    }
  }

  void _updateAllUnitsMetric() {
    if (tempUnitsMetric == true && precipInMm == true && speedInKm == true) {
      allUnitsMetric = true;
    } else {
      allUnitsMetric = false;
    }
  }

  void _updateAllUnitsImperial() {
    if (tempUnitsMetric == false && precipInMm == false && speedInKm == false) {
      allUnitsImperial = true;
    } else {
      allUnitsImperial = false;
    }
  }
}
