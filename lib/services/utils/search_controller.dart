// import 'package:flutter/material.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'network.dart';

class SearchController extends GetxController {
  TextEditingController textController;
  RxString searchString = ''.obs;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    textController.addListener(() {
      searchString.value = textController.text;
      debugPrint(textController.text);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> searchCityWeather() async {
    final networkController = NetworkController();

    final data = await networkController
        .getData(networkController.getCitySearchUrl(searchString.value));
    final newMap = parseSearchData(data);
    debugPrint(newMap.toString());
    // final map = await compute(parseData, data);
  }

  Map<String, dynamic> parseSearchData(String data) {
    final map = Map<String, dynamic>();
    map['city_temp'] = (jsonDecode(data)['main']['temp']).round().toString();
    map['city_main'] = (jsonDecode(data)['weather'][0]['main']).toString();
    return map;
  }
}
