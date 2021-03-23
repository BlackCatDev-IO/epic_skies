import 'package:epic_skies/screens/tab_screens/location_search_page.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
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
  bool searchIsLocal = true;

  String city = '';
  String state = '';
  String country = '';
  String locality = '';
  String sessionToken = '';

  Future<void> goToSearchPage() async {
    sessionToken = Uuid().v4();
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

  void updateAndStoreList(SearchSuggestion suggestion) {
    searchHistory.removeWhere((value) => value == null);
    searchHistory.add(suggestion);

    StorageController.to.storeLatestSearch(suggestion: suggestion);
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
          data['result']['address_components'][0]['long_name'] as String ?? '';
      locality =
          data['result']['address_components'][1]['short_name'] as String ?? '';
      country =
          data['result']['address_components'][2]['long_name'] as String ?? '';
    }
    if (componentList.length == 4) {
      city =
          data['result']['address_components'][0]['long_name'] as String ?? '';
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
