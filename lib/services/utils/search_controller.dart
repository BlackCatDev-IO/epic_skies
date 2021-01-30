// import 'package:flutter/material.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';

import 'dart:convert';

import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/location_search_page.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../local_constants.dart';
import 'network.dart';

class SearchController extends GetxController {
  TextEditingController textController;
  // List<Suggestion> suggestionList = [];

  RxString placeId, searchString = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  RxBool searchIsRemote = false.obs;

  final searchBox = GetStorage(searchStorageKey);

  @override
  void onInit() async {
    super.onInit();
    textController = TextEditingController();
    textController.addListener(() async {
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

  void showSearchSuggestions() async {
    final sessionToken = Uuid().v4();
    final networkController = NetworkController();
    final Suggestion result = await showSearch(
      context: Get.context,
      delegate: LocationSearchPage(sessionToken),
    );

    if (result != null) {
      final placeDetails =
          await networkController.getCoordinatesFromId(placeId: result.placeId);
      textController.text = result.description;
    }
  }

  Future<dynamic> searchSelectedLocation({@required String placeId}) async {
    final networkController = Get.find<NetworkController>();
    await networkController.getCoordinatesFromId(placeId: placeId);

    final url = networkController.getOneCallCurrentLocationUrl(
        lat: lat.value, long: long.value);

    final data = await networkController.getData(url);

    final weatherObject = await compute(weatherFromJson, data);

    final weatherController = Get.find<WeatherController>();
    final dataMap = weatherController.dataMap;

    dataMap.assignAll(weatherObject.toJson());
    await searchBox.write(searchStorageKey, dataMap);
    weatherController.initCurrentWeatherValues();
    Get.find<ForecastController>().buildForecastWidgets();
  }

  Map<String, dynamic> parseSearchData(String data) {
    final map = Map<String, dynamic>();
    map['city_temp'] = (jsonDecode(data)['main']['temp']).round().toString();
    map['city_main'] = (jsonDecode(data)['weather'][0]['main']).toString();
    return map;
  }
}
