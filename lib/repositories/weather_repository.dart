import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_service.dart';
import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/core/network/weather_kit/weather_kit_client.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';

class WeatherRepository {
  WeatherRepository({
    required ApiService service,
    required WeatherKitClient weatherKitClient,
    EpicSkiesApiClient? epicSkiesApiClient,
  })  : _apiService = service,
        _weatherKitClient = weatherKitClient,
        _epicSkiesApiClient = epicSkiesApiClient ?? getIt<EpicSkiesApiClient>();

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
    required Locale locale,
  }) async {
    try {
      return await _weatherKitClient.getAllWeatherData(
        coordinates: coordinates,
        timezone: timezone,
        locale: locale,
      );
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      rethrow;
    }
  }

  Future<(LocationState, Weather)> mockResponse(String key) async {
    try {
      final response = await _epicSkiesApiClient.mockResponse(key: key);

      final weatherMap = response['weather_kit'] as Map<String, dynamic>;
      final location = response['location'] as Map<String, dynamic>;

      final weather = Weather.fromMap(weatherMap);
      final locationState = LocationState.fromMap(location);

      return (locationState, weather);
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      throw EpicSkiesApiException(error.toString());
    }
  }

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository', isError: true);
  }
}
