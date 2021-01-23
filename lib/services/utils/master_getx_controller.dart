import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../local_constants.dart';
import 'image_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  final box = GetStorage();
  final locationBox = GetStorage(locationMapKey);

  @override
  void onInit() async {
    super.onInit();
    debugPrint('Master Controller onInit');

    final map = box.read(dataMapKey);
    final weatherController = Get.put(WeatherController(), permanent: true);

    final locationController = Get.put(LocationController(), permanent: true);
    final imageController = Get.put(ImageController(), permanent: true);
    final forecastController = Get.put(ForecastController(), permanent: true);

    weatherController.dataMap.assignAll(map);
    locationController.locationMap = locationBox.read(locationMapKey);
    imageController.backgroundImageString.value =
        map[backgroundImageKey] ?? clearDay1;
    weatherController.initCurrentWeatherValues();
    locationController.initLocationValues();
    await forecastController.buildForecastWidgets();

    await weatherController.getAllWeatherData();
  }
}
