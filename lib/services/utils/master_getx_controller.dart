import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'image_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  bool firstTimeUse = true;
  bool noDataOnStartup = false;

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
    Get.put(SearchController());
    Get.put(WeatherRepository(), permanent: true);
    Get.put(BgImageController());
    Get.put(CurrentWeatherController());
    Get.put(DailyForecastController());
    Get.put(HourlyForecastController());
    Get.put(ViewController());
    Get.lazyPut<ColorController>(() => ColorController());
    Get.lazyPut<SettingsController>(() => SettingsController());

    _findControllers();
    firstTimeUse = storageController.firstTimeUse();
  }

  void startupSearch() async {
    final bool searchIsLocal =
        storageController.restoreSavedSearchIsLocal() ?? true;
    bool hasConnection = await DataConnectionChecker().hasConnection;

    if (!firstTimeUse) {
      _initFromStorage();
    }

    if (hasConnection) {
      if (searchIsLocal) {
        await weatherRepository.getAllWeatherData();
      } else {
        final suggestion = storageController.restoreLatestSuggestion;
        await searchController.searchSelectedLocation(suggestion: suggestion());
      }
    } else {
      noDataOnStartup = true;
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

  Future<void> _initFromStorage() async {
    await storageController.initDataMap();
    searchController.restoreSearchHistory();

    locationController.locationMap =
        storageController.restoreLocationData() ?? {};
    weatherRepository.getDayOrNight();
    imageController.bgDynamicImageString.value =
        storageController.storedImage();
    await initUiValues();
    showDialogIfNoDataOnStartup(Get.context);
  }

  void showDialogIfNoDataOnStartup(BuildContext context) {
    if (noDataOnStartup) {
      showNoConnectionDialog(context: context);
    }
  }

  void _findControllers() {
    weatherRepository = Get.find<WeatherRepository>();
    locationController = Get.find<LocationController>();
    storageController = Get.find<StorageController>();
    searchController = Get.find<SearchController>();
    imageController = Get.find<BgImageController>();
    currentWeatherController = Get.find<CurrentWeatherController>();
    dailyForecastController = Get.find<DailyForecastController>();
    hourlyForecastController = Get.find<HourlyForecastController>();
  }
}
