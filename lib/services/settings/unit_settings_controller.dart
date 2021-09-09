import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/controllers/daily_forecast_controller.dart';
import 'package:epic_skies/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/controllers/sun_time_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitSettingsController extends GetxController {
  static UnitSettingsController get to => Get.find();

  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  int tempUnitSettingChangesSinceRefresh = 0;

  bool tempUnitsMetric = false;
  bool timeIs24Hrs = false;
  bool precipInMm = false;
  bool speedInKm = false;

  Color selectedBorderColor = Colors.yellow;
  Color unSelectedBorderColor = Colors.white12;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initSettingsFromStorage();
  }

  Future<void> _initSettingsFromStorage() async {
    final settingsMap = StorageController.to.settingsMap;
    tempUnitsMetric = settingsMap[tempUnitsMetricKey]! as bool;
    precipInMm = settingsMap[precipInMmKey]! as bool;
    timeIs24Hrs = settingsMap[timeIs24HrsKey]! as bool;
    speedInKm = settingsMap[speedInKphKey]! as bool;
  }

  Future<void> updateTempUnits() async {
    tempUnitsMetric = !tempUnitsMetric;
    StorageController.to.storeTempUnitSetting(setting: tempUnitsMetric);

    if (!WeatherRepository.to.isLoading.value) {
      WeatherRepository.to.updateUIValues();
    }
    update();
    tempUnitsUpdateSnackbar();
  }

  void updateTimeFormat() {
    timeIs24Hrs = !timeIs24Hrs;
    StorageController.to.storeTimeFormatSetting(setting: timeIs24Hrs);
    CurrentWeatherController.to.initSettingsStrings();

    _rebuildForecastWidgets();
    update();
    timeUnitsUpdateSnackbar();
  }

  Future<void> updatePrecipUnits() async {
    precipInMm = !precipInMm;
    StorageController.to.storePrecipUnitSetting(setting: precipInMm);
    CurrentWeatherController.to.initSettingsStrings();

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }
    update();
    precipitationUnitsUpdateSnackbar();
  }

  Future<void> updateSpeedUnits() async {
    speedInKm = !speedInKm;
    StorageController.to.storeSpeedUnitSetting(setting: speedInKm);
    CurrentWeatherController.to.initSettingsStrings();

    if (!WeatherRepository.to.isLoading.value) {
      await WeatherRepository.to.updateUIValues();
    }

    update();
    windSpeedUnitsUpdateSnackbar();
  }

  Future<void> _rebuildForecastWidgets() async {
    SunTimeController.to.initSunTimeList();
    CurrentWeatherController.to.initCurrentWeatherValues();
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }

  void setUnitsToMetric() {
    tempUnitsMetric = true;
    speedInKm = true;
    precipInMm = true;
    StorageController.to.storeTempUnitSetting(setting: tempUnitsMetric);
    StorageController.to.storePrecipUnitSetting(setting: precipInMm);
    StorageController.to.storeSpeedUnitSetting(setting: speedInKm);
    update();
  }
}
