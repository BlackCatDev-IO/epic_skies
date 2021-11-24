import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/weather_forecast/forecast_controllers.dart';
import 'package:epic_skies/utils/settings/settings.dart';
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
  bool speedInKph = false;

  Color selectedBorderColor = Colors.yellow;
  Color unSelectedBorderColor = Colors.white12;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initSettingsFromStorage();
  }

  Future<void> _initSettingsFromStorage() async {
    tempUnitsMetric = Settings.tempUnitsCelcius;
    precipInMm = Settings.precipInMm;
    timeIs24Hrs = Settings.timeIs24Hrs;
    speedInKph = Settings.speedInKph;
  }

  Future<void> updateTempUnits() async {
    tempUnitsMetric = !tempUnitsMetric;
    StorageController.to.storeTempUnitMetricSetting(setting: tempUnitsMetric);

    if (!WeatherRepository.to.isLoading.value) {
      WeatherRepository.to.updateUIValues();
    }
    update();
    Snackbars.tempUnitsUpdateSnackbar();
  }

  void updateTimeFormat() {
    timeIs24Hrs = !timeIs24Hrs;
    StorageController.to.storeTimeIn24HrsSetting(setting: timeIs24Hrs);

    _rebuildForecastWidgets();
    update();
    Snackbars.timeUnitsUpdateSnackbar();
  }

  Future<void> updatePrecipUnits() async {
    precipInMm = !precipInMm;
    StorageController.to.storePrecipInMmSetting(setting: precipInMm);

    if (!WeatherRepository.to.isLoading.value) {
      await _rebuildForecastWidgets();
    }
    update();
    Snackbars.precipitationUnitsUpdateSnackbar();
  }

  Future<void> updateSpeedUnits() async {
    speedInKph = !speedInKph;
    StorageController.to.storeSpeedInKphSetting(setting: speedInKph);

    if (!WeatherRepository.to.isLoading.value) {
      await WeatherRepository.to.updateUIValues();
    }

    update();
    Snackbars.windSpeedUnitsUpdateSnackbar();
  }

  Future<void> _rebuildForecastWidgets() async {
    SunTimeController.to.initSunTimeList();
    CurrentWeatherController.to.initCurrentWeatherValues();
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.initDailyForecastModels();
  }

  void setUnitsToMetric() {
    tempUnitsMetric = true;
    speedInKph = true;
    precipInMm = true;
    StorageController.to.storeTempUnitMetricSetting(setting: tempUnitsMetric);
    StorageController.to.storePrecipInMmSetting(setting: precipInMm);
    StorageController.to.storeSpeedInKphSetting(setting: speedInKph);
    update();
  }
}
