import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
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

  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint('Master Controller onInit');
    await GetStorage.init(dataMapKey);
    await GetStorage.init(locationMapKey);
    await GetStorage.init(recentSearchesKey);

    Get.put(StorageController());
    Get.put(WeatherController(), permanent: true);
    Get.put(ImageController());
    Get.put(LocationController(), permanent: true);
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
    final searchController = Get.find<SearchController>();
    final bool searchIsLocal =
        storageController.restoreSavedSearchIsLocal() ?? true;

    if (!firstTimeUse.value) {
      storageController.initDataMap();
      searchController.restoreSearchHistory();

      locationController.locationMap =
          storageController.restoreLocationData() ?? {};
      weatherController.getDayOrNight();
      weatherController.now = DateTime.now().hour;
      Get.find<ImageController>().backgroundImageString.value =
          storageController.storedImage();
      initUiValues();
    }
    if (searchIsLocal) {
      await weatherController.getAllWeatherData();
    } else {
      final suggestion = storageController.restoreLatestSuggestion;
      await searchController.searchSelectedLocation(suggestion: suggestion());
    }
  }

  void initUiValues() async {
    await Get.find<WeatherController>().initCurrentWeatherValues();
    await Get.find<LocationController>().initLocationValues();
    Get.find<ForecastController>().buildForecastWidgets();
  }
}
