import 'dart:async';

import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_state.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'current_weather_state.dart';

class CurrentWeatherCubit extends HydratedCubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherState.initial());

  String _currentTimeString = '';

  late DateTime _currentTime;

  Timer? _remoteTimeTracker;

  Future<void> refreshCurrentWeatherData({
    required WeatherState weatherState,
  }) async {
    final weather = weatherState.weather;

    _resetRemoteTimer();

    final currentWeatherModel = weatherState.useBackupApi
        ? CurrentWeatherModel.fromBackupApi(
            unitSettings: weatherState.unitSettings,
            data: weatherState.weatherModel!.currentCondition,
          )
        : CurrentWeatherModel.fromWeatherKit(
            unitSettings: weatherState.unitSettings,
            data: weather!.currentWeather,
          );

    _currentTime = GetIt.I<TimeZoneUtil>().getCurrentLocalOrRemoteTime(
      searchIsLocal: weatherState.searchIsLocal,
    );

    if (!weatherState.searchIsLocal) {
      _initRemoteTimeTracker(currentWeatherModel.unitSettings.timeIn24Hrs);
    }

    _logWeatherCubit('current time: $_currentTime');

    _currentTimeString = DateTimeFormatter.formatFullTime(
      time: _currentTime,
      timeIn24Hrs: currentWeatherModel.unitSettings.timeIn24Hrs,
    );

    emit(
      state.copyWith(
        data: currentWeatherModel,
        currentTimeString: _currentTimeString,
      ),
    );
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

      emit(state.copyWith(currentTimeString: _currentTimeString));
    });
  }

  void _resetRemoteTimer() {
    _remoteTimeTracker?.cancel();
    _remoteTimeTracker = null;
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
    return CurrentWeatherState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CurrentWeatherState state) {
    return state.toMap();
  }
}
