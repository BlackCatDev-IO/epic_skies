import 'dart:async';
import 'dart:developer';

import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:get/get.dart';

import '../../../services/settings/bg_image_settings/image_settings.dart';
import '../../../utils/timezone/timezone_util.dart';
import '../../main_weather/bloc/weather_bloc.dart';

class CurrentWeatherController extends GetxController {
  CurrentWeatherController();

  static CurrentWeatherController get to => Get.find();

  late String currentTimeString;

  late DateTime _currentTime;

  late CurrentWeatherModel data;

  Timer? _remoteTimeTracker;

  @override
  void onClose() {
    _resetRemoteTimer();
  }

  Future<void> refreshCurrentWeatherData({
    required bool isRefresh,
    required WeatherState weatherState,
  }) async {
    final weatherModel = weatherState.weatherModel;

    _resetRemoteTimer();

    final weatherData = weatherModel!.currentCondition;
    data = CurrentWeatherModel.fromWeatherData(
      data: weatherData!,
      unitSettings: weatherState.unitSettings,
    );

    _currentTime = TimeZoneUtil.getCurrentLocalOrRemoteTime(
      searchIsLocal: weatherState.searchIsLocal,
    );

    if (!weatherState.searchIsLocal) {
      _initRemoteTimeTracker();
    }

    log('current time: $_currentTime');

    currentTimeString = DateTimeFormatter.formatFullTime(
      time: _currentTime,
      timeIn24Hrs: data.unitSettings.timeIn24Hrs,
    );

    if (BgImageController.to.settings == ImageSettings.dynamic && isRefresh) {
      BgImageController.to.updateBgImageOnRefresh(
        condition: data.condition,
        currentTime: _currentTime,
      );
    }

    update();
  }

  void _initRemoteTimeTracker() {
    const oneSecond = Duration(seconds: 1);

    _currentTime = DateTime(
      _currentTime.year,
      _currentTime.month,
      _currentTime.day,
      _currentTime.hour,
      _currentTime.minute,
      DateTime.now().second,
    );

    _remoteTimeTracker = Timer.periodic(oneSecond, (_) {
      _currentTime = _currentTime.add(oneSecond);

      currentTimeString = DateTimeFormatter.formatFullTime(
        time: _currentTime,
        timeIn24Hrs: data.unitSettings.timeIn24Hrs,
      );
      log(
        'currentTime: $_currentTime timer: ${_remoteTimeTracker.hashCode}',
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
