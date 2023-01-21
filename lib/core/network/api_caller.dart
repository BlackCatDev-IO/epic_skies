import 'dart:io';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:uuid/uuid.dart';

import '../../utils/env/env.dart';

class ApiCaller {
  ApiCaller([Dio? dio]) : _dio = dio ?? Dio() {
    /// Only adding this adapter when not passing it in for unit tests
    if (dio == null) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  final Dio _dio;

  final sessionToken = const Uuid().v4();

/* -------------------------------------------------------------------------- */
/*                             VISUAL CROSSING API                            */
/* -------------------------------------------------------------------------- */

  Future<Map> getWeatherData({
    required double lat,
    required double long,
  }) async {
    final location = '$lat,$long';
    final url = '${Env.baseWeatherUrl}$location';

    final params = {
      'contentType': 'json',
      'unitGroup': 'us',
      'key': Env.weatherApiKey,
    };

    try {
      final response = await _dio.get(url, queryParameters: params);

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }
      return response.data as Map;
    } on DioError {
      final response = await _dio.get(url, queryParameters: params);
      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }

      return response.data as Map;
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

  Future<Map?> fetchSuggestions({
    required String query,
    required String lang,
  }) async {
    final Map<String, dynamic> queryParams =
        _getAutoCompleteQueryParams(query: query, lang: lang);

    try {
      final response = await _dio.get(
        _googlePlacesAutoCompleteUrl,
        queryParameters: queryParams,
      );

      if (response.statusCode != 200) {
        throw _getExceptionFromStatusCode(response.statusCode!);
      }
      return response.data as Map;
    } on Exception {
      rethrow;
    }
  }

  Future<Map> getPlaceDetailsFromId({required String placeId}) async {
    final params = {
      'place_id': placeId,
      'fields': 'geometry,address_component',
      'sessiontoken': sessionToken,
      'key': googlePlacesApiKey
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
  }

  Map<String, dynamic> _getAutoCompleteQueryParams({
    required String query,
    required String lang,
  }) {
    String type = 'cities';

    if (query.hasNumber) {
      type = 'regions';
    }

    return {
      'input': query,
      'types': '($type)',
      'language': lang,
      'sessiontoken': sessionToken,
      'key': googlePlacesApiKey
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
      final response =
          await _dio.get(url, queryParameters: {'key': bingMapsApiKey});

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
    } catch (e) {
      throw const NetworkException();
    }
  }

  Exception _getExceptionFromStatusCode(int statusCode) {
    final stringStatus = '$statusCode'.split('');
    switch (stringStatus[0]) {
      case '3':
      case '4':
        return NetworkException(statusCode: statusCode);
      case '5':
        return ServerErrorException(statusCode: statusCode);
      default:
        return NetworkException(statusCode: statusCode);
    }
  }
}
