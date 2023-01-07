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

  RemoteLocationModel? data;

  @override
  void onInit() {
    super.onInit();
    if (!storage.firstTimeUse() &&
        storage.restoreRemoteLocationData() != null) {
      data = storage.restoreRemoteLocationData();
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

    storage.storeCoordinates(lat: data!.remoteLat, long: data!.remoteLong);

    log('searchCity character length: ${data!.city.length}');

    log(
      'City:${data!.city} \nState:${data!.state}  \nCountry:${data!.country} ',
      name: 'LocationController',
    );

    storage.storeRemoteLocationData(data: data!, suggestion: suggestion);

    _updateAndStoreSearchHistory(suggestion);

    update();
  }

  void addToSearchList(SearchSuggestion suggestion) =>
      currentSearchList.add(suggestion);

  void clearCurrentSearchList() => currentSearchList.clear();

  void _updateAndStoreSearchHistory(SearchSuggestion suggestion) {
    searchHistory.insert(0, suggestion);
    _removeDuplicates();
    _storeSearchHistory();
  }

  void _restoreSearchHistory() {
    final RxList<SearchSuggestion> list = storage.restoreSearchHistory().obs;

    searchHistory.addAll(list);
  }

  void clearSearchHistory() {
    searchHistory.clear();
    storage.clearSearchHistory();
    Get.back();
  }

  void deleteSelectedSearch(SearchSuggestion selectedSuggestion) {
    for (int i = 0; i < searchHistory.length; i++) {
      final suggestion = searchHistory[i];
      if (suggestion.placeId == selectedSuggestion.placeId) {
        searchHistory.removeAt(i);
      }
    }
    _storeSearchHistory();
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
    final newEntry = searchHistory.removeAt(oldindex);
    searchHistory.insert(index, newEntry);
    _storeSearchHistory();
  }

  void _storeSearchHistory() {
    /// ObjectBox returns list in order of id's. This ensures
    /// that storage returns the list in the order it was at the
    /// time of being stored
    for (int i = 0; i < searchHistory.length; i++) {
      searchHistory[i].id = i + 1;
    }
    storage.storeSearchHistory(searchHistory);
  }
}
