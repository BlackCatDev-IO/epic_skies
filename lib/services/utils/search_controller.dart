// import 'package:flutter/material.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';

import 'package:epic_skies/models/weather_model.dart';
import 'package:epic_skies/screens/location_search_page.dart';
import 'package:epic_skies/services/utils/storage_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'network.dart';

class SearchController extends GetxController {
  TextEditingController textController;

  RxList searchHistory = [
    Suggestion(
        placeId: 'ChIJJ3SpfQsLlVQRkYXR9ua5Nhw', description: 'Recent Searches')
  ].obs;
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

  Future<dynamic> searchSelectedLocation(
      {@required String placeId, Suggestion suggestion}) async {
    searchIsLocal = false;
    searchHistory.removeWhere((value) => value == null);
    searchHistory.add(suggestion);

    final storageController = Get.find<StorageController>();
    final networkController = Get.find<NetworkController>();

    storageController.storeLocalOrRemote(searchIsLocal: false);
    storageController.storePlaceId(placeId);

    await networkController.getPlaceDetailsFromId(
        placeId: placeId, sessionToken: sessionToken);

    final url = networkController.getOneCallLocationUrl(lat: lat, long: long);

    final data = await networkController.getData(url);

    final weatherObject = await compute(weatherFromJson, data);

    storageController.storeWeatherData(map: weatherObject.toJson());

    Get.find<WeatherController>().initCurrentWeatherValues();
    Get.find<ForecastController>().buildForecastWidgets();
  }

  void initRemoteLocationData(Map data) {
    // debugPrint('Map: $data');
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

  void updateSearchIsLocalBool(bool update) {
    searchIsLocal = update;
    Get.find<StorageController>().storeLocalOrRemote(searchIsLocal: update);
  }

  Future<void> updateRemoteLocationData() async {
    final placeId = Get.find<StorageController>().restorePlaceId();
    searchSelectedLocation(placeId: placeId);
  }
}
