// import 'package:flutter/material.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';

import 'dart:convert';

import 'package:epic_skies/screens/location_search_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'network.dart';

class SearchController extends GetxController {
  TextEditingController textController;
  RxString searchString = ''.obs;
  List<Suggestion> suggestionList = [];

  RxString sessionToken = ''.obs;

  // _controller.text = result.description;

  String _streetNumber;
  String _street;
  String _city;
  String _zipCode;

  @override
  void onInit() async {
    super.onInit();
    textController = TextEditingController();
    textController.addListener(() async {
      searchString.value = textController.text;
      debugPrint(textController.text);
      // final network = NetworkController();
      // suggestionList = await network.fetchSuggestions(searchString.value, 'en');
      // debugPrint('Suggestions list: $suggestionList');
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
    sessionToken.value = Uuid().v4();
    final networkController = NetworkController();
    final Suggestion result = await showSearch(
      context: Get.context,
      delegate: LocationSearchPage(sessionToken),
    );
    // This will change the text displayed in the TextField
    if (result != null) {
      // final placeDetails = await PlaceApiProvider(sessionToken)
      //     .getPlaceDetailFromId(result.placeId);

      final placeDetails =
          await networkController.getPlaceDetailFromId(placeId: result.placeId);
      textController.text = result.description;
      _street = placeDetails.street;
      _city = placeDetails.city;
      _zipCode = placeDetails.zipCode;
    }
  }

  Map<String, dynamic> parseSearchData(String data) {
    final map = Map<String, dynamic>();
    map['city_temp'] = (jsonDecode(data)['main']['temp']).round().toString();
    map['city_main'] = (jsonDecode(data)['weather'][0]['main']).toString();
    return map;
  }
}
