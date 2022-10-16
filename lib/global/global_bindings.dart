import 'package:dio/dio.dart';
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
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/view_controllers.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get/get.dart';

import '../features/location/user_location/controllers/location_controller.dart';
import '../services/asset_controllers/bg_image_controller.dart';

class GlobalBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    final storage = Get.put(StorageController(), permanent: true);
    await storage.initAllStorage();

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
    Get.put(LocationController(storage: storage), permanent: true);
    Get.put(RemoteLocationController(storage: storage), permanent: true);
    Get.put(LifeCycleController(), permanent: true);
    Get.put(TabNavigationController(), permanent: true);
    Get.put(ColorController(), permanent: true);
    Get.put(BgImageController(storage: storage));
    Get.put(SunTimeController(storage: storage));
    Get.put(WeatherRepository(storage: storage), permanent: true);

    Get.put(
      CurrentWeatherController(
        weatherRepository: WeatherRepository.to,
      ),
      permanent: true,
    );

    Get.put(
      HourlyForecastController(
        weatherRepository: WeatherRepository.to,
        currentWeatherController: CurrentWeatherController.to,
      ),
      permanent: true,
    );

    Get.put(
      DailyForecastController(
        weatherRepository: WeatherRepository.to,
        currentWeatherController: CurrentWeatherController.to,
        hourlyForecastController: HourlyForecastController.to,
      ),
      permanent: true,
    );

    Get.put(AdaptiveLayoutController());
    Get.put(ScrollPositionController());

    Get.lazyPut<UnitSettingsController>(
      () => UnitSettingsController(
        weatherRepo: WeatherRepository.to,
      ),
      fenix: true,
    );

    if (!storage.firstTimeUse()) {
      WeatherRepository.to.updateUIValues(isRefresh: true);
      _initTimeZoneOffSetFromStorage(storage.restoreCoordinates());
    }
    WeatherRepository.to.fetchLocalWeatherData();
    Get.delete<FileController>();
  }

  void _initTimeZoneOffSetFromStorage(Map<String, dynamic> coordinates) {
    final lat = coordinates['lat'] as double;
    final long = coordinates['long'] as double;
    TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);
  }
}
