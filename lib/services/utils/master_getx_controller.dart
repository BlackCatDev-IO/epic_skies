import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
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
import 'failure_handler.dart';
import 'life_cycle_controller.dart';
import 'location_controller.dart';

class MasterController extends GetxController {
  static MasterController get to => Get.find();
  bool firstTimeUse = true;

  Future<void> initControllers() async {
    Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage();
    Get.put(LocationController(), permanent: true);
    Get.put(WeatherRepository(), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(ApiCaller(), permanent: true);
    Get.put(ViewController(), permanent: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<BgImageController>(() => BgImageController(), fenix: true);
    Get.lazyPut<CurrentWeatherController>(() => CurrentWeatherController(),
        fenix: true);
    Get.lazyPut<DailyForecastController>(() => DailyForecastController(),
        fenix: true);
    Get.lazyPut<HourlyForecastController>(() => HourlyForecastController(),
        fenix: true);
    Get.lazyPut<ColorController>(() => ColorController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<TimeZoneController>(() => TimeZoneController(), fenix: true);
    Get.lazyPut<FailureHandler>(() => FailureHandler(), fenix: true);

    firstTimeUse = StorageController.to.firstTimeUse();

    if (!firstTimeUse) {
      _initFromStorage();
    }

    _startupSearch();
  }

  Future<void> _startupSearch() async {
    final bool searchIsLocal =
        StorageController.to.restoreSavedSearchIsLocal() ?? true;
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      if (searchIsLocal) {
        await WeatherRepository.to.fetchLocalWeatherData();
      } else {
        await WeatherRepository.to.updateRemoteLocationData();
      }
    } else {
      showNoConnectionDialog(context: Get.context);
    }
  }

  void onRefresh() {
    final bool searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      WeatherRepository.to.fetchLocalWeatherData();
    } else {
      WeatherRepository.to.updateRemoteLocationData();
    }
  }

  void initUiValues() {
    CurrentWeatherController.to.initCurrentWeatherValues();
    LocationController.to.initLocationValues();
    DailyForecastController.to.buildDailyForecastWidgets();
    HourlyForecastController.to.buildHourlyForecastWidgets();
  }

  Future<void> _initFromStorage() async {
    BgImageController.to.initImageSettingsFromStorage();
    SearchController.to.restoreSearchHistory();

    LocationController.to.locationMap =
        StorageController.to.restoreLocalLocationData() ?? {};
    TimeZoneController.to.isDayCurrent =
        StorageController.to.restoreDayOrNight();

    initUiValues();
  }
}
