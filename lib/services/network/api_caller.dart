import 'dart:convert';
import 'package:epic_skies/services/network/api_keys.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

class ApiCaller extends GetConnect {
/* -------------------------------------------------------------------------- */
/*                                CLIMACELL API                               */
/* -------------------------------------------------------------------------- */

  static const climaCellBaseUrl = 'https://data.climacell.co/v4/timelines';
  static const timesteps = 'timesteps=1h&timesteps=1d';

  List<String> _fieldList = [
    'temperature',
    'temperatureApparent',
    'windSpeed',
    'windDirection',
    'precipitationProbability',
    'precipitationType',
    'visibility',
    'cloudCover',
    'weatherCode'
  ];

  Future<Map> getWeatherData(String url) async {
    final response = await httpClient.get(url);
    debugPrint('ClimaCell response code: ${response.statusCode}');
    if (response.status.hasError) {
      debugPrint('error');
      return Future.error(response.statusText);
    } else {
      return response.body['data'];
    }
  }

  String getClimaCellUrl({@required double long, @required double lat}) {
    String unit = 'imperial';
    RxBool tempUnitsCelcius = Get.find<SettingsController>().tempUnitsCelcius;
    String timezone = tzmap.latLngToTimezoneString(lat, long);
    String fields = _getFieldsString();

    if (tempUnitsCelcius.value) {
      unit = 'metric';
    }
    final url =
        '$climaCellBaseUrl?location=$lat,$long&units=$unit&$fields$timesteps&timezone=$timezone&apikey=$climaCellApiKey';
    return url;
  }

  String _getFieldsString() {
    String fieldString = '';
    for (String field in _fieldList) {
      fieldString += 'fields=$field&';
    }
    return fieldString;
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
    // final sessionToken = Get.find<SearchController>().sessionToken.value;
    // debugPrint('Session token: $sessionToken');
    final request =
        // '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
        '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey';

    final response = await httpClient.get(request);

    debugPrint('Status code from Google Places API :${response.statusCode}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<SearchSuggestion>((p) => SearchSuggestion(
                placeId: p['place_id'], description: p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<void> getPlaceDetailsFromId(
      {@required String placeId, @required sessionToken}) async {
    debugPrint('Place id: $placeId');

    final searchController = Get.find<SearchController>();
    final request =
        '$googlePlacesGeometryUrl?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
    // '$googlePlacesGeometryUrl?place_id=$placeId&fields=geometry,address_component&key=$googlePlacesApiKey';
    final response = await httpClient.get(request);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        searchController.initRemoteLocationData(result);
      } else
        throw Exception(result['error_message']);
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
