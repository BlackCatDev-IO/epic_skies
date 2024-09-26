import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  ApiService([Dio? dio]) : _dio = dio ?? Dio() {
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
    required Coordinates coordinates,
  }) async {
    final location = '${coordinates.lat},${coordinates.long}';
    final url = '${Env.WEATHER_API_BASE_URL}$location';

    final params = {
      'contentType': 'json',
      'unitGroup': 'metric',
      'key': Env.WEATHER_API_KEY,
    };

    try {
      final response = await _dio.get<dynamic>(url, queryParameters: params);

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }

      final error = e.error ?? e.response;

      throw Exception(error);
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
      final response = await _dio.get<dynamic>(
        _googlePlacesAutoCompleteUrl,
        queryParameters: queryParams,
      );

      return response.data as Map;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }

      final error = e.error ?? e.response;

      throw Exception(error);
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
        'key': Env.GOOGLE_PLACES_KEY,
      };

      final response = await _dio.get<dynamic>(
        _googlePlacesGeometryUrl,
        queryParameters: params,
      );

      final result = response.data as Map;

      if (result['status'] != 'OK') {
        throw LocationException();
      }

      return result;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoConnectionException();
      }

      final error = e.error ?? e.response;

      throw Exception(error);
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
      'key': Env.GOOGLE_PLACES_KEY,
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
      final response = await _dio.get<dynamic>(
        url,
        queryParameters: {'key': Env.BING_MAPS_BACKUP_API_KEY},
      );

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

      final error = e.error ?? e.response;

      throw Exception(error);
    } catch (e) {
      rethrow;
    }
  }
}
