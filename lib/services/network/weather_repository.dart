import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/failures.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/location_controller.dart';

class WeatherRepository extends GetxController {
  final storageController = Get.find<StorageController>();
  final locationController = Get.find<LocationController>();
  final masterController = Get.find<MasterController>();
  final searchController = Get.find<SearchController>();

  bool isDay = true;
  RxBool isLoading = false.obs;

  String sunsetTime = '';
  String sunriseTime = '';

  Future<void> getAllWeatherData() async {
    debugPrint('getNewWeatherData called');
    final failureHandler = FailureHandler();
    searchController.updateSearchIsLocalBool(true);

    bool hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      isLoading(true);
      await locationController.getLocationAndAddress();

      // try {
      // } on FailureHandler catch (f) {
      //   // _setFailure();
      // }

      final long = locationController.position.longitude;
      final lat = locationController.position.latitude;
      final apiCaller = ApiCaller();
      final url = apiCaller.getClimaCellUrl(long: long, lat: lat);
      final data = await apiCaller.getWeatherData(url);

      storageController.storeWeatherData(map: data);

      getDayOrNight();

      bool firstTime = masterController.firstTimeUse;

      if (firstTime) {
        Get.to(() => CustomAnimatedDrawer(child: HomeTabView()));
        firstTime = false;
      }

      isLoading(false);
      masterController.initUiValues();
    } else {
      showNoConnectionDialog(context: Get.context);

      failureHandler.handleNoConnection();
    }
  }

  void getDayOrNight() {
    debugPrint('getDayOrNight isDay value at beginning of function: $isDay');
    final todayMap =
        storageController.dataMap['timelines'][1]['intervals'][0]['values'];
    sunsetTime = todayMap['sunsetTime'];
    sunriseTime = todayMap['sunriseTime'];
    final sunrise = DateTime.parse(sunriseTime);
    final sunset = DateTime.parse(sunsetTime);
    final now = DateTime.now();
    isDay = now.isBefore(sunset) && sunrise.isBefore(now);
    debugPrint('getDayOrNight isDay value at end of function: $isDay');
  }
}
