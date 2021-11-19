import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/models/location_models/remote_location_model.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:get/get.dart';

class RemoteLocationController extends GetxController {
  static RemoteLocationController get to => Get.find();

  RxList searchHistory = [].obs;
  RxList currentSearchList = [].obs;

  late RemoteLocationModel locationData;

  @override
  void onInit() {
    super.onInit();
    final firstTimeUse = StorageController.to.firstTimeUse();
    if (!firstTimeUse) {
      _initLocationDataFromStorage();
    }
    _restoreSearchHistory();
  }

  Future<void> initRemoteLocationData({
    required Map data,
    required SearchSuggestion suggestion,
  }) async {
    locationData = RemoteLocationModel.fromMap(
      map: data as Map<String, dynamic>,
      suggestion: suggestion,
    );

    log('searchCity character length: ${locationData.city.length}');

    log(
      'City:${locationData.city} \nState:${locationData.state}  \nCountry:${locationData.country} ',
      name: 'LocationController',
    );

    update();
    _storeRemoteLocationData();
  }

  void updateAndStoreSearchHistory(SearchSuggestion suggestion) {
    searchHistory.removeWhere((value) => value == null);
    searchHistory.insert(0, suggestion);
    _removeDuplicates();
    StorageController.to.storeSearchHistory(searchHistory, suggestion);
  }

  void _restoreSearchHistory() {
    final RxList list = StorageController.to.restoreSearchHistory().obs;
    searchHistory.addAll(list);
  }

  void clearSearchHistory() {
    searchHistory.clear();
    StorageController.to.storeSearchHistory();
    Get.back();
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
    SearchSuggestion? duplicate;
    for (int i = 0; i < searchHistory.length; i++) {
      duplicate = searchHistory[i] as SearchSuggestion?;
      for (int j = 0; j < searchHistory.length; j++) {
        final suggestion = searchHistory[j] as SearchSuggestion;
        if (suggestion.placeId == duplicate!.placeId && i != j) {
          searchHistory.removeAt(j);
        }
      }
    }
  }

  void _storeRemoteLocationData() {
    StorageController.to.storeRemoteLocationData(map: locationData.toMap());
  }

  void _initLocationDataFromStorage() {
    locationData = RemoteLocationModel.fromStorage(
      StorageController.to.restoreRemoteLocationData(),
    );
    update();
  }
}
