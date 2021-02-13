import 'package:epic_skies/old_models/weather_model.dart';
import 'package:epic_skies/screens/home_tab_view.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/network.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import '../utils/location_controller.dart';

class WeatherRepository extends GetxController {
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
    debugPrint('getNewWeatherData called');
    isLoading(true);

    await locationController.getLocationAndAddress();

    final long = locationController.position.longitude;
    final lat = locationController.position.latitude;
    final api = Api();
    now = DateTime.now().hour;

    final url = api.getClimaCellUrl(long: long, lat: lat);
    final data = await api.getWeatherData(url);

    storageController.storeWeatherData2(map: data);
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

  Future<void> initCurrentWeatherValues2() async {
    final dataMap = storageController.dataMap2;
    currentTemp = dataMap['timelines'][0]['intervals'][0]['values']
            ['temperature']
        .round()
        .toString();

    final weatherCode =
        dataMap['timelines'][0]['intervals'][0]['values']['weatherCode'];

    currentCondition = getConditionFromWeatherCode(weatherCode);

    debugPrint(
        'ClimaCell weather code: $weatherCode current condition: $currentCondition');

    feelsLike = dataMap['timelines'][0]['intervals'][0]['values']
            ['temperatureApparent']
        .round()
        .toString();

    debugPrint('ClimaCell feels like $feelsLike');
    // await Get.find<ImageController>()
    //     .updateBackgroundImage(main, currentCondition);
    getDayOrNight();

    update();
  }

  Future<void> initCurrentWeatherValues() async {
    final currentMap = storageController.dataMap['current'];
    currentTemp = currentMap['temp'].round().toString();
    main = currentMap['weather'][0]['main'].toString();
    currentCondition =
        currentMap['weather'][0]['description'].toString().capitalizeFirst;

    debugPrint(('Current Condition: $currentCondition'));

    feelsLike = currentMap[feelsLikeKey].round().toString();
    await Get.find<ImageController>().updateBackgroundImage(currentCondition);

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

  String getConditionFromWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Unknown';
        break;
      case 1000:
        return 'Clear';
        break;
      case 1001:
        return 'Cloudy';
        break;
      case 1100:
        return 'Mostly Clear';
        break;
      case 1101:
        return 'Partly Cloudy';
        break;
      case 1102:
        return 'Mostly Cloudy';
        break;
      case 2000:
        return 'Fog';
        break;
      case 2100:
        return 'Light Fog';
        break;
      case 3000:
        return 'Light Wind';
        break;
      case 3001:
        return 'Wind';
        break;
      case 3001:
        return 'Wind';
        break;
      case 3002:
        return 'Strong Wind';
        break;
      case 4000:
        return 'Drizzle';
        break;
      case 4001:
        return 'Rain';
        break;
      case 4200:
        return 'Light Rain';
        break;
      case 4201:
        return 'Heavy Rain';
        break;
      case 5000:
        return 'Snow';
        break;
      case 5001:
        return 'Flurries';
        break;
      case 5100:
        return 'Light Snow';
        break;
      case 5101:
        return 'Heavy Snow';
        break;
      case 6000:
        return ' Freezing Drizzle';
        break;
      case 6001:
        return 'Freezing Rain';
        break;
      case 6200:
        return 'Light Freezing Rain';
        break;
      case 6201:
        return 'Heavy Freezing Rain';
        break;
      case 7000:
        return 'Ice Pellets';
        break;
      case 7101:
        return 'Heavy Ice Pellets';
        break;
      case 7102:
        return 'Light Ice Pellets';
        break;
      case 8000:
        return 'Thunderstorm';
        break;

      default:
        return '';
    }
  }
}
