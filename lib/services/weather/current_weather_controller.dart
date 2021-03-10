import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  final storageController = Get.find<StorageController>();
  final imageController = Get.find<BgImageController>();
  final weatherRepository = Get.find<WeatherRepository>();
  final weatherCodeConverter = const WeatherCodeConverter();
  final unitConverter = const UnitConverter();

  int sunsetTime = 0;
  int sunriseTime = 0;

  String temp = '';
  String feelsLike = '';
  String condition = '';

  Future<void> initCurrentWeatherValues() async {
    final valuesMap =
        storageController.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round().toString();

    final weatherCode = valuesMap['weatherCode'];

    condition = weatherCodeConverter.getConditionFromWeatherCode(weatherCode);

    debugPrint(
        'ClimaCell weather code: $weatherCode current condition: $condition');

    feelsLike = valuesMap['temperatureApparent'].round().toString();

    debugPrint('ClimaCell feels like $feelsLike');
    await imageController.updateBgImageOnRefresh(condition);
    weatherRepository.getDayOrNight();

    update();
  }
}
