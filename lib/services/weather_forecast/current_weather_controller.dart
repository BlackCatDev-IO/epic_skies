import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/widget_models/current_weather_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  static CurrentWeatherController get to => Get.find();

  late String tempUnitString,
      precipUnitString,
      speedUnitString,
      currentTimeString;

  late DateTime currentTime;

  late CurrentWeatherModel data;

  @override
  void onInit() {
    super.onInit();
    initSettingsStrings();
  }

  Future<void> initCurrentWeatherValues() async {
    initSettingsStrings();

    final weatherModel = WeatherRepository.to.weatherModel;

    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;

    data = CurrentWeatherModel.fromWeatherData(data: weatherData);

    initCurrentTime();

    log('current time: $currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(time: currentTime);

    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition: data.condition);
    }

    update();
  }

  void initCurrentTime() {
    final weatherModel = WeatherRepository.to.weatherModel;
    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;
    currentTime = weatherData.startTime;
  }

  void initSettingsStrings() {
    tempUnitString = StorageController.to.tempUnitString();
    precipUnitString = StorageController.to.precipUnitString();
    speedUnitString = StorageController.to.speedUnitString();
  }
}
