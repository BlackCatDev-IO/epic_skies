import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/location_search_page.dart';
import 'package:epic_skies/services/utils/database/storage_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'master_getx_controller.dart';
import 'network.dart';

class SearchController extends GetxController {
  TextEditingController textController;

  final storageController = Get.find<StorageController>();
  final networkController = Get.find<NetworkController>();
  final weatherController = Get.find<WeatherController>();
  final forecastController = Get.find<ForecastController>();

  RxList searchHistory = [].obs;

  RxString searchString = ''.obs;

  double lat, long;
  bool searchIsLocal = true;

  String city = '';
  String state = '';
  String country = '';
  String locality = '';
  String sessionToken = '';

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
    // final newMap = parseSearchData(data);
    // debugPrint(newMap.toString());
    // final map = await compute(parseData, data);
  }

  void showSearchSuggestions() async {
    sessionToken = Uuid().v4();
    await showSearch(
      context: Get.context,
      delegate: LocationSearchPage(sessionToken),
    );
  }

  Future<dynamic> searchSelectedLocation({Suggestion suggestion}) async {
    if (suggestion == null) {
      suggestion = storageController.restoreLatestSuggestion();
    }

    searchIsLocal = false;
    searchHistory.removeWhere((value) => value == null);
    searchHistory.add(suggestion);

    storageController.storeLatestSearch(suggestion: suggestion);

    await networkController.getPlaceDetailsFromId(
        placeId: suggestion.placeId, sessionToken: sessionToken);

    final url = networkController.getOneCallLocationUrl(lat: lat, long: long);

    final data = await networkController.getData(url);

    final weatherObject = await compute(weatherFromJson, data);

    storageController.storeWeatherData(map: weatherObject.toJson());
    update();
    Get.find<MasterController>().initUiValues();
  }

  void addToSearchHistory(Suggestion suggestion) {}

  void restoreSearchHistory() {
    final map = storageController.restoreRecentSearchMap();
    var newLIst = searchHistory.toSet().toList();

    if (map != null) {
      for (int i = 0; i < map.length; i++) {
        final suggestionMap = map[(i).toString()];
        final placeId = suggestionMap['placeId'];
        final description = suggestionMap['description'];
        final suggestion =
            Suggestion(placeId: placeId, description: description);
        searchHistory.add(suggestion);
      }
    }

    // searchHistory.rem
  }

  void removeDuplicates() {
    final newList = searchHistory.toSet().toList();
    searchHistory.clear();

    searchHistory.add(newList);
  }

  void initRemoteLocationData(Map data) {
    final componentList = data['result']['address_components'];
    lat = data['result']['geometry']['location']['lat'];
    long = data['result']['geometry']['location']['lng'];

    if (componentList.length == 3) {
      city = data['result']['address_components'][0]['short_name'] ?? '';
      locality = data['result']['address_components'][1]['short_name'] ?? '';
      country = data['result']['address_components'][2]['long_name'] ?? '';
    }
    if (componentList.length == 4) {
      city = data['result']['address_components'][0]['short_name'] ?? '';
      locality = data['result']['address_components'][1]['short_name'] ?? '';
      state = data['result']['address_components'][2]['long_name'] ?? '';
      country = data['result']['address_components'][3]['long_name'] ?? '';
    }

    //  $.result.address_components[0].short_name

    // final place4 = result['result']['address_components'][4]['short_name'];
    // final place5 = result['result']['address_components'][5]['short_name'];
    // final place6 = result['result']['address_components'][6]['short_name'];
    debugPrint(
        'City:$city \nLocality/County:$locality \nState:$state \nCountry:$country ');
    // '0:$place0 1:$place1 2:$place2 3:$place3: 4:$place4 5:$place5 6:$place6');
    update();
  }

  void updateSearchIsLocalBool(bool value) {
    searchIsLocal = value;
    Get.find<StorageController>().storeLocalOrRemote(searchIsLocal: value);
    update();
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = Get.find<StorageController>().restoreLatestSuggestion();
    searchSelectedLocation(suggestion: suggestion);
  }
}
