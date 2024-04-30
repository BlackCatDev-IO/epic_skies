import 'package:dio/dio.dart';
import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class LoggingService {
  LoggingService({EpicSkiesApiClient? apiClient})
      : _apiClient = apiClient ?? getIt<EpicSkiesApiClient>();

  final EpicSkiesApiClient _apiClient;

  Future<void> log(
    String message, {
    Map<String, dynamic>? data,
  }) async {
    try {
      await _apiClient.recordLog(message, data: data);
    } catch (e) {
      AppDebug.logSentryError(
        e is DioException ? e.error ?? e.response : e,
        name: 'LoggingService',
      );
    }
  }
}
