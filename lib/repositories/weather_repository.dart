import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/core/network/weather_kit/weather_kit_client.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class WeatherRepository {
  WeatherRepository({
    required ApiCaller apiCaller,
    required WeatherKitClient weatherKitClient,
  })  : _apiCaller = apiCaller,
        _weatherKitClient = weatherKitClient;

  final ApiCaller _apiCaller;
  final WeatherKitClient _weatherKitClient;

  Future<WeatherResponseModel> getVisualCrossingData({
    required Coordinates coordinates,
  }) async {
    try {
      final data = await _apiCaller.getWeatherData(coordinates: coordinates);

      if (data.isEmpty) {
        throw NetworkException();
      }

      final weatherModel = WeatherResponseModel.fromResponse(response: data);

      return weatherModel;
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
  }

  Future<Weather> getWeatherKitData({
    required Coordinates coordinates,
    required String timezone,
    String? countryCode,
    String? languageCode,
  }) async {
    try {
      return await _weatherKitClient.getAllWeatherData(
        coordinates: coordinates,
        timezone: timezone,
        countryCode: countryCode,
        language: languageCode,
        // mockData: true, // Used to load mock json data
      );
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
  }

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository');
  }
}
