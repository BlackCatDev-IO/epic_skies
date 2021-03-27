import 'package:epic_skies/screens/location_search_page.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();

  RxList searchHistory = [].obs;
  RxList currentSearchList = [].obs;

  double lat, long;

  String city = '';
  String state = '';
  String country = '';
  String locality = '';
  String sessionToken = '';

  Map<String, dynamic> locationMap = {};

  @override
  void onInit() {
    super.onInit();
    sessionToken = Uuid().v4();
    _initLocationDataFromStorage();
  }

  Future<void> goToSearchPage() async {
    await showSearch(
      context: Get.context,
      delegate: LocationSearchPage(sessionToken),
    );
  }

  void buildSearchSuggestions(Map result) {
    currentSearchList.clear();

    final prediction = result['predictions'] as List;

    for (int i = 0; i < prediction.length; i++) {
      final map = prediction[i];

      final description = map['description'] as String;
      final placeId = map['place_id'] as String;
      final suggestion =
          SearchSuggestion(description: description, placeId: placeId);
      final tile = SearchListTile(suggestion: suggestion);

      currentSearchList.add(tile);
    }
  }

  void updateAndStoreSearchHistory(SearchSuggestion suggestion) {
    searchHistory.removeWhere((value) => value == null);
    searchHistory.insert(0, suggestion);
    _removeDuplicates();
    StorageController.to.storeSearchHistory(searchHistory, suggestion);
  }

  void restoreSearchHistory() {
    final RxList list = StorageController.to.restoreSearchHistory().obs;
    searchHistory.addAll(list);
  }

  void deleteSelectedSearch(SearchSuggestion selectedSuggestion) {
    for (int i = 0; i < searchHistory.length; i++) {
      final suggestion = searchHistory[i];
      if (suggestion.placeId == selectedSuggestion.placeId) {
        searchHistory.removeAt(i);
      }
    }
    StorageController.to.storeSearchHistory(searchHistory);
    Get.back();
  }

  void _removeDuplicates() {
    SearchSuggestion duplicate;
    for (int i = 0; i < searchHistory.length; i++) {
      duplicate = searchHistory[i] as SearchSuggestion;
      for (int j = 0; j < searchHistory.length; j++) {
        final suggestion = searchHistory[j] as SearchSuggestion;
        if (suggestion.placeId == duplicate.placeId && i != j) {
          searchHistory.removeAt(j);
        }
      }
    }
  }

  Future<void> initRemoteLocationData(Map data) async {
    final dataMap = data['result']['address_components'];
    lat = data['result']['geometry']['location']['lat'] as double;
    long = data['result']['geometry']['location']['lng'] as double;

    _clearLocationValues();

    debugPrint('components length ${dataMap.length}}');

    for (int i = 0; i < (dataMap.length as int); i++) {
      final type = dataMap[i]['types'][0];

      switch (type as String) {
        case 'country':
          country = dataMap[i]['long_name'] as String;
          break;
        case 'administrative_area_level_1':
          state = dataMap[i]['long_name'] as String;
          break;
        case 'locality':
          city = dataMap[i]['long_name'] as String;
          break;
        case 'colloquial_area':
          city = dataMap[i]['long_name'] as String;
          break;
      }
    }
    if (country != 'United States') {
      state = '';
    }
    debugPrint(
        'City:$city \nLocality/County:$locality \nState:$state \nCountry:$country ');
    update();
    _storeRemoteLocationData();
  }

  void _storeRemoteLocationData() {
    locationMap = {
      'city': city ?? '',
      'state': state ?? '',
      'country': country ?? '',
      'locality': locality ?? '',
    };
    StorageController.to.storeRemoteLocationData(map: locationMap);
  }

  void _initLocationDataFromStorage() {
    locationMap = StorageController.to.restoreRemoteLocationData();
    city = locationMap['city'] as String ?? '';
    state = locationMap['state'] as String ?? '';
    country = locationMap['country'] as String ?? '';
    locality = locationMap['locality'] as String ?? '';
  }

  void _clearLocationValues() {
    city = '';
    state = '';
    country = '';
    locality = '';
  }
}

class SearchSuggestion {
  final String placeId;
  final String description;

  SearchSuggestion({this.placeId, this.description});

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
