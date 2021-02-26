
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  RxBool tempUnitsCelcius = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool precipInCm = false.obs;
  RxBool speedInKm = false.obs;

  Color selectedColor = Colors.green[400];
  Color unSelectedColor = Colors.grey;

  @override
  void onInit() {
    super.onInit();
    _initSettingsListener();
  }

  _initSettingsListener() {
    ever(
      tempUnitsCelcius,
      (_) {
        debugPrint('tempUnitsCelcius listener: $tempUnitsCelcius');
        update();
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

  void updateTempUnits() {
    debugPrint('TempUnitsCelcius: $tempUnitsCelcius');
    final currentWeatherController = Get.find<CurrentWeatherController>();
    final currentTemp = (int.parse(currentWeatherController.temp));
    final feelsLike = (int.parse(currentWeatherController.feelsLike));

    if (tempUnitsCelcius.value) {
      currentWeatherController.temp =
          _convertToFahrenHeight(currentTemp).toString();
      currentWeatherController.feelsLike =
          _convertToFahrenHeight(feelsLike).toString();
    } else {
      currentWeatherController.temp = _convertToCelcius(currentTemp).toString();
      currentWeatherController.feelsLike =
          _convertToCelcius(feelsLike).toString();
    }
    tempUnitsCelcius = tempUnitsCelcius.toggle();
    // currentWeatherController.remoteUpdate();
    currentWeatherController.update();
  }

  int _convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();
  int _convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();
}
