import 'dart:io';

import 'package:dio/dio.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';

class UmamiService {
  UmamiService({required SystemInfoRepository systemInfo})
      : _systemInfo = systemInfo {
    _dio = Dio(
      BaseOptions(
        headers: {
          'User-Agent': _getUserAgent(),
        },
      ),
    );
  }

  late final Dio _dio;

  final SystemInfoRepository _systemInfo;

  Future<void> trackEvent({
    required String eventName,
    bool isPageView = false,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      await _dio.post<dynamic>(
        Env.analyticsBaseUrl,
        data: _payload(
          eventName: eventName,
          isPageView: isPageView,
          data: data,
        ),
      );
      AppDebug.log('$eventName $data', name: 'Umami');
    } catch (e) {
      _logUmamiError(e);
    }
  }

  void trackRoute({
    required String route,
  }) {
    try {
      _dio.post<dynamic>(
        Env.analyticsBaseUrl,
        data: _payload(
          eventName: route,
          isPageView: true,
        ),
      );
      AppDebug.log(route, name: 'Umami');
    } catch (e) {
      _logUmamiError(e);
    }
  }

  Map<String, dynamic> _payload({
    required String eventName,
    required bool isPageView,
    Map<String, dynamic> data = const {},
  }) {
    final url = isPageView ? eventName : '/users/actions';

    final eventData = {...data}..addAll({
        'deviceID': _systemInfo.deviceId,
        'appVersion': _systemInfo.currentAppVersion,
      });

    return {
      'payload': {
        'hostname': 'app.epicskies.io',
        'language': 'en-US',
        'title': eventName,
        'url': url,
        'website': 'c0243e4f-5458-47ec-a4ac-03f319dce02e',
        if (!isPageView) 'name': eventName,
        'data': eventData,
      },
      'type': 'event',
    };
  }

  String _getUserAgent() {
    final appVersion = _systemInfo.currentAppVersion;
    final platform = Platform.isAndroid ? 'Android' : 'iOS';
    final model = Platform.isAndroid
        ? _systemInfo.androidModel
        : _systemInfo.iOsModelCode;

    return 'Epic Skies/$appVersion ($platform ${_systemInfo.systemVersion}; $model) Mobile/15E148';
  }

  void _logUmamiError(dynamic error) {
    AppDebug.logSentryError(
      error is DioException ? error.error ?? error.response : error,
      name: 'UmamiService',
    );
  }
}
