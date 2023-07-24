import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class WeatherRepository {
  WeatherRepository({
    required ApiCaller apiCaller,
  }) : _apiCaller = apiCaller;

  final ApiCaller _apiCaller;

  Future<WeatherResponseModel> fetchWeatherData({
    required double lat,
    required double long,
  }) async {
    try {
      final data = await _apiCaller.getWeatherData(long: long, lat: lat);

      if (data.isEmpty) {
        throw NetworkException();
      }

      final weatherModel = WeatherResponseModel.fromResponse(
        response: data,
      );

      return weatherModel;
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
  }

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository');
  }
}
