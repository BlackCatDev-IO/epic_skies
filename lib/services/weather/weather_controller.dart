import 'dart:convert';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get_storage/get_storage.dart';

import '../../local_constants.dart';
import '../utils/location_controller.dart';
import 'forecast_controller.dart';

class WeatherController extends GetxController {
  static const openWeatherApiKey = '035e88c5b14e6e5527f34ec2f25d64ae';
  static const baseOneCallURL =
      'https://api.openweathermap.org/data/2.5/onecall';

  final box = GetStorage();

  RxBool isDay = true.obs;
  RxString data = ''.obs;
  RxInt today = 0.obs;
  RxInt now = 0.obs;
  // ignore: type_annotate_public_apis
  var dataMap = {}.obs;
  Map<String, String> map2 = {};

  String weatherIconCode,
      main,
      currentCondition,
      currentTemp,
      feelsLike,
      sunsetTime,
      sunriseTime;

  final networkController = NetworkController();


  Future<void> getAllWeatherData() async {
    debugPrint('getAllWeatherData called');
    today.value = DateTime.now().weekday;
    now.value = DateTime.now().hour;
    final locationController = Get.find<LocationController>();

    await locationController.getLocationAndAddress();
    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;
    final String openWeatherOneCallURL =
        '$baseOneCallURL?lat=$lat&lon=$long&units=imperial&exclude=%7Bpart%7D&appid=$openWeatherApiKey';

    data.value = await networkController.getData(openWeatherOneCallURL);
    final map = await compute(parseData, data.value);

    dataMap = map.obs;
    initCurrentWeatherValues();

    box.write(dataMapKey, map);

    // getDayOrNight();

    update();

    await Get.find<ForecastController>().buildForecastWidgets();
  }

  void initCurrentWeatherValues() {
    final condition = dataMap[currentConditionKey].toString();
    currentCondition = condition.capitalizeFirst;
    debugPrint(('Current Condition: $currentCondition'));
    currentTemp = dataMap[currentTempKey].toString();
    main = dataMap[mainKey].toString();
    feelsLike = dataMap[feelsLikeKey].toString();

    update();
  }

  // void getDayOrNight() {
  //   debugPrint('getDayOrNight isDay value at beginning of function: $isDay');
  //   final sunsetTime = jsonDecode(data.value)['current']['sunset'];

  //   final sunriseTime = jsonDecode(data.value)['current']['sunrise'];

  //   debugPrint('sunsetTime: $sunsetTime -- sunriseTime: $sunriseTime');

  //   final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTime as int);
  //   final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTime as int);
  //   final now = DateTime.now();

  //   isDay.value = now.isBefore(sunset) && sunrise.isBefore(now);
  //   debugPrint('getDayOrNight isDay value at end of function: $isDay');
  // }
}
