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

  int currentTemp, feelsLike;

  bool convertingUnits = false;

  RxBool tempUnitsCelcius = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool precipInCm = false.obs;
  RxBool speedInKm = false.obs;

  Color selectedColor = Colors.green[400];
  Color unSelectedColor = Colors.grey;

  String tempUnitString = '';

  @override
  void onInit() async {
    debugPrint('Settings controller onInit');
    super.onInit();
    await _initTempUnitSettingFromStorage();

    tempUnitString = tempUnitsCelcius.value ? 'C' : 'F';

    _initSettingsListener();
  }

  Future<void> _initTempUnitSettingFromStorage() async {
    tempUnitsCelcius(storageController.restoreTempUnitSetting());
  }

  void _initSettingsListener() {
    ever(
      tempUnitsCelcius,
      (_) async {
        convertingUnits = true;

        if (!weatherRepository.isLoading.value) {
          await _updateTempUnits();
        }

        update(); // for toggle switch colors
        convertingUnits = false;
      },
    );
    ever(
      timeIs24Hrs,
      (_) {
        debugPrint('timeIs24Hrs listener: $timeIs24Hrs');
        update();
      },
    );
    ever(
      precipInCm,
      (_) {
        debugPrint('precipInCm listener: $precipInCm');
        update();
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
    storageController.storeTempUnitSetting(tempUnitsCelcius.value);
    _getCurrentValues();

    if (tempUnitsCelcius.value) {
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

  void _getCurrentValues() {
    currentTemp = (int.parse(currentWeatherController.temp));
    feelsLike = (int.parse(currentWeatherController.feelsLike));
  }
}
