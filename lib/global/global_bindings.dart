import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:get/get.dart';

import '../core/database/firestore_database.dart';
import '../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../features/sun_times/controllers/sun_time_controller.dart';
import '../services/app_updates/update_controller.dart';
import '../services/ticker_controllers/tab_navigation_controller.dart';
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

    Get.put(TabNavigationController(), permanent: true);
    Get.put(ColorController(), permanent: true);

    Get.put(SunTimeController(storage: storage));

    Get.put(HourlyForecastController(), permanent: true);

    Get.put(
      DailyForecastController(
        hourlyForecastController: HourlyForecastController.to,
      ),
      permanent: true,
    );
  }
}
