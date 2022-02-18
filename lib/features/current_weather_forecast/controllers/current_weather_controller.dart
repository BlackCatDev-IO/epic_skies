import 'dart:developer';

import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';

import '../../../services/settings/bg_image_settings/image_settings.dart';

class CurrentWeatherController extends GetxController {
  CurrentWeatherController({
    required this.weatherRepository,
  });

  static CurrentWeatherController get to => Get.find();

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
      weatherRepository.storage.storeCurrentLocalTemp(temp: data.temp);
      weatherRepository.storage
          .storeCurrentLocalCondition(condition: data.condition);
    }

    initCurrentTime();

    log('current time: $currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(
      time: currentTime,
      timeIn24Hrs: data.unitSettings.timeIn24Hrs,
    );

    if (BgImageController.to.settings == ImageSettings.dynamic) {
      BgImageController.to.updateBgImageOnRefresh(
        condition: data.condition,
        currentTime: currentTime,
      );
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
