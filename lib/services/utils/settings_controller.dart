import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
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
  final storageController = Get.find<StorageController>();
  final weatherRepository = Get.find<WeatherRepository>();

  int currentTemp, feelsLike;

  RxBool tempUnitsCelcius = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool precipInCm = false.obs;
  RxBool speedInKm = false.obs;
  RxBool convertingUnits = false.obs;
  RxBool appIsStarting = true.obs;

  Color selectedColor = Colors.green[400];
  Color unSelectedColor = Colors.grey;

  @override
  void onInit() {
    debugPrint('Settings controller onInit');
    super.onInit();
    _initSettingsListener();
    tempUnitsCelcius(storageController.restoreTempUnitSetting());
    appIsStarting(false);
  }

  _initSettingsListener() {
    ever(
      tempUnitsCelcius,
      (_) {
        if (!appIsStarting.value || !weatherRepository.isLoading.value) {
          _updateTempUnits();
          // hourlyForecastController.buildHourlyForecastWidgets();
        }
        _getCurrentValues();
        storageController.storeUpdatedCurrentTempUnits(currentTemp, feelsLike);

        update();
        convertingUnits(true);

        debugPrint('tempUnitsCelcius listener: $tempUnitsCelcius');
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

  void _updateTempUnits() {
    storageController.storeTempUnitSetting(tempUnitsCelcius.value);
    _getCurrentValues();
    debugPrint('TempUnitsCelcius: $tempUnitsCelcius');
    if (tempUnitsCelcius.value) {
      _convertCurrentTempToCelcius();
    } else {
      _convertCurrentTempToFahrenheit();
    }
  }

  void _convertCurrentTempToCelcius() {
    currentWeatherController.temp =
        unitConverter.convertToCelcius(currentTemp).toString();
    currentWeatherController.feelsLike =
        unitConverter.convertToCelcius(feelsLike).toString();
    storageController.storeUpdatedCurrentTempUnits(currentTemp, feelsLike);
    currentWeatherController.update();
  }

  void _convertCurrentTempToFahrenheit() {
    currentWeatherController.temp =
        unitConverter.convertToFahrenHeight(currentTemp).toString();
    currentWeatherController.feelsLike =
        unitConverter.convertToFahrenHeight(feelsLike).toString();
    storageController.storeUpdatedCurrentTempUnits(currentTemp, feelsLike);

    currentWeatherController.update();
  }

  void _getCurrentValues() {
    debugPrint('current temp: ${currentWeatherController.temp}');
    currentTemp = (int.parse(currentWeatherController.temp));
    feelsLike = (int.parse(currentWeatherController.feelsLike));
  }
}
