import 'package:dio/dio.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';

class EpicSkiesApiClient {
  EpicSkiesApiClient({
    required this.appVersion,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {'Authorization': 'Bearer ${Env.epicSkiesApiToken}'};
  }

  final Dio _dio;
  final String appVersion;

  static const String _baseUrl = 'https://api.epicskies.io';

  Future<void> recordWeatherAlert({
    required AlertModel alert,
    required Weather weather,
  }) async {
    try {
      await _dio.post<dynamic>(
        '/app-alert-notice',
        data: {
          'precip_notice': alert.precipNotice.precipNoticeMessage,
          'alert': alert.weatherAlert.weatherAlertMessage,
          'weather_kit_response': weather.toMap(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> recordLog(
    String log, {
    Map<String, dynamic>? data,
  }) async {
    try {
      await _dio.post<dynamic>(
        '/logs',
        data: {
          'log': log,
          'appVersion': appVersion,
          'data': data,
        },
      );
    } catch (e) {
      dynamic error = e;
      if (e is DioException) {
        error = e.error ?? e.response;
      }

      throw Exception(error);
    }
  }

  /// Mock WeatherKit responses are stored on the Epic Skies server, and can be
  /// retrieved by providing a key
  Future<Map<String, dynamic>> mockResponse({
    required String key,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/mocks?key=$key',
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
}
