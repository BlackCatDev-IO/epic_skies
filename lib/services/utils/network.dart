import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkController {
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
}
