import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  static CurrentWeatherController get to => Get.find();

  final weatherCodeConverter = const WeatherCodeConverter();
  final _conversionController = const UnitConverter();

  late String tempUnitString, precipUnitString, speedUnitString;

  int sunsetTime = 0;
  int sunriseTime = 0;

  int temp = 0;
  int? feelsLike = 0;

  bool falseSnow = false;

  String condition = '';

  num windSpeed = 0;

  Map _settingsMap = {};

  Future<void> initCurrentWeatherValues() async {
    initSettingsStrings();
    _settingsMap = StorageController.to.settingsMap;

    final valuesMap =
        StorageController.to.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round() as int;

    final weatherCode = valuesMap['weatherCode'];

    windSpeed = _conversionController
        .convertFeetPerSecondToMph(valuesMap['windSpeed'] as num)
        .round();

    condition =
        weatherCodeConverter.getConditionFromWeatherCode(weatherCode as int?);

    feelsLike = valuesMap['temperatureApparent'].round() as int?;

    _handlePotentialConversions();
    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition);
    }
    if (_isSnowyCondition()) {
      _checkForFalseSnow();
    }

    update();
  }

// sometimes weather code returns snow or flurries when its above freezing
// this prevents a snow image background & snow icons when its not actually snowing
  void _checkForFalseSnow() {
    final tempUnitsMetric = _settingsMap[tempUnitsMetricKey] as bool;

    if (tempUnitsMetric) {
      if (temp > 0) {
        falseSnow = true;
        condition = 'Cloudy';
        update();
        return;
      }
    } else {
      if (temp > 32) {
        falseSnow = true;
        condition = 'Cloudy';
        update();
        return;
      }
    }
    falseSnow = false;
  }

  void _handlePotentialConversions() {
    if (_settingsMap[tempUnitsMetricKey]! as bool) {
      temp = _conversionController.toCelcius(temp);
      feelsLike = _conversionController.toCelcius(feelsLike!);
    }
    if (_settingsMap[speedInKphKey]! as bool) {
      windSpeed = _conversionController.convertMilesToKph(windSpeed);
    }
  }

  bool _isSnowyCondition() {
    switch (condition) {
      case 'snow':
      case 'flurries':
      case 'light snow':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
        return true;
      default:
        return false;
    }
  }

  void initSettingsStrings() {
    tempUnitString = StorageController.to.tempUnitString();
    precipUnitString = StorageController.to.precipUnitString();
    speedUnitString = StorageController.to.speedUnitString();
  }
}
