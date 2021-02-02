import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/home_tab_controller.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/utils/network.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import '../utils/location_controller.dart';

class WeatherController extends GetxController {
  final storageController = Get.find<StorageController>();

  bool isDay = true;
  RxBool isLoading = false.obs;

  int now = 0;
  int sunsetTime = 0;
  int sunriseTime = 0;

  String main = '';
  String currentCondition = '';
  String currentTemp = '';
  String feelsLike = '';

  Future<void> getAllWeatherData() async {
    debugPrint('getAllWeatherData called');

    final networkController = NetworkController();

    now = DateTime.now().hour;
    final locationController = Get.find<LocationController>();

    await locationController.getLocationAndAddress();
    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;

    final data = await networkController
        .getData(networkController.getOneCallLocationUrl(long: long, lat: lat));

    final weatherObject = await compute(weatherFromJson, data);

    storageController.storeWeatherData(map: weatherObject.toJson());
    getDayOrNight();

    Get.find<SearchController>().updateSearchIsLocalBool(true);

    final RxBool firstTime = Get.find<MasterController>().firstTimeUse;

    if (firstTime.value) {
      Get.to(HomeTabController());
      firstTime.value = false;
    }
    isLoading(false);

    update();

    Get.find<MasterController>().initUiValues();
  }

  Future<void> initCurrentWeatherValues() async {
    final currentMap = storageController.dataMap['current'];
    currentTemp = currentMap['temp'].round().toString();
    main = currentMap['weather'][0]['main'].toString();
    currentCondition =
        currentMap['weather'][0]['description'].toString().capitalizeFirst;

    debugPrint(('Current Condition: $currentCondition'));

    feelsLike = currentMap[feelsLikeKey].round().toString();
    await Get.find<ImageController>()
        .updateBackgroundImage(main, currentCondition);

    update();
  }

  void getDayOrNight() {
    debugPrint('getDayOrNight isDay value at beginning of function: $isDay');
    final currentMap = storageController.dataMap['current'];
    sunsetTime = currentMap['sunset'];

    sunriseTime = currentMap['sunrise'];

    final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTime * 1000);
    final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTime * 1000);
    final now = DateTime.now();

    isDay = now.isBefore(sunset) && sunrise.isBefore(now);
    debugPrint('getDayOrNight isDay value at end of function: $isDay');
  }

  void remoteUpdate() => update();
}
