import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'conversions/unit_converter.dart';

class SettingsController extends GetxController {
  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  final unitConverter = UnitConverter();

  final currentWeatherController = Get.find<CurrentWeatherController>();
  final hourlyForecastController = Get.find<HourlyForecastController>();
  final dailyForecastController = Get.find<DailyForecastController>();
  final storageController = Get.find<StorageController>();
  final weatherRepository = Get.find<WeatherRepository>();

  int currentTemp, feelsLike, unitSettingChangesSinceRefresh = 0;

  bool convertingTempUnits = false;
  bool convertingMeasurementUnits = false;

  RxBool tempUnitsMetric = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool precipInMm = false.obs;
  RxBool speedInKm = false.obs;

  Color selectedColor = Colors.green[400];
  Color unSelectedColor = Colors.grey;

  String tempUnitString = '';
  String precipUnitString = '';

  @override
  void onInit() async {
    debugPrint('Settings controller onInit');
    super.onInit();
    await _initSettingFromStorage();

    tempUnitString = tempUnitsMetric.value ? 'C' : 'F';
    precipUnitString = precipInMm.value ? 'mm' : 'in';

    _initSettingsListener();
  }

  Future<void> _initSettingFromStorage() async {
    tempUnitsMetric(storageController.restoreTempUnitSetting());
    timeIs24Hrs(storageController.restoreTimeFormatSetting());
  }

  void _initSettingsListener() {
    ever(
      tempUnitsMetric,
      (_) async {
        convertingTempUnits = true;
        unitSettingChangesSinceRefresh++;

        if (!weatherRepository.isLoading.value) {
          await _updateTempUnits();
        }

        update(); // for toggle switch colors
        convertingTempUnits = false;
      },
    );
    ever(
      timeIs24Hrs,
      (_) {
        hourlyForecastController.buildHourlyForecastWidgets();
        storageController.storeTimeFormatSetting(timeIs24Hrs.value);
        update();
      },
    );
    ever(
      precipInMm,
      (_) async {
        convertingMeasurementUnits = true;

        if (!weatherRepository.isLoading.value) {
          await _updateMeasurementUnits();
        }
        debugPrint('precipInCm listener: $precipInMm');
        update();
        convertingMeasurementUnits = false;
      },
    );
    ever(
      speedInKm,
      (_) {
        debugPrint('speedInKm listener: $speedInKm');
        update();
      },
    );
  }

  Future<void> _updateTempUnits() async {
    storageController.storeTempUnitSetting(tempUnitsMetric.value);
    _getCurrentValues();

    if (tempUnitsMetric.value) {
      _convertCurrentTempToCelcius();
    } else {
      _convertCurrentTempToFahrenheit();
    }

    storageController.storeUpdatedCurrentTempUnits(currentTemp, feelsLike);
    update();
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }

  void _convertCurrentTempToCelcius() {
    currentWeatherController.temp =
        unitConverter.convertToCelcius(currentTemp).toString();
    currentWeatherController.feelsLike =
        unitConverter.convertToCelcius(feelsLike).toString();
    tempUnitString = 'C';
    currentWeatherController.update();
    _getCurrentValues();
  }

  void _convertCurrentTempToFahrenheit() {
    currentWeatherController.temp =
        unitConverter.convertToFahrenHeight(currentTemp).toString();
    currentWeatherController.feelsLike =
        unitConverter.convertToFahrenHeight(feelsLike).toString();
    tempUnitString = 'F';

    currentWeatherController.update();
    _getCurrentValues();
  }

  Future<void> _updateMeasurementUnits() async {
    precipUnitString = precipInMm.value ? 'mm' : 'in';
    hourlyForecastController.buildHourlyForecastWidgets();
    dailyForecastController.buildDailyForecastWidgets();
  }

  void _getCurrentValues() {
    currentTemp = (int.parse(currentWeatherController.temp));
    feelsLike = (int.parse(currentWeatherController.feelsLike));
  }
}
