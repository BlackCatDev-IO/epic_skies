import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  CurrentWeatherController({
    required this.storage,
    required this.weatherRepository,
  });

  static CurrentWeatherController get to => Get.find();

  final StorageController storage;

  final WeatherRepository weatherRepository;

  late String currentTimeString;

  late DateTime currentTime;

  late CurrentWeatherModel data;

  Future<void> initCurrentWeatherValues() async {
    final weatherModel = weatherRepository.weatherModel;

    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;

    data = CurrentWeatherModel.fromWeatherData(data: weatherData);

    if (weatherRepository.searchIsLocal) {
      storage.storeCurrentLocalTemp(temp: data.temp);
      storage.storeCurrentLocalCondition(condition: data.condition);
    }

    initCurrentTime();

    log('current time: $currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(
      time: currentTime,
      timeIn24Hrs: data.unitSettings.timeIn24Hrs,
    );

    if (BgImageController.to.bgImageDynamic) {
      BgImageController.to.updateBgImageOnRefresh(condition: data.condition);
    }

    update();
  }

  void initCurrentTime() {
    final weatherModel = weatherRepository.weatherModel;
    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;
    currentTime = weatherData.startTime;
  }
}
