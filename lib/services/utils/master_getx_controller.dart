import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/tab_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../local_constants.dart';
import 'image_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  final box = GetStorage(dataMapKey);
  final locationBox = GetStorage(locationMapKey);
  RxBool firstTimeUse = true.obs;

  @override
  void onInit() async {
    super.onInit();
    debugPrint('Master Controller onInit');

    final weatherController = Get.put(WeatherController(), permanent: true);
    final locationController = Get.put(LocationController(), permanent: true);
    final imageController = Get.put(ImageController(), permanent: true);
    final forecastController = Get.put(ForecastController(), permanent: true);
    Get.put(ColorController());
    Get.put(TabBarController());

    final Map<String, dynamic> map = box.read(dataMapKey);
    if (map != null) {
      weatherController.dataMap.assignAll(map);
      firstTimeUse.value = false;
      locationController.locationMap = locationBox.read(locationMapKey);
      weatherController.getDayOrNight();
      weatherController.now.value = DateTime.now().hour;
      await weatherController.initCurrentWeatherValues();
      await locationController.initLocationValues();
      await forecastController.buildForecastWidgets();
      imageController.backgroundImageString.value =
          map[backgroundImageKey] ?? clearDay1;
    }
    await weatherController.getAllWeatherData();
  }
}
