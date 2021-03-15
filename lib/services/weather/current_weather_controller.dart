import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  final storageController = Get.find<StorageController>();
  final imageController = Get.find<BgImageController>();
  final weatherRepository = Get.find<WeatherRepository>();
  final weatherCodeConverter = const WeatherCodeConverter();

  int sunsetTime = 0;
  int sunriseTime = 0;

  int temp = 0;
  int feelsLike = 0;

  String condition = '';

  Future<void> initCurrentWeatherValues() async {
    final valuesMap =
        storageController.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round();

    final weatherCode = valuesMap['weatherCode'];

    condition = weatherCodeConverter.getConditionFromWeatherCode(weatherCode);

    feelsLike = valuesMap['temperatureApparent'].round();
    await imageController.updateBgImageOnRefresh(condition);

    update();
  }
}
