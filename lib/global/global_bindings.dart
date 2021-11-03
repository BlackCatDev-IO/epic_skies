import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:epic_skies/services/database/file_controller.dart';
import 'package:epic_skies/services/database/firestore_database.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/lifecycle/life_cycle_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/adaptive_layout_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/scroll_position_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather_forecast/forecast_controllers.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import '../services/location/location_controller.dart';
import '../services/utils/asset_image_controllers/bg_image_controller.dart';

class GlobalBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage();
    Get.put(UpdateController());

    _initAdaptiveLayoutValues();

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
    Get.put(LifeCycleController(), permanent: true);
    Get.put(ViewController(), permanent: true);
    Get.put(ColorController(), permanent: true);
    Get.put(BgImageController());
    Get.put(TimeZoneController(), permanent: true);
    Get.put(ApiCaller());
    Get.put(WeatherRepository(), permanent: true);
    Get.put(CurrentWeatherController(), permanent: true);
    Get.put(HourlyForecastController(), permanent: true);
    Get.put(DailyForecastController(), permanent: true);
    Get.put(ScrollPositionController());
    Get.put(SunTimeController());
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

  void _initAdaptiveLayoutValues() {
    final adaptiveLayoutModel = StorageController.to.adaptiveLayoutModel();
    if (adaptiveLayoutModel.isEmpty) {
      Get.put(AdaptiveLayoutController());
      AdaptiveLayoutController.to
          .setAppBarHeight(hasNotch: IphoneHasNotch.hasNotch);
      Get.delete<AdaptiveLayoutController>();
    }
  }
}
