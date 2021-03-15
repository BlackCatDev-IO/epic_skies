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

  int currentTemp, feelsLike, unitSettingChangesSinceRefresh = 0;

  bool convertingTempUnits = false;
  bool convertingMeasurementUnits = false;
  bool convertingSpeedUnits = false;
  bool converting = false;

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
  void onInit() async {
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
    ever(
      tempUnitsMetric,
      (_) async {
        _handleTempUnitChange();
      },
    );

    ever(
      timeIs24Hrs,
      (_) {
        _handleTimeFormatChange();
      },
    );

    ever(
      precipInMm,
      (_) async {
        _handlePrecipUnitChange();
      },
    );

    ever(
      speedInKm,
      (_) async {
        _handleSpeedUnitChange();
      },
    );
  }

  void _handleTempUnitChange() async {
    storageController.storeTempUnitSetting(tempUnitsMetric.value);
    converting = true;
    convertingTempUnits = true;
    unitSettingChangesSinceRefresh++;
    _setTempUnitString();

    if (!weatherRepository.isLoading.value) {
      await conversionController.convertAppToCelcius();
    }

    convertingTempUnits = false;
    converting = false;
    update();
  }

  void _handleTimeFormatChange() {
    storageController.storeTimeFormatSetting(timeIs24Hrs.value);
    hourlyForecastController.buildHourlyForecastWidgets();
    update();
  }

  void _handlePrecipUnitChange() async {
    storageController.storePrecipUnitSetting(precipInMm.value);
    converting = true;
    convertingMeasurementUnits = true;
    _setPrecipUnitString();

    if (!weatherRepository.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingMeasurementUnits = false;
    converting = false;
    update();
  }

  void _handleSpeedUnitChange() async {
    storageController.storeSpeedUnitSetting(speedInKm.value);
    converting = true;
    convertingSpeedUnits = true;
    _setSpeedUnitString();

    if (!weatherRepository.isLoading.value) {
      await _rebuildForecastWidgets();
    }

    convertingSpeedUnits = false;
    converting = false;
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
    speedUnitString = speedInKm.value ? 'kmh' : 'mph';
    update();
  }

  Future<void> _rebuildForecastWidgets() async {
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }
}
