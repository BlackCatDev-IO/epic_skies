import 'package:epic_skies/core/app_lifecycle/life_cycle_controller.dart';
import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/firestore_database.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/view_controllers/view_controllers.dart';
import 'package:epic_skies/utils/storage_getters/settings.dart';
import 'package:get/get.dart';

import '../features/location/user_location/controllers/location_controller.dart';
import '../services/asset_controllers/bg_image_controller.dart';

class GlobalBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    final storage = Get.put(StorageController(), permanent: true);
    await StorageController.to.initAllStorage(path: 'epic_skies');
    Get.put(UpdateController(storage));

    if (Settings.firstTimeUse) {
      Get.put(FirebaseImageController());

      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      Get.delete<FirebaseImageController>();
      UpdateController.to.storeCurrentAppVersion();
    }

    Get.put(ApiCaller());

    Get.put(FileController());
    await FileController.to.restoreImageFiles();
    Get.put(LocationController(), permanent: true);
    Get.put(RemoteLocationController(storage: storage), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(DrawerAnimationController(), permanent: true);
    Get.put(TabNavigationController(), permanent: true);
    Get.put(ColorController(), permanent: true);
    Get.put(BgImageController());
    Get.put(TimeZoneController(storage: storage), permanent: true);
    Get.put(SunTimeController(storage: storage));

    final weatherRepository =
        Get.put(WeatherRepository(storage: storage), permanent: true);

    Get.put(
      CurrentWeatherController(
        weatherRepository: weatherRepository,
        storage: storage,
      ),
      permanent: true,
    );

    Get.put(
      HourlyForecastController(
        weatherRepository: weatherRepository,
        currentWeatherController: CurrentWeatherController.to,
      ),
      permanent: true,
    );

    Get.put(
      DailyForecastController(
        weatherRepository: weatherRepository,
        currentWeatherController: CurrentWeatherController.to,
        hourlyForecastController: HourlyForecastController.to,
      ),
      permanent: true,
    );

    Get.put(ScrollPositionController());

    Get.lazyPut<UnitSettingsController>(
      () => UnitSettingsController(
        storage: storage,
        weatherRepo: weatherRepository,
      ),
      fenix: true,
    );

    if (!Settings.firstTimeUse) {
      weatherRepository.updateUIValues();
    }
    ApiCaller().initAndStoreSessionToken();
    weatherRepository.fetchLocalWeatherData();
    Get.delete<FileController>();
  }
}
