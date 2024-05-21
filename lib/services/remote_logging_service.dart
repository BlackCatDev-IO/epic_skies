import 'package:dio/dio.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class RemoteLoggingService {
  RemoteLoggingService({EpicSkiesApiClient? apiClient})
      : _apiClient = apiClient ?? getIt<EpicSkiesApiClient>();

  final EpicSkiesApiClient _apiClient;

  Future<void> log(
    String message, {
    Map<String, dynamic>? data,
  }) async {
    try {
      await _apiClient.recordLog(message, data: data);
      AppDebug.log('Remote logged message: $message data: $data');
    } catch (e) {
      AppDebug.logSentryError(
        e is DioException ? e.error ?? e.response : e,
        name: 'RemoteLoggingService',
      );
    }
  }

  Future<void> recordWeatherAlert({
    required Weather weather,
    required AlertModel alert,
  }) async {
    try {
      await _apiClient.recordWeatherAlert(
        alert: alert,
        weather: weather,
      );
    } catch (error, stack) {
      AppDebug.log('$error, $stack', isError: true);
      throw EpicSkiesApiException(error.toString());
    }
  }
}
