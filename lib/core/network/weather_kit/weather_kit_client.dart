import 'dart:async';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/weather_kit/models/data_set/data_set.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';

const _baseUrl = 'https://weatherkit.apple.com/api/v1/';

class WeatherKitClient {
  WeatherKitClient({
    required this.serviceId,
    required this.teamId,
    required this.keyId,
    required this.p8,
    this.tokenDuration = const Duration(hours: 1),
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _token = _getJwt();
    _dio.options.baseUrl = _baseUrl;
  }

  final Dio _dio;

  final String serviceId;
  final String teamId;
  final String keyId;
  final String p8;

  final Duration tokenDuration;

  String _token = '';

  late DateTime _tokenIssuedAt;
  final Duration _tokenDuration = const Duration(seconds: 1);

  String _getJwt() {
    _tokenIssuedAt = DateTime.now();

    final jwt = JWT(
      {
        'sub': serviceId,
      },
      issuer: teamId,
      header: {
        'typ': 'JWT',
        'id': '$teamId.$serviceId',
        'alg': 'ES256',
        'kid': keyId,
      },
    );

    final signedJwt = jwt.sign(
      ECPrivateKey(p8),
      algorithm: JWTAlgorithm.ES256,
      expiresIn: _tokenDuration,
    );

    if (kDebugMode) {
      AppDebug.log(
        'Signed JWT Generated: $signedJwt',
        name: 'WeatherKitClient',
      );
    }

    return signedJwt;
  }

  void refreshJwtIfNecessary() {
    final expiresAt = _tokenIssuedAt.add(_tokenDuration);

    /// This is very unlikely with a 1 hour expiration for a weather app,
    /// but a safety check nonetheless
    if (DateTime.now().isAfter(expiresAt)) {
      _token = _getJwt();
    }
  }

  Future<Weather> getAllWeatherData({
    required Coordinates coordinates,
    required String timezone,
    String language = 'en',
    String countryCode = 'US',
    DateTime? currentAsOf,
    DateTime? dailyEnd,
    DateTime? dailyStart,
    DateTime? hourlyEnd,
    DateTime? hourlyStart,
  }) async {
    assert(
      coordinates.lat >= -90 && coordinates.lat <= 90,
      'latitude value must be between -90 and 90',
    );
    assert(
      coordinates.long >= -180 && coordinates.long <= 180,
      'longitude value must be between -180 and 180',
    );

    refreshJwtIfNecessary();

    final queryParameters = {
      'dataSets': _dataSetString(),
      'timezone': timezone,
      'country': countryCode,
      if (currentAsOf != null)
        'currentAsOf': currentAsOf.toUtc().toIso8601String(),
      if (dailyEnd != null) 'dailyEnd': dailyEnd.toUtc().toIso8601String(),
      if (dailyStart != null)
        'dailyStart': dailyStart.toUtc().toIso8601String(),
      if (hourlyEnd != null) 'hourlyEnd': hourlyEnd.toUtc().toIso8601String(),
      if (hourlyStart != null)
        'hourlyStart': hourlyStart.toUtc().toIso8601String(),
    };

    final url = 'weather/$language/${coordinates.lat}/${coordinates.long}';

    if (kDebugMode) {
      _logWeatherKit('WeatherKit Token: $_token');
      _logWeatherKit('url: $url');
    }
    _dio.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    };

    var retryCount = 0;

    while (retryCount < 3) {
      final cancelToken = CancelToken();

      final timeoutInSec = switch (retryCount) {
        0 => 7,
        1 => 3,
        _ => 2,
      };

      try {
        final response = await _dio
            .get<dynamic>(
          url,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
        )
            .timeout(
          Duration(seconds: timeoutInSec),
          onTimeout: () {
            throw TimeoutException('Timeout $retryCount');
          },
        );
        final data = response.data as Map<String, dynamic>;
        return Weather.fromMap(data);
      } on TimeoutException catch (e) {
        _logWeatherKit(
          'Connection Timeout: $e retry count $retryCount',
          isError: true,
        );

        cancelToken.cancel();

        retryCount++;

        if (retryCount < 3) {
          await Future<void>.delayed(const Duration(seconds: 1));
          getIt<AnalyticsBloc>().logAnalyticsEvent(
            AnalyticsEvent.weatherKitTimeout.name,
            info: {'retryCount': retryCount},
          );
        } else {
          throw WeatherKitFailureException('Maximum number of retries reached');
        }
      } catch (e) {
        final error = e is DioException ? e.error ?? e.response : e;

        throw WeatherKitFailureException('$error');
      }
    }
    throw WeatherKitFailureException('Maximum number of retries reached');
  }

  /// Returns a comma separated string of all [DataSet] values to place in the
  /// query parameters
  String _dataSetString() {
    final stringBuffer = StringBuffer();

    for (final dataSet in DataSet.values) {
      stringBuffer.write('${dataSet.name},');
    }
    return 'weatherAlerts,$stringBuffer';
  }

  void _logWeatherKit(
    String message, {
    bool isError = false,
  }) {
    AppDebug.log(
      message,
      name: 'WeatherKitClient',
      isError: isError,
    );
  }
}
