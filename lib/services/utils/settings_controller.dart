import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  final currentWeatherController = Get.find<CurrentWeatherController>();
  final hourlyForecastController = Get.find<HourlyForecastController>();
  final dailyForecastController = Get.find<DailyForecastController>();
  final storageController = Get.find<StorageController>();
  final weatherRepository = Get.find<WeatherRepository>();
  final conversionController = ConversionController();

  int tempUnitSettingChangesSinceRefresh = 0;

  bool convertingTempUnits = false;
  bool convertingPrecipUnits = false;
  bool convertingSpeedUnits = false;
  bool settingHasChanged = false;

  RxBool tempUnitsMetric = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool precipInMm = false.obs;
  RxBool speedInKm = false.obs;

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
    _initSettingsListeners();
  }

  Future<void> _initSettingsFromStorage() async {
    tempUnitsMetric.value = storageController.restoreTempUnitSetting();
    precipInMm.value = storageController.restorePrecipUnitSetting();
    timeIs24Hrs.value = storageController.restoreTimeFormatSetting();
    speedInKm.value = storageController.restoreSpeedUnitSetting();
  }

  void _initSettingsListeners() {
    ever(tempUnitsMetric, (_) => _handleTempUnitChange());
    ever(timeIs24Hrs, (_) => _handleTimeFormatChange());
    ever(precipInMm, (_) => _handlePrecipUnitChange());
    ever(speedInKm, (_) => _handleSpeedUnitChange());
  }

  Future<void> _handleTempUnitChange() async {
    storageController.storeTempUnitSetting(setting: tempUnitsMetric.value);
    settingHasChanged = true;
    convertingTempUnits = true;
    tempUnitSettingChangesSinceRefresh++;
    _setTempUnitString();

    if (!weatherRepository.isLoading.value) {
      await conversionController.convertAppTempUnit();
    }

    convertingTempUnits = false;
    settingHasChanged = false;
    update();
  }

  void _handleTimeFormatChange() {
    storageController.storeTimeFormatSetting(setting: timeIs24Hrs.value);
    hourlyForecastController.buildHourlyForecastWidgets();
    update();
  }

  Future<void> _handlePrecipUnitChange() async {
    storageController.storePrecipUnitSetting(setting: precipInMm.value);
    settingHasChanged = true;
    convertingPrecipUnits = true;
    _setPrecipUnitString();

    if (!weatherRepository.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingPrecipUnits = false;
    settingHasChanged = false;
    update();
  }

  Future<void> _handleSpeedUnitChange() async {
    storageController.storeSpeedUnitSetting(setting: speedInKm.value);
    settingHasChanged = true;
    convertingSpeedUnits = true;
    _setSpeedUnitString();

    if (!weatherRepository.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingSpeedUnits = false;
    settingHasChanged = false;
    update();
  }

  void _setTempUnitString() {
    tempUnitString = tempUnitsMetric.value ? 'C' : 'F';
    update();
  }

  void _setPrecipUnitString() {
    precipUnitString = precipInMm.value ? 'mm' : 'in';
    update();
  }

  void _setSpeedUnitString() {
    speedUnitString = speedInKm.value ? 'kph' : 'mph';
    update();
  }

  Future<void> _rebuildForecastWidgets() async {
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }

  void resetSettingChangeCounters() => tempUnitSettingChangesSinceRefresh = 0;

  bool needsConversion() => tempUnitSettingChangesSinceRefresh.isOdd;

  /// Returns true and triggers a conversion on refresh if user temp unit setting sets
  /// api to return either metric or imperial, and user setting
  /// of speed or precip measurement setting doesn't match values being returned

  bool mismatchedMetricSettings() {
    if (mismatchedSpeedUnitSetting()) {
      return true;
    } else if (mismatchedPrecipUnitSetting()) {
      return true;
    } else {
      return false;
    }
  }

  bool mismatchedSpeedUnitSetting() {
    if (!tempUnitsMetric.value && speedInKm.value) {
      return true;
    } else if (tempUnitsMetric.value && !speedInKm.value) {
      return true;
    } else {
      return false;
    }
  }

  bool mismatchedPrecipUnitSetting() {
    if (tempUnitsMetric.value && !precipInMm.value) {
      return true;
    } else if (!tempUnitsMetric.value && precipInMm.value) {
      return true;
    } else {
      return false;
    }
  }
}
