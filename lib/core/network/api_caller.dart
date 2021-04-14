import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/failure_handler.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiCaller extends GetConnect {
  static ApiCaller get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                                CLIMACELL API                               */
/* -------------------------------------------------------------------------- */

  static const _climaCellBaseUrl = 'https://data.climacell.co/v4/timelines';

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

  String buildClimaCellUrl({@required double long, @required double lat}) {
    _setBaseUrl();
    final timezone = TimeZoneController.to.timezoneString;

    final fields = _buildFieldsUrlPortion();
    final timesteps = _buildTimestepUrlPortion();

    final url =
        '?location=$lat,$long&units=imperial&$fields$timesteps&timezone=$timezone';
    return url;
  }

  Future<Map> getWeatherData(String url) async {
    // _printFullClimaCellUrl(url);
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      final response = await httpClient.get(url);

      if (response.status.hasError) {
        FailureHandler.to.handleHttpError(response.statusCode);
      }
      return response.body['data'] as Map;
    } else {
      FailureHandler.to.handleNoConnection();
    }
    return null;
  }

  void _setBaseUrl() {
    httpClient.baseUrl = _climaCellBaseUrl;
    httpClient.addRequestModifier((request) {
      request.headers['apikey'] = climaCellApiKey;
      return request;
    });
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

  static const autoCompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const googlePlacesGeometryUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  Future<void> fetchSuggestions(
      {@required String input, @required String lang}) async {
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      final url = _buildSearchSuggestionUrl(input, lang);
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final result = response.body;
        if (result['status'] == 'OK') {
          SearchController.to.buildSearchSuggestions(result as Map);
        } //TODO: Check other potential statuses
      } else {
        FailureHandler.to.handleNon200Response(response.statusCode);
      }
    } else {
      FailureHandler.to.handleNoConnection();
    }
  }

  Future<void> getPlaceDetailsFromId(
      {@required String placeId, @required String sessionToken}) async {
    final url =
        '$googlePlacesGeometryUrl?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
    debugPrint('place details url: $url');
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final result = response.body as Map;
      if (result['status'] == 'OK') {
        await SearchController.to.initRemoteLocationData(result);
      } else {
        throw Exception(result['error_message']);
      }
    } else {
      FailureHandler.to.handleFailedPlaceDetailsSearch(response.statusCode);
    }
  }

  String _buildSearchSuggestionUrl(String input, String lang) {
    final sessionToken = SearchController.to.sessionToken;
    return '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
  }

  // ignore: unused_element
  void _printFullClimaCellUrl(String url) =>
      debugPrint('$_climaCellBaseUrl$url&apikey=$climaCellApiKey');
}
