import 'dart:async';
import 'dart:developer';

import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';

import '../../../services/settings/bg_image_settings/image_settings.dart';
import '../../main_weather/bloc/weather_bloc.dart';

class CurrentWeatherController extends GetxController {
  CurrentWeatherController();

  static CurrentWeatherController get to => Get.find();

  late String currentTimeString;

  late DateTime currentTime;

  late CurrentWeatherModel data;

  Timer? _remoteTimeTracker;

  @override
  void onClose() {
    _resetRemoteTimer();
  }

  Future<void> updateCurrentWeatherData({
    required bool isRefresh,
    required WeatherState weatherState,
  }) async {
    final weatherModel = weatherState.weatherModel;

    _resetRemoteTimer();

    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;

    data = CurrentWeatherModel.fromWeatherData(
      data: weatherData,
      unitSettings: weatherState.unitSettings,
    );

    initCurrentTime(weatherState);

    if (!weatherState.searchIsLocal) {
      _initRemoteTimeTracker();
    }

    log('current time: $currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(
      time: currentTime,
      timeIn24Hrs: data.unitSettings.timeIn24Hrs,
    );

    if (BgImageController.to.settings == ImageSettings.dynamic && isRefresh) {
      BgImageController.to.updateBgImageOnRefresh(
        condition: data.condition,
        currentTime: currentTime,
      );
    }

    update();
  }

  void initCurrentTime(WeatherState state) {
    final weatherModel = state.weatherModel;
    final weatherData =
        weatherModel!.timelines[Timelines.current].intervals[0].data;
    currentTime = weatherData.startTime;
  }

  void _initRemoteTimeTracker() {
    const oneSecond = Duration(seconds: 1);

    currentTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      currentTime.minute,
      DateTime.now().second,
    );

    _remoteTimeTracker = Timer.periodic(oneSecond, (_) {
      currentTime = currentTime.add(oneSecond);

      currentTimeString = DateTimeFormatter.formatFullTime(
        time: currentTime,
        timeIn24Hrs: data.unitSettings.timeIn24Hrs,
      );
      log(
        'currentTime: $currentTime timer: ${_remoteTimeTracker.hashCode}',
      );
      update(['remote_time']);
    });
  }

  void _resetRemoteTimer() {
    if (_remoteTimeTracker != null) {
      _remoteTimeTracker!.cancel();
      _remoteTimeTracker = null;
    }
  }
}
