import 'package:dio/dio.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import '../core/app_lifecycle/life_cycle_controller.dart';
import '../core/database/file_controller.dart';
import '../core/database/firestore_database.dart';
import '../core/network/api_caller.dart';
import '../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../features/sun_times/controllers/sun_time_controller.dart';
import '../services/app_updates/update_controller.dart';
import '../services/asset_controllers/bg_image_controller.dart';
import '../services/loading_status_controller/loading_status_controller.dart';
import '../services/ticker_controllers/tab_navigation_controller.dart';
import '../services/view_controllers/adaptive_layout_controller.dart';
import '../services/view_controllers/color_controller.dart';

class GlobalBindings {
  Future<void> initGetxControllers({
    required StorageController storage,
  }) async {
    Get.put(UpdateController(storage));

    if (storage.firstTimeUse()) {
      Get.put(FirebaseImageController(storage: storage));

      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      Get.delete<FirebaseImageController>();
      UpdateController.to.storeCurrentAppVersion();
    }

    Get.put(ApiCaller(Dio()));
    Get.put(FileController(storage: storage));
    await FileController.to.restoreImageFiles();
    Get.put(LifeCycleController(), permanent: true);
    Get.put(TabNavigationController(), permanent: true);
    Get.put(ColorController(), permanent: true);
    Get.put(
      BgImageController(
        storage: storage,
        imageFiles: FileController.to.imageFileMap,
      ),
    );
    Get.put(SunTimeController(storage: storage));

    Get.put(HourlyForecastController(), permanent: true);

    Get.put(
      DailyForecastController(
        hourlyForecastController: HourlyForecastController.to,
      ),
      permanent: true,
    );

    Get.put(
      AdaptiveLayoutController(
        storage: storage,
        hasNotch: IphoneHasNotch.hasNotch,
      ),
    );
    Get.put(LoadingStatusController());

    Get.delete<FileController>();
  }
}
