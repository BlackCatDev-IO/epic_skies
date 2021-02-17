import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:get/get.dart';
import 'image_controller.dart';
import 'location_controller.dart';

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
    Get.put(SearchController());
    Get.put(WeatherRepository(), permanent: true);
    Get.put(ImageController());
    Get.put(CurrentWeatherController());
    Get.put(DailyForecastController());
    Get.put(HourlyForecastController());
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
      imageController.backgroundImageString.value =
          storageController.storedImage();
      initUiValues();
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

  void initUiValues() {
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
