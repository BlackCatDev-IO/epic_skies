import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final locationBox = GetStorage(locationMapKey);
  final dataBox = GetStorage(dataMapKey);
  final recentSearchesBox = GetStorage(recentSearchesKey);

  Map<String, dynamic> dataMap = {};
  Map<String, dynamic> recentSearchesList = {};

  void storeWeatherData({@required Map<String, dynamic> map}) {
    dataMap.addAll(map);
    dataBox.write(dataMapKey, map);
  }

  void storeLocationData({@required Map<String, dynamic> map}) {
    locationBox.write(locationMapKey, map);
  }

  void storeLatestSearch({@required SearchSuggestion suggestion}) {
    final total = recentSearchesList.length;
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };
    recentSearchesList[total.toString()] = map;
    recentSearchesBox.write(recentSearchesKey, recentSearchesList);
    recentSearchesBox.write(mostRecentSearchKey, map);
    dataBox.write(searchIsLocalKey, false);
    dataBox.write(placeIdKey, suggestion.placeId);
  }

  void clearSearchList() {
    recentSearchesBox.erase();
    debugPrint('FAh Q');
  }

  SearchSuggestion restoreLatestSuggestion() {
    final map = recentSearchesBox.read(mostRecentSearchKey);
    final placeId = map['placeId'];
    final description = map['description'];
    final suggestion =
        SearchSuggestion(placeId: placeId, description: description);
    return suggestion;
  }

  Map restoreRecentSearchMap() => recentSearchesBox.read(recentSearchesKey);

  Future<void> initDataMap() async => dataMap.addAll(dataBox.read(dataMapKey));

  String restoreCurrentPlaceId() => dataBox.read(placeIdKey);

  Map<String, dynamic> restoreLocationData() =>
      locationBox.read(locationMapKey);

  void storeLocalOrRemote({@required bool searchIsLocal}) =>
      dataBox.write(searchIsLocalKey, searchIsLocal);

  void storeBgImage(String path) => dataBox.write(backgroundImageKey, path);

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey);

  bool dataBoxIsNull() => dataBox.read(dataMapKey) == null;

  String storedImage() => dataBox.read(backgroundImageKey);

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }
}
