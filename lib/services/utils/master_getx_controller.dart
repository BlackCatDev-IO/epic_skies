import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:get/get.dart';
import 'asset_image_controllers/bg_image_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  static MasterController get to => Get.find();
  bool firstTimeUse = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Get.put(StorageController()).onInit();
    Get.put(LocationController(), permanent: true);
    Get.put(SearchController());
    Get.put(WeatherRepository(), permanent: true);
    Get.lazyPut<BgImageController>(() => BgImageController());
    Get.lazyPut<CurrentWeatherController>(() => CurrentWeatherController());
    Get.lazyPut<DailyForecastController>(() => DailyForecastController());
    Get.lazyPut<HourlyForecastController>(() => HourlyForecastController());
    Get.lazyPut<ViewController>(() => ViewController());
    Get.lazyPut<ColorController>(() => ColorController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<TimeZoneController>(() => TimeZoneController());

    firstTimeUse = StorageController.to.firstTimeUse();
  }

  Future<void> startupSearch() async {
    final bool searchIsLocal =
        StorageController.to.restoreSavedSearchIsLocal() ?? true;
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (!firstTimeUse) {
      _initFromStorage();
    }

    if (hasConnection) {
      if (searchIsLocal) {
        await WeatherRepository.to.getAllWeatherData();
      } else {
        final suggestion = StorageController.to.restoreLatestSuggestion;
        await SearchController.to
            .searchSelectedLocation(suggestion: suggestion());
      }
    } else {
      showNoConnectionDialog(context: Get.context);
    }
  }

  void onRefresh() {
    final bool searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      WeatherRepository.to.getAllWeatherData();
    } else {
      SearchController.to.updateRemoteLocationData();
    }
  }

  void initUiValues() {
    CurrentWeatherController.to.initCurrentWeatherValues();
    LocationController.to.initLocationValues();
    DailyForecastController.to.buildDailyForecastWidgets();
    HourlyForecastController.to.buildHourlyForecastWidgets();
  }

  Future<void> _initFromStorage() async {
    await StorageController.to.initDataMap();
    BgImageController.to.bgDynamicImageString.value =
        StorageController.to.storedImage();
    SearchController.to.restoreSearchHistory();

    LocationController.to.locationMap =
        StorageController.to.restoreLocationData() ?? {};
    TimeZoneController.to.isDayCurrent =
        StorageController.to.restoreDayOrNight();

    initUiValues();
  }
}
