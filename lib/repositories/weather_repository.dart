import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_service.dart';
import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/core/network/weather_kit/weather_kit_client.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class WeatherRepository {
  WeatherRepository({
    required ApiService service,
    required WeatherKitClient weatherKitClient,
    EpicSkiesApiClient? epicSkiesApiClient,
  })  : _apiService = service,
        _weatherKitClient = weatherKitClient,
        _epicSkiesApiClient = epicSkiesApiClient ?? EpicSkiesApiClient();

  final ApiService _apiService;
  final WeatherKitClient _weatherKitClient;
  final EpicSkiesApiClient _epicSkiesApiClient;

  Future<WeatherResponseModel> getVisualCrossingData({
    required Coordinates coordinates,
  }) async {
    try {
      final data = await _apiService.getWeatherData(coordinates: coordinates);

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
        // mockDataPath: mockSantaAnaRain, // Used to load mock json data
      );
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
  }

  Future<void> recordWeatherAlert({
    required Weather weather,
    required AlertModel alert,
  }) async {
    try {
      await _epicSkiesApiClient.recordWeatherAlert(
        alert: alert,
        weather: weather,
      );
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      throw EpicSkiesApiException(error.toString());
    }
  }

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository', isError: true);
  }
}
