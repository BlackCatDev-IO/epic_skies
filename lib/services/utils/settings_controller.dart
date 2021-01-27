import 'package:epic_skies/services/weather/weather_controller.dart';
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
    final weatherController = Get.find<WeatherController>();
    final currentTemp = (int.parse(weatherController.currentTemp));
    final feelsLike = (int.parse(weatherController.feelsLike));

    if (tempUnitsCelcius.value) {
      weatherController.currentTemp =
          _convertToFahrenHeight(currentTemp).toString();
      weatherController.feelsLike =
          _convertToFahrenHeight(feelsLike).toString();
    } else {
      weatherController.currentTemp = _convertToCelcius(currentTemp).toString();
      weatherController.feelsLike = _convertToCelcius(feelsLike).toString();
    }
    tempUnitsCelcius = tempUnitsCelcius.toggle();
    weatherController.remoteUpdate();
  }

  int _convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();
  int _convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();
}
