import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static const soundNotification = 'sound_notification';
  static const vibrationNotification = 'vibration_notification';

  RxBool tempUnitsCelcius = false.obs;
  RxBool timeIs24Hrs = false.obs;
  RxBool speedInKm = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(
      tempUnitsCelcius,
      (data) {
        debugPrint('Temp Units in Celcius: $data');
        tempUnitsCelcius = tempUnitsCelcius.toggle();
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
      currentWeatherController.feelsLike = _convertToCelcius(feelsLike).toString();
    }
    tempUnitsCelcius = tempUnitsCelcius.toggle();
    currentWeatherController.remoteUpdate();
  }

  int _convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();
  int _convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();
}
