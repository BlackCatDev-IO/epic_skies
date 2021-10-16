import 'dart:developer';

import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:epic_skies/services/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  static CurrentWeatherController get to => Get.find();

  late String tempUnitString,
      precipUnitString,
      speedUnitString,
      currentTimeString;

  late DateTime currentTime;
  int temp = 0;
  int? feelsLike = 0;
  bool falseSnow = false;
  String condition = '';
  num windSpeed = 0;
  Map _settingsMap = {};

  @override
  void onInit() {
    super.onInit();
    initSettingsStrings();
  }

  Future<void> initCurrentWeatherValues() async {
    initSettingsStrings();
    _settingsMap = StorageController.to.settingsMap;

    final valuesMap =
        StorageController.to.dataMap['timelines'][2]['intervals'][0]['values'];
    temp = valuesMap['temperature'].round() as int;

    final weatherCode = valuesMap['weatherCode'];

    windSpeed = UnitConverter.convertFeetPerSecondToMph(
            feetPerSecond: valuesMap['windSpeed'] as num)
        .round();

    condition =
        WeatherCodeConverter.getConditionFromWeatherCode(weatherCode as int?);

    feelsLike = valuesMap['temperatureApparent'].round() as int?;

    initCurrentTime();

    log('current time: $currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(time: currentTime);

    _handlePotentialConversions();
    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition: condition);
    }
    if (_isSnowyCondition()) {
      _checkForFalseSnow();
    }

    update();
  }

  void initCurrentTime() {
    currentTime = TimeZoneController.to.parseTimeBasedOnLocalOrRemoteSearch(
        time: StorageController.to.dataMap['timelines'][2]['intervals'][0]
            ['startTime'] as String);
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
      temp = UnitConverter.toCelcius(temp);
      feelsLike = UnitConverter.toCelcius(feelsLike!);
    }
    if (_settingsMap[speedInKphKey]! as bool) {
      windSpeed = UnitConverter.convertMilesToKph(miles: windSpeed);
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
