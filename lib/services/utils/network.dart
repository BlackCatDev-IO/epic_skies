import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  static const openWeatherApiKey = '035e88c5b14e6e5527f34ec2f25d64ae';
  static const baseOneCallURL =
      'https://api.openweathermap.org/data/2.5/onecall';

  Future<String> getData(String url) async {
    final http.Response response = await http.get(url);
    final responseCode = response.statusCode;
    if (responseCode != 200) {
      debugPrint(responseCode.toString());
      debugPrint(responseCode.toString());

      throw 'Data error';
      // return response.body;
    } else {
      debugPrint('Response Code from getData call: $responseCode');

      return response.body;
    }
  }

  String getOneCallCurrentLocationUrl(double long, double lat) =>
      '$baseOneCallURL?lat=$lat&lon=$long&units=imperial&exclude=%7Bpart%7D&appid=$openWeatherApiKey';
}
