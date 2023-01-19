import 'dart:async';

import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../utils/formatters/date_time_formatter.dart';
import '../../../utils/timezone/timezone_util.dart';
import '../../main_weather/bloc/weather_bloc.dart';
import '../models/current_weather_model.dart';
import 'current_weather_state.dart';

export 'current_weather_state.dart';

class CurrentWeatherCubit extends HydratedCubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherState.initial());

  String _currentTimeString = '';

  late DateTime _currentTime;

  Timer? _remoteTimeTracker;

  Future<void> refreshCurrentWeatherData({
    required WeatherState weatherState,
  }) async {
    final weatherModel = weatherState.weatherModel;

    _resetRemoteTimer();

    final data = CurrentWeatherModel.fromWeatherData(
      data: weatherModel!.currentCondition,
      unitSettings: weatherState.unitSettings,
    );

    _currentTime = TimeZoneUtil.getCurrentLocalOrRemoteTime(
      searchIsLocal: weatherState.searchIsLocal,
    );

    if (!weatherState.searchIsLocal) {
      _initRemoteTimeTracker(data.unitSettings.timeIn24Hrs);
    }

    _logWeatherCubit('current time: $_currentTime');

    _currentTimeString = DateTimeFormatter.formatFullTime(
      time: _currentTime,
      timeIn24Hrs: data.unitSettings.timeIn24Hrs,
    );

    emit(state.copyWith(data: data, currentTimeString: _currentTimeString));
  }

  void _initRemoteTimeTracker(bool timeIn24Hrs) {
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

      _currentTimeString = DateTimeFormatter.formatFullTime(
        time: _currentTime,
        timeIn24Hrs: timeIn24Hrs,
      );
      _logWeatherCubit(
        'currentTime: $_currentTime timer: ${_remoteTimeTracker.hashCode}',
      );

      emit(state.copyWith(currentTimeString: _currentTimeString));
    });
  }

  void _resetRemoteTimer() {
    if (_remoteTimeTracker != null) {
      _remoteTimeTracker!.cancel();
      _remoteTimeTracker = null;
    }
  }

  void _logWeatherCubit(String message) {
    AppDebug.log(message, name: 'CurrentWeatherCubit');
  }

  @override
  Future<void> close() {
    _resetRemoteTimer();
    _logWeatherCubit('CurrentWeatherCubit closed hash: $hashCode');
    return super.close();
  }

  @override
  CurrentWeatherState? fromJson(Map<String, dynamic> json) {
    return CurrentWeatherState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CurrentWeatherState state) {
    return state.toJson();
  }
}
