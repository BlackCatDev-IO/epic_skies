import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  static const openWeatherApiKey = '035e88c5b14e6e5527f34ec2f25d64ae';
  static const baseOneCallURL =
      'https://api.openweathermap.org/data/2.5/onecall';
  static const baseCitySearchURL =
      'https://api.openweathermap.org/data/2.5/weather';

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
}
