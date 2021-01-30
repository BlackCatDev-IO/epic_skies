import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/storage_controller.dart';
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
  RxBool firstTimeUse = true.obs;
  final locationBox = GetStorage(locationMapKey);

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint('Master Controller onInit');
    await GetStorage.init(dataMapKey);
    await GetStorage.init(locationMapKey);

    Get.put(WeatherController(), permanent: true);
    Get.put(ImageController());

    Get.put(LocationController(), permanent: true);
    Get.put(StorageController());

    Get.put(ForecastController());

    Get.put(NetworkController(), permanent: true);
    Get.put(ColorController());
    Get.put(TabBarController());
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    firstTimeUse.value = Get.find<StorageController>().dataBoxIsNull();
  }

  void startupSearch() async {
    final weatherController = Get.find<WeatherController>();

    final locationController = Get.find<LocationController>();
    final storageController = Get.find<StorageController>();

    if (!firstTimeUse.value) {

      storageController.initDataMap();
      locationController.locationMap = locationBox.read(locationMapKey);
      weatherController.getDayOrNight();
      weatherController.now = DateTime.now().hour;
      storageController.initBgImage();

      await weatherController.initCurrentWeatherValues();
      await locationController.initLocationValues();
      await Get.find<ForecastController>().buildForecastWidgets();
    }
    await weatherController.getAllWeatherData();
  }
}
