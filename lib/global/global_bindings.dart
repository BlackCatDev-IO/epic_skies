import 'package:epic_skies/core/app_lifecycle/life_cycle_controller.dart';
import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/firestore_database.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:epic_skies/services/location/remote_location_controller.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/view_controllers/view_controllers.dart';
import 'package:epic_skies/services/weather_forecast/forecast_controllers.dart';
import 'package:get/get.dart';

import '../services/asset_controllers/bg_image_controller.dart';
import '../services/location/location_controller.dart';

class GlobalBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage();
    Get.put(UpdateController());

    final firstTimeUse = StorageController.to.firstTimeUse();

    if (firstTimeUse) {
      Get.put(FirebaseImageController());

      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      Get.delete<FirebaseImageController>();
      UpdateController.to.storeCurrentAppVersion();
    }

    Get.put(FileController());
    await FileController.to.restoreImageFiles();
    Get.put(LocationController(), permanent: true);
    Get.put(RemoteLocationController(), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(DrawerAnimationController(), permanent: true);
    Get.put(TabNavigationController(), permanent: true);
    Get.put(ColorController(), permanent: true);
    Get.put(BgImageController());
    Get.put(TimeZoneController(), permanent: true);
    Get.put(ApiCaller());
    Get.put(SunTimeController());

    Get.put(WeatherRepository(), permanent: true);
    Get.put(CurrentWeatherController(), permanent: true);
    Get.put(HourlyForecastController(), permanent: true);
    Get.put(DailyForecastController(), permanent: true);
    Get.put(ScrollPositionController());
    Get.lazyPut<UnitSettingsController>(
      () => UnitSettingsController(),
      fenix: true,
    );

    if (!firstTimeUse) {
      WeatherRepository.to.updateUIValues();
    }

    WeatherRepository.to.fetchLocalWeatherData();
    Get.delete<FileController>();
  }
}
