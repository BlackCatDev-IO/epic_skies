import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/home_tab_controller.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/utils/network.dart';
import 'package:epic_skies/services/utils/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../local_constants.dart';
import '../utils/location_controller.dart';
import 'forecast_controller.dart';

class WeatherController extends GetxController {
  final box = GetStorage(dataMapKey);
  final localDataBox = GetStorage(jsonMapKey);

  RxBool isDay = true.obs;
  RxBool getDataCallCompleted = false.obs;
  RxBool isLoading = false.obs;
  RxBool displaySearchResults = false.obs;
  RxInt today = 0.obs;
  int now = 0;
  // ignore: type_annotate_public_apis
  var dataMap = {}.obs;

  Map<String, dynamic> newMap;

  String main, currentCondition, currentTemp, feelsLike;

  int sunsetTime, sunriseTime;

  Future<void> getAllWeatherData() async {
    debugPrint('getAllWeatherData called');
    final networkController = NetworkController();

    today.value = DateTime.now().weekday;
    now = DateTime.now().hour;
    final locationController = Get.find<LocationController>();

    await locationController.getLocationAndAddress();
    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;

    final data = await networkController.getData(
        networkController.getOneCallCurrentLocationUrl(long: long, lat: lat));

    final weatherObject = await compute(weatherFromJson, data);

    dataMap.assignAll(weatherObject.toJson());
    Get.find<StorageController>().storeDataBox();
    getDayOrNight();

    initCurrentWeatherValues();

    await Get.find<ForecastController>().buildForecastWidgets();

    final RxBool firstTime = Get.find<MasterController>().firstTimeUse;

    if (firstTime.value) {
      Get.to(HomeTabController());
      firstTime.value = false;
    }
    isLoading(false);

    update();
  }

  Future<void> initCurrentWeatherValues() async {
    final currentMap = dataMap['current'];
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
    final currentMap = dataMap['current'];
    sunsetTime = currentMap['sunset'];

    sunriseTime = currentMap['sunrise'];

    final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTime * 1000);
    final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTime * 1000);
    final now = DateTime.now();

    isDay.value = now.isBefore(sunset) && sunrise.isBefore(now);
    debugPrint('getDayOrNight isDay value at end of function: $isDay');
  }

  void remoteUpdate() => update();
}
