import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location_model.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:get/get.dart';

class RemoteLocationController extends GetxController {
  RemoteLocationController({required this.storage});

  static RemoteLocationController get to => Get.find();

  final StorageController storage;

  RxList<SearchSuggestion> searchHistory = <SearchSuggestion>[].obs;
  RxList<SearchSuggestion> currentSearchList = <SearchSuggestion>[].obs;

  late RemoteLocationModel data;

  @override
  void onInit() {
    super.onInit();
    if (!storage.firstTimeUse() &&
        storage.restoreRemoteLocationData() != null) {
      data = storage.restoreRemoteLocationData()!;
    }
    _restoreSearchHistory();
  }

  Future<void> initRemoteLocationData({
    required Map dataMap,
    required SearchSuggestion suggestion,
  }) async {
    data = RemoteLocationModel.fromResponse(
      map: dataMap as Map<String, dynamic>,
      suggestion: suggestion,
    );

    log('searchCity character length: ${data.city.length}');

    log(
      'City:${data.city} \nState:${data.state}  \nCountry:${data.country} ',
      name: 'LocationController',
    );

    update();
    storage.storeRemoteLocationData(data: data);
  }

  void addToSearchList(SearchSuggestion suggestion) =>
      currentSearchList.add(suggestion);

  void clearCurrentSearchList() => currentSearchList.clear();

  void updateAndStoreSearchHistory(SearchSuggestion suggestion) {
    searchHistory.insert(0, suggestion);
    _removeDuplicates();
    storage.storeSearchHistory(searchHistory, suggestion);
  }

  void _restoreSearchHistory() {
    final RxList<SearchSuggestion> list = storage.restoreSearchHistory().obs;
    searchHistory.addAll(list);
  }

  void clearSearchHistory() {
    searchHistory.clear();
    storage.storeSearchHistory();
    Get.back();
  }

  void deleteSelectedSearch(SearchSuggestion selectedSuggestion) {
    for (int i = 0; i < searchHistory.length; i++) {
      final suggestion = searchHistory[i];
      if (suggestion.placeId == selectedSuggestion.placeId) {
        searchHistory.removeAt(i);
      }
    }
    storage.storeSearchHistory(searchHistory);
    Get.back();
  }

  void _removeDuplicates() {
    SearchSuggestion? duplicate;
    for (int i = 0; i < searchHistory.length; i++) {
      duplicate = searchHistory[i];
      for (int j = 0; j < searchHistory.length; j++) {
        final suggestion = searchHistory[j];
        if (suggestion.placeId == duplicate.placeId && i != j) {
          searchHistory.removeAt(j);
        }
      }
    }
  }

  void reorderSearchList(int oldindex, int newindex) {
    int index = newindex;
    if (newindex > oldindex) {
      index -= 1;
    }
    final newList = searchHistory.removeAt(oldindex);
    searchHistory.insert(index, newList);
    storage.storeSearchHistory(searchHistory);
  }
}
