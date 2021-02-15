import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../local_constants.dart';
import 'image_controller.dart';
import 'location_controller.dart';
import '../network/api_caller.dart';

class MasterController extends GetxController {
  bool firstTimeUse = true;

  var weatherRepository;
  var currentWeatherController;
  var locationController;
  var storageController;
  var searchController;
  var imageController;
  var dailyForecastController;
  var hourlyForecastController;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Get.put(StorageController()).onInit();
    Get.put(LocationController(), permanent: true);
    Get.put(WeatherRepository(), permanent: true);
    Get.put(ImageController());
    Get.put(CurrentWeatherController());
    Get.put(DailyForecastController());
    Get.put(HourlyForecastController());
    Get.put(SearchController());
    Get.put(ViewController());
    Get.lazyPut<ColorController>(() => ColorController());
    Get.lazyPut<SettingsController>(() => SettingsController());

    _findControllers();
    firstTimeUse = storageController.dataBoxIsNull();
  }

  void startupSearch() async {
    final bool searchIsLocal =
        storageController.restoreSavedSearchIsLocal() ?? true;

    if (!firstTimeUse) {
      await storageController.initDataMap();
      searchController.restoreSearchHistory();

      locationController.locationMap =
          storageController.restoreLocationData() ?? {};
      weatherRepository.getDayOrNight();
      weatherRepository.now = DateTime.now().hour;
      imageController.backgroundImageString.value =
          storageController.storedImage();
      await initUiValues();
    }
    if (searchIsLocal) {
      await weatherRepository.getAllWeatherData();
    } else {
      final suggestion = storageController.restoreLatestSuggestion;
      await searchController.searchSelectedLocation(suggestion: suggestion());
    }
  }

  void onRefresh() {
    final bool searchIsLocal = storageController.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      weatherRepository.getAllWeatherData();
    } else
      searchController.updateRemoteLocationData();
  }

  Future<void> initUiValues() async {
    currentWeatherController.initCurrentWeatherValues();
    locationController.initLocationValues();
    dailyForecastController.buildDailyForecastWidgets();
    hourlyForecastController.buildHourlyForecastWidgets();
  }

  void _findControllers() {
    weatherRepository = Get.find<WeatherRepository>();
    locationController = Get.find<LocationController>();
    storageController = Get.find<StorageController>();
    searchController = Get.find<SearchController>();
    imageController = Get.find<ImageController>();
    currentWeatherController = Get.find<CurrentWeatherController>();
    dailyForecastController = Get.find<DailyForecastController>();
    hourlyForecastController = Get.find<HourlyForecastController>();
  }
}
