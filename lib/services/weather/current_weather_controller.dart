import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  static CurrentWeatherController get to => Get.find();

  final weatherCodeConverter = const WeatherCodeConverter();
  final _conversionController = const UnitConverter();

  int sunsetTime = 0;
  int sunriseTime = 0;

  int temp = 0;
  int? feelsLike = 0;

  String condition = '';

  num windSpeed = 0;

  Future<void> initCurrentWeatherValues() async {
    final valuesMap =
        StorageController.to.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round() as int;

    final weatherCode = valuesMap['weatherCode'];

    windSpeed = _conversionController
        .convertFeetPerSecondToMph(valuesMap['windSpeed'] as num);

    condition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int?);

    feelsLike = valuesMap['temperatureApparent'].round() as int?;

    _handlePotentialConversions();
    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition);
    }

    update();
  }

  void _handlePotentialConversions() {
    if (SettingsController.to.tempUnitsMetric) {
      temp = _conversionController.toCelcius(temp);
      feelsLike = _conversionController.toCelcius(feelsLike!);
    }
    if (SettingsController.to.speedInKm) {
      windSpeed = _conversionController.convertMilesToKph(windSpeed);
    }
  }
}
