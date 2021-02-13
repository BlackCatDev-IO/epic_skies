import 'package:epic_skies/screens/home_tab_view.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/location_controller.dart';

class WeatherRepository extends GetxController {
  final storageController = Get.find<StorageController>();
  final locationController = Get.find<LocationController>();
  final masterController = Get.find<MasterController>();

  Map<String, dynamic> dataMap = {};

  bool isDay = true;
  RxBool isLoading = true.obs;

  int now = 0;
  String sunsetTime = '';
  String sunriseTime = '';

  Future<void> getAllWeatherData() async {
    debugPrint('getNewWeatherData called');
    isLoading(true);

    await locationController.getLocationAndAddress();

    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;
    final apiCaller = ApiCaller();
    now = DateTime.now().hour;

    final url = apiCaller.getClimaCellUrl(long: long, lat: lat);
    final data = await apiCaller.getWeatherData(url);

    dataMap = data;
    storageController.storeWeatherData(map: data);
    final hourlyTime =
        DateTime.parse(data['timelines'][0]['intervals'][0]['startTime']);
    debugPrint(hourlyTime.hour.toString());
    debugPrint(hourlyTime.toString());
    getDayOrNight();

    Get.find<SearchController>().updateSearchIsLocalBool(true);

    bool firstTime = masterController.firstTimeUse;

    if (firstTime) {
      Get.to(HomeTabView());
      firstTime = false;
    }
    isLoading(false);

    update();

    await masterController.initUiValues();
  }
// $.data.timelines[1].intervals[0].values
// $.data.timelines[1].intervals[0].values.temperature
  void getDayOrNight() {
    debugPrint('getDayOrNight isDay value at beginning of function: $isDay');
    final todayMap = storageController.dataMap['timelines'][1]['intervals'][0]['values'];
    sunsetTime = todayMap['sunsetTime'];

    sunriseTime = todayMap['sunriseTime'];

    // final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTime * 1000);
    final sunrise = DateTime.parse(sunriseTime);
    // final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTime * 1000);
    final sunset = DateTime.parse(sunsetTime);
    final now = DateTime.now();

    isDay = now.isBefore(sunset) && sunrise.isBefore(now);
    debugPrint('getDayOrNight isDay value at end of function: $isDay');
  }

  // String getTimeFromUTC(int rawTime) {
  //   final time = DateTime.fromMillisecondsSinceEpoch(rawTime * 1000);
  //   return time.toString();
  // }
}
