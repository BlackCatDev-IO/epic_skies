import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/error_handling/custom_exceptions.dart';

class WeatherRepository {
  WeatherRepository({
    required StorageController storage,
    required ApiCaller apiCaller,
  })  : _storage = storage,
        _apiCaller = apiCaller;

  final StorageController _storage;

  final ApiCaller _apiCaller;

  Future<WeatherResponseModel?> fetchWeatherData({
    required double lat,
    required double long,
  }) async {
    try {
      if (!await InternetConnectionChecker().hasConnection) {
        throw NoConnectionException();
      }

      final data = await _apiCaller.getWeatherData(long: long, lat: lat);

      TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

      if (data != null && data.isNotEmpty) {
        final weatherModel = WeatherResponseModel.fromResponse(
          response: data as Map<String, dynamic>,
        );

        return weatherModel;
      }
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
    return null;
  }

  bool restoreSavedIsDay() => _storage.restoreDayOrNight();

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository');
  }

  void storeWeatherState(WeatherState state) {
    _storage.storeWeatherState(state);
  }
}
