import 'dart:developer';
import 'dart:io';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

class ApiCaller {
/* -------------------------------------------------------------------------- */
/*                                TOMORROW.IO API                               */
/* -------------------------------------------------------------------------- */

  static final dio = Dio();

  static const _climaCellBaseUrl = 'https://data.climacell.co/v4/timelines';

  static const headers = {'apikey': climaCellApiKey};

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

  static void initAndStoreSessionToken() {
    StorageController.to.storeSessionToken(token: const Uuid().v4());
  }

  static String buildTomorrowIOUrl({
    required double long,
    required double lat,
  }) {
    dio.options.baseUrl = _climaCellBaseUrl;
    dio.options.headers = headers;

    final timezone = TimeZoneController.to.timezoneString;
    final fields = _buildFieldsUrlPortion();
    final timesteps = _buildTimestepUrlPortion();
    final url =
        '?location=$lat,$long&units=imperial&$fields$timesteps&timezone=$timezone';

    return url;
  }

  static Future<Map?> getWeatherData(String url) async {
    // _printFullClimaCellUrl(url);

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return response.data['data'] as Map?;
    } else {
      FailureHandler.handleNetworkError(
        statusCode: response.statusCode,
        method: 'getWeatherData',
      );
    }
  }

  static String _buildTimestepUrlPortion() {
    final timestep = StringBuffer();
    for (final time in _timestepList) {
      timestep.write('timesteps=$time&');
    }
    return timestep.toString().substring(0, timestep.length - 1);
  }

  static String _buildFieldsUrlPortion() {
    final fields = StringBuffer();
    for (final field in _fieldList) {
      fields.write('fields=$field&');
    }
    return fields.toString();
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
    final url = _buildSearchSuggestionUrl(query: query, lang: lang);
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return response.data as Map;
      } else {
        FailureHandler.handleNetworkError(
          statusCode: response.statusCode,
          method: 'fetchSuggestions',
        );
      }
    } else {
      FailureHandler.handleNoConnection(method: 'fetchSuggestions');
    }
  }

  static Future<Map> getPlaceDetailsFromId({required String placeId}) async {
    final url = _buildPlacesIdUrl(placeId);
    // _printPlaccesUrl(url);
    final response = await dio.get(url);
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

  static String _buildSearchSuggestionUrl({
    required String query,
    required String lang,
  }) {
    dio.options.baseUrl = _googlePlacesAutoCompleteUrl;
    final sessionToken = StorageController.to.restoreSessionToken();
    String type = 'cities';

    if (query.hasNumber) {
      type = 'regions';
    }
    return '?input=$query&types=($type)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
  }

  static String _buildPlacesIdUrl(String placeId) {
    dio.options.baseUrl = _googlePlacesGeometryUrl;
    final sessionToken = StorageController.to.restoreSessionToken();

    return '?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
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
    dio.options.baseUrl = bingMapsBaseUrl;
    final url = '$lat,$long?key=$bingMapsApiKey';

    try {
      final response = await dio.get(url);

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

  // ignore: unused_element
  void _printFullClimaCellUrl(String url) =>
      log('$_climaCellBaseUrl$url&apikey=$climaCellApiKey');

  // ignore: unused_element
  void _printPlaccesUrl(String url) =>
      log('places url: ${dio.options.baseUrl}$url');
}
