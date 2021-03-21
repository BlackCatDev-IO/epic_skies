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
  static WeatherRepository get to => Get.find();

  RxBool isLoading = false.obs;

  String sunsetTime = '';
  String sunriseTime = '';

  Map todayMap = {};

  Future<void> getAllWeatherData() async {
    const failureHandler = FailureHandler();

    SearchController.to.updateSearchIsLocalBool(value: true);

    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      isLoading(true);
      await LocationController.to.getLocationAndAddress();
      TimeZoneController.to.initTimezoneString();

      final long = LocationController.to.position.longitude;
      final lat = LocationController.to.position.latitude;
      final apiCaller = ApiCaller();
      final url = apiCaller.buildClimaCellUrl(long: long, lat: lat);
      final data = await apiCaller.getWeatherData(url);

      StorageController.to.storeWeatherData(map: data);
      TimeZoneController.to.getTimeZoneOffset();

      if (MasterController.to.firstTimeUse) {
        Get.to(() => const CustomAnimatedDrawer());
        MasterController.to.firstTimeUse = false;
      }

      MasterController.to.initUiValues();
      isLoading(false);
      SettingsController.to.resetSettingChangeCounters();
    } else {
      showNoConnectionDialog(context: Get.context);

      failureHandler.handleNoConnection();
    }
  }
}
