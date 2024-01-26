import 'dart:developer';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/weather_kit/models/data_set/data_set.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';

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

    return jwt.sign(
      ECPrivateKey(p8),
      algorithm: JWTAlgorithm.ES256,
      expiresIn: _tokenDuration,
    );
  }

  void _refreshJwtIfNecessary() {
    final expiresAt = _tokenIssuedAt.add(_tokenDuration);

    /// This is very unlikely with a 1 hour expiration for a weather app,
    /// but a safety check nonetheless
    if (DateTime.now().isAfter(expiresAt)) {
      _token = _getJwt();
    }
  }

  Future<Weather> getAllWeatherData({
    required double lat,
    required double long,
    required String timezone,
    String? language = 'en',
    String? countryCode,
    DateTime? currentAsOf,
    DateTime? dailyEnd,
    DateTime? dailyStart,
    DateTime? hourlyEnd,
    DateTime? hourlyStart,
  }) async {
    assert(
      lat >= -90 && lat <= 90,
      'latitude value must be between -90 and 90',
    );
    assert(
      long >= -180 && long <= 180,
      'longitude value must be between -180 and 180',
    );

    _refreshJwtIfNecessary();

    final queryParameters = {
      'dataSets': _dataSetString(),
      'timezone': timezone,
      'country': countryCode ?? 'US',
      if (currentAsOf != null)
        'currentAsOf': currentAsOf.toUtc().toIso8601String(),
      if (dailyEnd != null) 'dailyEnd': dailyEnd.toUtc().toIso8601String(),
      if (dailyStart != null)
        'dailyStart': dailyStart.toUtc().toIso8601String(),
      if (hourlyEnd != null) 'hourlyEnd': hourlyEnd.toUtc().toIso8601String(),
      if (hourlyStart != null)
        'hourlyStart': hourlyStart.toUtc().toIso8601String(),
    };

    final url = 'weather/$language/$lat/$long';

    _dio.options.headers = {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    };

    try {
      final response = await _dio.get<dynamic>(
        url,
        queryParameters: queryParameters,
      );

      final data = response.data as Map<String, dynamic>;

      return Weather.fromMap(data);
    } on DioException catch (e) {
      log('$e', name: 'WeatherKitClient');
      throw WeatherKitFailureException('$e');
    } catch (e) {
      throw Exception('$e');
    }
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
}
