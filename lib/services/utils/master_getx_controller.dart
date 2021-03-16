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
import 'package:get/get.dart';
import 'image_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  bool firstTimeUse = true;

  WeatherRepository weatherRepository;
  CurrentWeatherController currentWeatherController;
  LocationController locationController;
  StorageController storageController;
  SearchController searchController;
  BgImageController imageController;
  DailyForecastController dailyForecastController;
  HourlyForecastController hourlyForecastController;

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

  Future<void> startupSearch() async {
    final bool searchIsLocal =
        storageController.restoreSavedSearchIsLocal() ?? true;
    final hasConnection = await DataConnectionChecker().hasConnection;

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
      showNoConnectionDialog(context: Get.context);
    }
  }

  void onRefresh() {
    final bool searchIsLocal = storageController.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      weatherRepository.getAllWeatherData();
    } else {
      searchController.updateRemoteLocationData();
    }
  }

  Future<void> initUiValues() async {
    currentWeatherController.initCurrentWeatherValues();
    locationController.initLocationValues();
    dailyForecastController.buildDailyForecastWidgets();
    hourlyForecastController.buildHourlyForecastWidgets();
  }

  Future<void> _initFromStorage() async {
    await storageController.initDataMap();
    imageController.bgDynamicImageString.value =
        storageController.storedImage();
    searchController.restoreSearchHistory();

    locationController.locationMap =
        storageController.restoreLocationData() ?? {};
    weatherRepository.isDay = storageController.restoreDayOrNight();

    initUiValues();
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
