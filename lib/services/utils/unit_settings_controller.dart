import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'master_getx_controller.dart';

class UnitSettingsController extends GetxController {
  static UnitSettingsController get to => Get.find();

  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  final conversionController = const UnitConverter();

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
    CurrentWeatherController.to.initSettingsStrings();
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
      MasterController.to.initUiValues();
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
      await MasterController.to.initUiValues();
    }

    update();
    windSpeedUnitsUpdateSnackbar();
  }

  Future<void> _rebuildForecastWidgets() async {
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }

  void initTempUnitStrings() {}
}
