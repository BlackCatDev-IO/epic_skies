import 'dart:developer';
import 'dart:io';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/storage_getters/settings.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

class ApiCaller {
  static final _dio = Dio();

  static void initAndStoreSessionToken() {
    StorageController.to.storeSessionToken(token: const Uuid().v4());
  }

/* -------------------------------------------------------------------------- */
/*                                TOMORROW.IO API                             */
/* -------------------------------------------------------------------------- */

  static const _tomorrowIoBaseUrl = 'https://data.climacell.co/v4/timelines';

  static const _fieldList = [
    'temperature',
    'temperatureApparent',
    'humidity',
    'cloudBase',
    'cloudCeiling',
    'cloudCover',
    'windSpeed',
    'windDirection',
    'precipitationProbability',
    'precipitationType',
    'precipitationIntensity',
    'visibility',
    'cloudCover',
    'weatherCode',
    'sunsetTime',
    'sunriseTime'
  ];

  static const _timestepList = [
    'current',
    '1h',
    '1d',
  ];

  static Future<Map?> getWeatherData({
    required double lat,
    required double long,
  }) async {
    log('lat: $lat long: $long');
    final params = {
      'location': '$lat,$long',
      'units': 'imperial',
      'fields': _fieldList,
      'timezone': TimeZoneController.to.timezoneString,
      'timesteps': _timestepList,
      'apikey': climaCellApiKey,
    };

    try {
      final response =
          await _dio.get(_tomorrowIoBaseUrl, queryParameters: params);
      if (response.statusCode == 200) {
        return response.data['data'] as Map?;
      } else {
        FailureHandler.handleNetworkError(
          statusCode: response.statusCode,
          method: 'getWeatherData',
        );
      }
    } catch (e) {
      FailureHandler.logUnknownException(
        method: 'getWeatherData',
        error: e.toString(),
      );
    }
  }

/* -------------------------------------------------------------------------- */
/*                              GOOGLE PLACES API                             */
/* -------------------------------------------------------------------------- */

  static const _googlePlacesAutoCompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static const _googlePlacesGeometryUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static Future<Map?> fetchSuggestions({
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
  }

  static Future<Map> getPlaceDetailsFromId({required String placeId}) async {
    final params = {
      'place_id': placeId,
      'fields': 'geometry,address_component',
      'sessiontoken': Settings.sessionToken,
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

  static Map<String, dynamic> _getAutoCompleteQueryParams({
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
      'sessiontoken': Settings.sessionToken,
      'key': googlePlacesApiKey
    };
  }

/* -------------------------------------------------------------------------- */
/*                            BACKUP BING MAPS API                            */
/* -------------------------------------------------------------------------- */

  static const bingMapsBaseUrl =
      'http://dev.virtualearth.net/REST/v1/Locations/';

  static Future<Map<String, dynamic>> getBackupApiDetails({
    required double lat,
    required double long,
  }) async {
    final url = '$bingMapsBaseUrl$lat,$long';

    try {
      final response =
          await _dio.get(url, queryParameters: {'key': bingMapsApiKey});

      if (response.statusCode == 200) {
        final addressComponents = response.data['resourceSets'][0]['resources']
            [0]['address'] as Map<String, dynamic>;

        log(addressComponents.toString());
        return addressComponents;
      }
    } catch (e) {
      log(e.toString());
    }
    return {};
  }
}
