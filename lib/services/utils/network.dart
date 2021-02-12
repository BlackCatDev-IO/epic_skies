import 'dart:convert';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkController extends GetxController {
  static const openWeatherApiKey = '035e88c5b14e6e5527f34ec2f25d64ae';
  static const climaCellApiKey = 'JXNffwrZ5r9qXMX8mA8Z9TWUw5xaoS9a';
  static const googlePlacesApiKey = 'AIzaSyBXBNbHNtzFFngF5argVvb1WpnY51Gk3RQ';
  static const baseOneCallURL =
      'https://api.openweathermap.org/data/2.5/onecall';
  static const baseCitySearchURL = 'api.openweathermap.org/data/2.5/weather';
  static const autoCompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static const googlePlacesGeometryUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static var client = Client();

  Future<String> getData(String url) async {
    final http.Response response = await http.get(url);
    final responseCode = response.statusCode;
    if (responseCode != 200) {
      debugPrint(responseCode.toString());

      throw 'Data error';
    } else {
      debugPrint('Response Code from getData call: $responseCode');

      return response.body;
    }
  }

  String getOneCallLocationUrl({@required double long, @required double lat}) {
    String unit = 'imperial';
    RxBool tempUnitsCelcius = Get.find<SettingsController>().tempUnitsCelcius;
    if (tempUnitsCelcius.value) {
      unit = 'metric';
    }

    return '$baseOneCallURL?lat=$lat&lon=$long&units=$unit&exclude=%7Bpart%7D&appid=$openWeatherApiKey';
  }

  String getCitySearchUrl(String city) {
    String unit = 'imperial';
    RxBool tempUnitsCelcius = Get.find<SettingsController>().tempUnitsCelcius;
    if (tempUnitsCelcius.value) {
      unit = 'metric';
    }

    return '$baseCitySearchURL?q=$city&units=$unit&appid=$openWeatherApiKey';
  }

  Future<List<SearchSuggestion>> fetchSuggestions(
      {@required String input, @required String lang}) async {
    // final sessionToken = Get.find<SearchController>().sessionToken.value;
    // debugPrint('Session token: $sessionToken');
    final request =
        // '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
        '$autoCompleteUrl?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey';

    final response = await client.get(request);

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
    final response = await client.get(request);
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
