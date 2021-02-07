import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/home_tab_view.dart';
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
  final locationController = Get.find<LocationController>();
  final masterController = Get.find<MasterController>();

  bool isDay = true;
  RxBool isLoading = true.obs;

  int now = 0;
  int sunsetTime = 0;
  int sunriseTime = 0;

  String main = '';
  String currentCondition = '';
  String currentTemp = '';
  String feelsLike = '';

  Future<void> getAllWeatherData() async {
    debugPrint('getAllWeatherData called');
    isLoading(true);

    final networkController = NetworkController();

    now = DateTime.now().hour;

    await locationController.getLocationAndAddress();

    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;
    final url = networkController.getOneCallLocationUrl(long: long, lat: lat);
    final data = await networkController.getData(url);
    final weatherObject = await compute(weatherFromJson, data);

    storageController.storeWeatherData(map: weatherObject.toJson());
    getDayOrNight();

    Get.find<SearchController>().updateSearchIsLocalBool(true);

    bool firstTime = masterController.firstTimeUse;

    if (firstTime) {
      Get.to(HomeTabView());
      firstTime = false;
    }
    isLoading(false);

    update();

    masterController.initUiValues();
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

  String getTimeFromUTC(int rawTime) {
    final time = DateTime.fromMillisecondsSinceEpoch(rawTime * 1000);
    return time.toString();
  }

  void remoteUpdate() => update();
}
