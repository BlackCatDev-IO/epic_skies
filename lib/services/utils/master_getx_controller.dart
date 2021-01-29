import 'package:epic_skies/misc/test_page.dart';
import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/tab_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../local_constants.dart';
import 'image_controller.dart';
import 'location_controller.dart';
import 'network.dart';

class MasterController extends GetxController {
  final box = GetStorage(dataMapKey);
  final locationBox = GetStorage(locationMapKey);
  final jsonBox = GetStorage(jsonMapKey);

  String data;
  RxBool firstTimeUse = true.obs;

  Future<Weather> getWeatherObjectFromStorage() async {
    return await compute(weatherFromJson, data);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint('Master Controller onInit');

    final weatherController = Get.put(WeatherController(), permanent: true);
    final locationController = Get.put(LocationController(), permanent: true);
    final imageController = Get.put(ImageController());
    final forecastController = Get.put(ForecastController());

    Get.put(NetworkController(), permanent: true);
    Get.put(ColorController());
    Get.put(TabBarController());
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);

    final Map<String, dynamic> map = box.read(dataMapKey);
    final Map<String, dynamic> jsonMap = jsonBox.read(jsonMapKey);
    if (jsonMap != null) {
      data = await jsonMap[dataMapKey];
      weatherController.weatherObject =  weatherFromJson(data);
      // weatherController.weatherObject = await compute(weatherFromJson, data);

      weatherController.dataMap.assignAll(map);
      weatherController.jsonMap.assignAll(jsonMap);
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
