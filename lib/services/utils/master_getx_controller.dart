import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/controllers/daily_forecast_controller.dart';
import 'package:epic_skies/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/services/database/file_controller.dart';
import 'package:epic_skies/services/database/firestore_database.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/lifecycle/life_cycle_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:get/get.dart';

import '../error_handling/failure_handler.dart';
import '../location/location_controller.dart';
import 'asset_image_controllers/bg_image_controller.dart';

class MasterController extends GetxController {
  static MasterController get to => Get.find();

  Future<void> initControllers() async {
    Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage();
    final firstTimeUse = StorageController.to.firstTimeUse();

    if (firstTimeUse) {
      Get.put(FirebaseImageController());
      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      Get.delete<FirebaseImageController>();
    }

    Get.put(FileController());
    await FileController.to.restoreImageFiles();
    Get.put(LocationController(), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(ViewController(), permanent: true);
    Get.put(BgImageController());
    Get.put(TimeZoneController(), permanent: true);
    Get.put(ApiCaller());
    Get.put(WeatherRepository(), permanent: true);
    Get.put(CurrentWeatherController(), permanent: true);
    Get.put(HourlyForecastController(), permanent: true);
    Get.put(DailyForecastController(), permanent: true);
    Get.lazyPut<UnitSettingsController>(() => UnitSettingsController(),
        fenix: true);
    Get.lazyPut<FailureHandler>(() => FailureHandler(), fenix: true);

    if (!firstTimeUse) {
      WeatherRepository.to.updateUIValues();
    }
    WeatherRepository.to.refreshWeatherData();
    Get.delete<FileController>();
  }
}
