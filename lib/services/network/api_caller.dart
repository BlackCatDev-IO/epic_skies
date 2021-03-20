import 'dart:convert';
import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/network/api_keys.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/failures.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiCaller extends GetConnect {
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

  String getClimaCellUrl({@required double long, @required double lat}) {
    _setBaseUrl();
    final timezone = TimeZoneController.to.timezoneString;

    String unit = 'imperial';
    final tempUnitsMetric = SettingsController.to.tempUnitsMetric.value;
    // final timezone = tzmap.latLngToTimezoneString(lat, long);
    final fields = _buildFieldsUrlPortion();
    final timesteps = _buildTimestepUrlPortion();

    if (tempUnitsMetric) {
      unit = 'metric';
    }
    final url =
        '?location=$lat,$long&units=$unit&$fields$timesteps&timezone=$timezone';
    return url;
  }

  Future<Map> getWeatherData(String url) async {
    // debugPrint(_climaCellBaseUrl + url);
    const failureHandler = FailureHandler();
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      final response = await httpClient.get(url);

      if (response.status.hasError) {
        failureHandler.handleError(response.statusCode);
        throw HttpException;
      }
      debugPrint('ClimaCell response code: ${response.statusCode}');
      return response.body['data'] as Map;
    } else {
      failureHandler.handleNoConnection();
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

  Future<List<SearchSuggestion>> fetchSuggestions(
      {@required String input, @required String lang}) async {
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
// final sessionToken = Get.find<SearchController>().sessionToken.value;
      // debugPrint('Session token: $sessionToken');
      final request =
          // '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
          '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey';

      final response = await httpClient.get(request);

      debugPrint('Status code from Google Places API :${response.statusCode}');

      if (response.statusCode == 200) {
        final result = json.decode(response.body as String);
        if (result['status'] == 'OK') {
          // compose suggestions in a list
          return result['predictions']
              .map<SearchSuggestion>((p) => SearchSuggestion(
                  placeId: p['place_id'] as String,
                  description: p['description'] as String))
              .toList() as Future<List<SearchSuggestion>>;
        }
        if (result['status'] == 'ZERO_RESULTS') {
          return [];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } else {
      showNoConnectionDialog(context: Get.context);
    }
    return null;
  }

  Future<void> getPlaceDetailsFromId(
      {@required String placeId, @required String sessionToken}) async {
    debugPrint('Place id: $placeId');

    final request =
        '$googlePlacesGeometryUrl?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
    // '$googlePlacesGeometryUrl?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey';
    final response = await httpClient.get(request);
    if (response.statusCode == 200) {
      final result = json.decode(response.body as String) as Map;
      if (result['status'] == 'OK') {
        SearchController.to.initRemoteLocationData(result);
      } else {
        throw Exception(result['error_message']);
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

class SearchSuggestion {
  final String placeId;
  final String description;

  SearchSuggestion({this.placeId, this.description});

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
