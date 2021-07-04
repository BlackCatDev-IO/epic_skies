import 'dart:io';
import 'package:epic_skies/services/network/api_keys.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/error_handling/failure_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

class ApiCaller extends GetConnect {
  static ApiCaller get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                                TOMORROW.IO API                               */
/* -------------------------------------------------------------------------- */

  static const _climaCellBaseUrl = 'https://data.climacell.co/v4/timelines';
  final headers = {'apikey': climaCellApiKey};

  final _fieldList = const [
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

  final _timestepList = const [
    '1h',
    '1d',
    'current',
  ];

  String sessionToken = '';
  @override
  void onInit() {
    super.onInit();
    sessionToken = const Uuid().v4();
  }

  String buildTomorrowIOUrl({required double long, required double lat}) {
    httpClient.baseUrl = _climaCellBaseUrl;

    final timezone = TimeZoneController.to.timezoneString;
    final fields = _buildFieldsUrlPortion();
    final timesteps = _buildTimestepUrlPortion();
    final url =
        '?location=$lat,$long&units=imperial&$fields$timesteps&timezone=$timezone';

    return url;
  }

  Future<Map?> getWeatherData(String url) async {
    // _printFullClimaCellUrl(url);

    final response = await httpClient.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response.body['data'] as Map?;
    } else {
      FailureHandler.handleNetworkError(
          statusCode: response.statusCode!, method: 'getWeatherData');
    }
  }

  String _buildTimestepUrlPortion() {
    final timestep = StringBuffer();
    for (final time in _timestepList) {
      timestep.write('timesteps=$time&');
    }
    return timestep.toString().substring(0, timestep.length - 1);
  }

  String _buildFieldsUrlPortion() {
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
  static const googlePlacesGeometryUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  Future<Map?> fetchSuggestions({required String url}) async {
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final result = response.body;
        if (result['status'] == 'OK') {
          return result as Map;
        } //TODO: Check other potential statuses
      } else {
        FailureHandler.handleNetworkError(
            statusCode: response.statusCode!, method: 'fetchSuggestions');
      }
    } else {
      FailureHandler.handleNoConnection(method: 'fetchSuggestions');
    }
  }

  Future<Map> getPlaceDetailsFromId({
    required String placeId,
  }) async {
    final url = _buildPlacesIdUrl(placeId);
    // _printPlaccesUrl(url);
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final result = response.body as Map;
      if (result['status'] == 'OK') {
        return response.body as Map;
      } else {
        //TODO Handle other statuses
        throw Exception(result['error_message']);
      }
    } else {
      FailureHandler.handleNetworkError(
          statusCode: response.statusCode!, method: 'getPlaceDetailsFromId');
      throw HttpException(
          'Http Exception on getPlaceDetailsFromId: Status code: ${response.statusCode}');
    }
  }

  String buildSearchSuggestionUrl({
    required String query,
    required String lang,
  }) {
    httpClient.baseUrl = _googlePlacesAutoCompleteUrl;

    return '?input=$query&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
  }

  String _buildPlacesIdUrl(String placeId) {
    httpClient.baseUrl = googlePlacesGeometryUrl;

    return '?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
  }

  // ignore: unused_element
  void _printFullClimaCellUrl(String url) =>
      debugPrint('$_climaCellBaseUrl$url&apikey=$climaCellApiKey');

  // ignore: unused_element
  void _printPlaccesUrl(String url) =>
      debugPrint('places url: ${httpClient.baseUrl}$url');
}
