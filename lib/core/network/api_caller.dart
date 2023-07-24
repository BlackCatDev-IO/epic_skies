// ignore_for_file: inference_failure_on_function_invocation

import 'dart:io';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:uuid/uuid.dart';

class ApiCaller {
  ApiCaller([Dio? dio]) : _dio = dio ?? Dio() {
    /// Only adding this adapter when not passing it in for unit tests
    if (dio == null) {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
          return client;
        },
      );
    }
  }

  final Dio _dio;

  final _sessionToken = const Uuid().v4();

/* -------------------------------------------------------------------------- */
/*                             VISUAL CROSSING API                            */
/* -------------------------------------------------------------------------- */

  Future<Map<String, dynamic>> getWeatherData({
    required double lat,
    required double long,
  }) async {
    final location = '$lat,$long';
    final url = '${Env.WEATHER_API_BASE_URL}$location';

    final params = {
      'contentType': 'json',
      'unitGroup': 'us',
      'key': Env.WEATHER_API_KEY,
    };

    try {
      final response = await _dio.get(url, queryParameters: params);

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }
      final response = await _dio.get(url, queryParameters: params);
      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }

      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

/* -------------------------------------------------------------------------- */
/*                              GOOGLE PLACES API                             */
/* -------------------------------------------------------------------------- */

  static const _googlePlacesAutoCompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static const _googlePlacesGeometryUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  Future<Map<dynamic, dynamic>> fetchSuggestions({
    required String query,
    required String lang,
  }) async {
    final queryParams = _getAutoCompleteQueryParams(query: query, lang: lang);

    try {
      final response = await _dio.get(
        _googlePlacesAutoCompleteUrl,
        queryParameters: queryParams,
      );

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }
      return response.data as Map;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Future<Map<dynamic, dynamic>> getPlaceDetailsFromId({
    required String placeId,
  }) async {
    try {
      final params = {
        'place_id': placeId,
        'fields': 'geometry,address_component',
        'sessiontoken': _sessionToken,
        'key': Env.GOOGLE_PLACES_KEY
      };

      final response =
          await _dio.get(_googlePlacesGeometryUrl, queryParameters: params);

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }

      final result = response.data as Map;

      if (result['status'] == 'OK') {
        return response.data as Map;
      } else {
        throw LocationException();
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  Map<String, dynamic> _getAutoCompleteQueryParams({
    required String query,
    required String lang,
  }) {
    var type = 'cities';

    if (query.hasNumber) {
      type = 'regions';
    }

    return {
      'input': query,
      'types': '($type)',
      'language': lang,
      'sessiontoken': _sessionToken,
      'key': Env.GOOGLE_PLACES_KEY
    };
  }

/* -------------------------------------------------------------------------- */
/*                            BACKUP BING MAPS API                            */
/* -------------------------------------------------------------------------- */

  static const bingMapsBaseUrl =
      'http://dev.virtualearth.net/REST/v1/Locations/';

  Future<Map<String, dynamic>> getBackupApiDetails({
    required double lat,
    required double long,
  }) async {
    final url = '$bingMapsBaseUrl$lat,$long';

    try {
      final response = await _dio
          .get(url, queryParameters: {'key': Env.BING_MAPS_BACKUP_API_KEY});

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }

      final addressComponents = (response.data as Map)['resourceSets'] as List?;
      if (addressComponents != null && addressComponents.isNotEmpty) {
        final resourceList = addressComponents[0] as Map;

        final resources =
            (resourceList['resources'] as List)[0] as Map<String, dynamic>;

        return resources['address'] as Map<String, dynamic>;
      } else {
        throw NoAddressInfoFoundException();
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }
      rethrow;
    } catch (e) {
      throw NetworkException();
    }
  }

  Exception _getExceptionFromStatusCode(int statusCode) {
    final stringStatus = '$statusCode'.split('');
    switch (stringStatus[0]) {
      case '3':
      case '4':
        return NetworkException();
      case '5':
        return ServerErrorException();
      default:
        return NetworkException();
    }
  }
}
