import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/screens/tab_screens/location_search_page.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../network/api_caller.dart';
import 'master_getx_controller.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();

  TextEditingController textController;

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
  Future<void> onInit() async {
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

  Future<void> showSearchSuggestions() async {
    sessionToken = Uuid().v4();
    await showSearch(
      context: Get.context,
      delegate: LocationSearchPage(sessionToken),
    );
  }

  Future<void> searchSelectedLocation({SearchSuggestion suggestion}) async {
    final hasConnection = await DataConnectionChecker().hasConnection;
    SearchSuggestion newSuggestion;

    if (hasConnection) {
      final apiCaller = ApiCaller();
      if (suggestion == null) {
        newSuggestion = StorageController.to.restoreLatestSuggestion();
      }

      searchIsLocal = false;
      searchHistory.removeWhere((value) => value == null);
      searchHistory.add(newSuggestion);

      StorageController.to.storeLatestSearch(suggestion: newSuggestion);

      await apiCaller.getPlaceDetailsFromId(
          placeId: newSuggestion.placeId, sessionToken: sessionToken);

      final url = apiCaller.getClimaCellUrl(lat: lat, long: long);

      final data = await apiCaller.getWeatherData(url);

      StorageController.to.storeWeatherData(map: data);
      update();
      MasterController.to.initUiValues();
    } else {
      showNoConnectionDialog(context: Get.context);
    }
  }

  void addToSearchHistory(SearchSuggestion suggestion) {}

  void restoreSearchHistory() {
    final map = StorageController.to.restoreRecentSearchMap();

    if (map != null) {
      for (int i = 0; i < map.length; i++) {
        final suggestionMap = map[(i).toString()];
        final placeId = suggestionMap['placeId'];
        final description = suggestionMap['description'];
        final suggestion = SearchSuggestion(
            placeId: placeId as String, description: description as String);
        searchHistory.add(suggestion);
      }
    }
  }

  void removeDuplicates() {
    final newList = searchHistory.toSet().toList();
    searchHistory.clear();

    searchHistory.add(newList);
  }

  void initRemoteLocationData(Map data) {
    final componentList = data['result']['address_components'];
    lat = data['result']['geometry']['location']['lat'] as double;
    long = data['result']['geometry']['location']['lng'] as double;

    if (componentList.length == 3) {
      city =
          data['result']['address_components'][0]['short_name'] as String ?? '';
      locality =
          data['result']['address_components'][1]['short_name'] as String ?? '';
      country =
          data['result']['address_components'][2]['long_name'] as String ?? '';
    }
    if (componentList.length == 4) {
      city =
          data['result']['address_components'][0]['short_name'] as String ?? '';
      locality =
          data['result']['address_components'][1]['short_name'] as String ?? '';
      state =
          data['result']['address_components'][2]['long_name'] as String ?? '';
      country =
          data['result']['address_components'][3]['long_name'] as String ?? '';
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

  void updateSearchIsLocalBool({bool value}) {
    searchIsLocal = value;
    StorageController.to.storeLocalOrRemote(searchIsLocal: value);
    update();
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = StorageController.to.restoreLatestSuggestion();
    searchSelectedLocation(suggestion: suggestion);
  }
}
