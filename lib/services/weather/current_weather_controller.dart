import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/utils/weather_code_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  final storageController = Get.find<StorageController>();
  final imageController = Get.find<ImageController>();
  final weatherRepository = Get.find<WeatherRepository>();
  final converter = const WeatherCodeConverter();

  int sunsetTime = 0;
  int sunriseTime = 0;

  String temp = '';
  String feelsLike = '';
  String condition = '';
  Future<void> initCurrentWeatherValues() async {
    final valuesMap =
        storageController.dataMap['timelines'][1]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round().toString();

    final weatherCode = valuesMap['weatherCode'];

    condition = converter.getConditionFromWeatherCode(weatherCode);

    debugPrint(
        'ClimaCell weather code: $weatherCode current condition: $condition');

    feelsLike = valuesMap['temperatureApparent'].round().toString();

    debugPrint('ClimaCell feels like $feelsLike');
    await imageController.updateBackgroundImage(condition);
    weatherRepository.getDayOrNight();

    update();
  }

  void remoteUpdate() => update();
}
