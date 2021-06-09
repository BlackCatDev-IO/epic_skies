import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/firestore_database.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/global/alert_dialogs/network_error_dialogs.dart';
import 'package:epic_skies/global/life_cycle_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'asset_image_controllers/bg_image_controller.dart';
import 'failure_handler.dart';
import 'location/location_controller.dart';

class MasterController extends GetxController {
  static MasterController get to => Get.find();
  bool firstTimeUse = true;

  Future<void> initControllers() async {
    Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage();
    firstTimeUse = StorageController.to.firstTimeUse();

    Get.put(LocationController(), permanent: true);
    Get.put(WeatherRepository(), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(ViewController(), permanent: true);
    Get.put(ApiCaller(), permanent: true);
    Get.lazyPut<BgImageController>(() => BgImageController(), fenix: true);

    Get.lazyPut<CurrentWeatherController>(() => CurrentWeatherController(),
        fenix: true);
    Get.lazyPut<DailyForecastController>(() => DailyForecastController(),
        fenix: true);
    Get.lazyPut<HourlyForecastController>(() => HourlyForecastController(),
        fenix: true);
    Get.lazyPut<UnitSettingsController>(() => UnitSettingsController(),
        fenix: true);
    Get.lazyPut<TimeZoneController>(() => TimeZoneController(), fenix: true);
    Get.lazyPut<FailureHandler>(() => FailureHandler(), fenix: true);
    Get.lazyPut<FirebaseImageController>(() => FirebaseImageController());
    Get.lazyPut<FileController>(() => FileController(), fenix: true);

    if (firstTimeUse) {
      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      await FileController.to.restoreImageFiles();
    } else {
      await FileController.to.restoreImageFiles();
      initUiValues();
    }

    _startupSearch();
  }

  Future<void> _startupSearch() async {
    final bool searchIsLocal = WeatherRepository.to.searchIsLocal;
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      if (searchIsLocal) {
        await WeatherRepository.to.fetchLocalWeatherData();
      } else {
        await WeatherRepository.to.updateRemoteLocationData();
      }
    } else {
      showNoConnectionDialog(context: Get.context);
    }
    _deleteUnusedControllers();
  }

  void onRefresh() {
    final bool searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      WeatherRepository.to.fetchLocalWeatherData();
    } else {
      WeatherRepository.to.updateRemoteLocationData();
    }
  }

  Future<void> initUiValues() async {
    CurrentWeatherController.to.initCurrentWeatherValues();
    LocationController.to.initLocationValues();
    DailyForecastController.to.buildDailyForecastWidgets();
    HourlyForecastController.to.buildHourlyForecastWidgets();
  }

  void _deleteUnusedControllers() {
    Get.delete<FileController>();
    Get.delete<FirebaseImageController>();
    Get.delete<UnitSettingsController>();
  }
}
