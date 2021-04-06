import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/conversion_controller.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  final weatherCodeConverter = const WeatherCodeConverter();
  final conversionController = ConversionController();

  static CurrentWeatherController get to => Get.find();

  int sunsetTime = 0;
  int sunriseTime = 0;

  int temp = 0;
  int feelsLike = 0;

  String condition = '';

  Future<void> initCurrentWeatherValues() async {
    final valuesMap =
        StorageController.to.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round() as int;

    final weatherCode = valuesMap['weatherCode'];

    condition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int);

    feelsLike = valuesMap['temperatureApparent'].round() as int;

    if (SettingsController.to.tempUnitsMetric) {
      conversionController.convertCurrentTempValues();
    }

    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition);
    }

    update();
  }
}
