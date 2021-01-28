import 'dart:convert';
import 'package:epic_skies/screens/location_search_page.dart';
import 'package:epic_skies/screens/search_screen.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkController extends GetxController {
  static const openWeatherApiKey = '035e88c5b14e6e5527f34ec2f25d64ae';
  static const googlePlacesApiKey = 'AIzaSyBXBNbHNtzFFngF5argVvb1WpnY51Gk3RQ';

  static const baseOneCallURL =
      'https://api.openweathermap.org/data/2.5/onecall';

  static const baseCitySearchURL = 'api.openweathermap.org/data/2.5/weather';

  static const googlePlacesBaseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  final client = Client();

  // NetworkController(String sessionKey);

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

  String getOneCallCurrentLocationUrl(double long, double lat) {
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

  Future<List<Suggestion>> fetchSuggestions({@required String input, @required String lang}) async {
    final sessionToken = Get.find<SearchController>().sessionToken.value;
    debugPrint('Session token: $sessionToken');
    final request =
        '$googlePlacesBaseURL?input=$input&types=(cities)&language=$lang&:ch&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
    
    final response = await client.get(request);

    debugPrint('Status code from Google Places API :${response.statusCode}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
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

  Future<Place> getPlaceDetailFromId({@required String placeId}) async {
    final sessionToken = Get.find<SearchController>().sessionToken.value;
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$googlePlacesApiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          // if (type.contains('street_number')) {
          //   place.streetNumber = c['long_name'];
          // }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
