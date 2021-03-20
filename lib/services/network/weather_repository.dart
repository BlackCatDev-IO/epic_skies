import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/failures.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:get/get.dart';

import '../utils/location_controller.dart';

class WeatherRepository extends GetxController {
  final storageController = Get.find<StorageController>();
  final locationController = Get.find<LocationController>();
  final masterController = Get.find<MasterController>();
  final searchController = Get.find<SearchController>();

  bool isDayCurrent = true;
  bool isDayForecast = false;
  RxBool isLoading = false.obs;

  String sunsetTime = '';
  String sunriseTime = '';

  Map todayMap = {};

  Future<void> getAllWeatherData() async {
    const failureHandler = FailureHandler();

    searchController.updateSearchIsLocalBool(value: true);

    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      isLoading(true);
      await locationController.getLocationAndAddress();
      Get.find<TimeZoneController>().getTimeZoneOffset();

      final long = locationController.position.longitude;
      final lat = locationController.position.latitude;
      final apiCaller = ApiCaller();
      final url = apiCaller.getClimaCellUrl(long: long, lat: lat);
      final data = await apiCaller.getWeatherData(url);

      storageController.storeWeatherData(map: data);

      if (masterController.firstTimeUse) {
        Get.to(() => const CustomAnimatedDrawer());
        masterController.firstTimeUse = false;
      }

      masterController.initUiValues();
      isLoading(false);
      Get.find<SettingsController>().resetSettingChangeCounters();
    } else {
      showNoConnectionDialog(context: Get.context);

      failureHandler.handleNoConnection();
    }
  }
}
