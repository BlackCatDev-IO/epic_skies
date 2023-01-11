import 'dart:developer';
import 'dart:io';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

import '../../utils/env/env.dart';

class ApiCaller {
  ApiCaller([Dio? dio]) : _dio = dio ?? Dio() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  final Dio _dio;

  final sessionToken = const Uuid().v4();

/* -------------------------------------------------------------------------- */
/*                             VISUAL CROSSING API                            */
/* -------------------------------------------------------------------------- */

  Future<Map?> getWeatherData({
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
      if (response.statusCode == 200) {
        return response.data as Map;
      } else {
        FailureHandler.handleNetworkError(
          statusCode: response.statusCode,
          method: 'getWeatherData',
        );
      }
    } on DioError catch (e) {
      final response = await _dio.get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return response.data as Map;
      } else {
        FailureHandler.handleNetworkError(
          statusCode: response.statusCode,
          method: 'getWeatherData',
        );
      }

      FailureHandler.logUnknownException(
        error: 'Dio Error: ${e.message}, Retry result: $response',
        method: 'getWeatherData',
      );
    } catch (e) {
      FailureHandler.logUnknownException(
        method: 'getWeatherData',
        error: e.toString(),
      );
    }
    return null;
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
    final hasConnection = await InternetConnectionChecker().hasConnection;
    final Map<String, dynamic> queryParams =
        _getAutoCompleteQueryParams(query: query, lang: lang);

    if (hasConnection) {
      try {
        final response = await _dio.get(
          _googlePlacesAutoCompleteUrl,
          queryParameters: queryParams,
        );

        if (response.statusCode == 200) {
          return response.data as Map;
        } else {
          FailureHandler.handleNetworkError(
            statusCode: response.statusCode,
            method: 'fetchSuggestions',
          );
        }
      } on Exception catch (e) {
        FailureHandler.logUnknownException(
          error: e.toString(),
          method: 'fetchSuggestions',
        );
      }
    } else {
      FailureHandler.handleNoConnection(method: 'fetchSuggestions');
    }
    return null;
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

    if (response.statusCode == 200) {
      final result = response.data as Map;
      if (result['status'] == 'OK') {
        return response.data as Map;
      } else {
        //TODO Handle other statuses
        throw Exception(result['error_message']);
      }
    } else {
      FailureHandler.handleNetworkError(
        statusCode: response.statusCode,
        method: 'getPlaceDetailsFromId',
      );
      throw HttpException(
        'Http Exception on getPlaceDetailsFromId: Status code: ${response.statusCode}',
      );
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

      if (response.statusCode == 200) {
        final addressComponents =
            (response.data as Map)['resourceSets'] as List;
        final resourceList = addressComponents[0] as Map;

        final resources =
            (resourceList['resources'] as List)[0] as Map<String, dynamic>;

        return resources['address'] as Map<String, dynamic>;
      }
    } catch (e) {
      FailureHandler.logUnknownException(
        error: e.toString(),
        method: 'getBackupApiDetails',
      );
      log(e.toString());
    }
    return {};
  }
}
