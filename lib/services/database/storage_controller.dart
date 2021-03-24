import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  final locationBox = GetStorage(locationMapKey);
  final dataBox = GetStorage(dataMapKey);
  final searchHistoryBox = GetStorage(searchHistoryKey);

  Map dataMap = {};
  List searchHistory = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.wait([
      _initDataBox(),
      _initLocationBox(),
      _initSearchBox(),
    ]);
  }

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> _initDataBox() async => GetStorage.init(dataMapKey);

  Future<void> _initLocationBox() async => GetStorage.init(locationMapKey);

  Future<void> _initSearchBox() async => GetStorage.init(searchHistoryKey);

  Future<void> initDataMap() async => dataMap.addAll(dataBox.read(dataMapKey));

/* -------------------------------------------------------------------------- */
/*                              STORING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void updateDatamapStorage() => dataBox.write(dataMapKey, dataMap);

  void storeLocationData({@required Map<String, dynamic> map}) {
    locationBox.write(locationMapKey, map);
  }

  void storeWeatherData({@required Map map}) {
    dataMap.addAll(map);
    dataBox.write(dataMapKey, map);
  }

  void storeUpdatedCurrentTempValues(int currentTemp, int feelsLike) {
    dataMap['timelines'][2]['intervals'][0]['values']['temperature'] =
        currentTemp;
    dataMap['timelines'][2]['intervals'][0]['values']['temperatureApparent'] =
        feelsLike;
    dataBox.write(dataMapKey, dataMap);
  }

  void storeSearchHistory(RxList list, SearchSuggestion suggestion) {
    searchHistory.clear();
    for (int i = 0; i < list.length; i++) {
      final suggestion = list[i];
      final placeId = suggestion.placeId;
      final description = suggestion.description;
      final map = {'placeId': placeId, 'description': description};
      searchHistory.add(map);
    }
    searchHistoryBox.write(searchHistoryKey, searchHistory);

    _storeLatestSearch(suggestion: suggestion);
  }

  void _storeLatestSearch({@required SearchSuggestion suggestion}) {
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };

    searchHistoryBox.write(mostRecentSearchKey, map);
  }

  void storeLocalOrRemote({@required bool searchIsLocal}) =>
      dataBox.write(searchIsLocalKey, searchIsLocal);

  void storeBgImage({@required String path}) =>
      dataBox.write(backgroundImageKey, path);

  void storeTempUnitSetting({bool setting}) =>
      dataBox.write(tempUnitsMetricKey, setting);

  void storePrecipUnitSetting({bool setting}) =>
      dataBox.write(precipUnitKey, setting);

  void storeTimeFormatSetting({bool setting}) =>
      dataBox.write(timeFormatKey, setting);

  void storeSpeedUnitSetting({bool setting}) =>
      dataBox.write(speedUnitKey, setting);

  void storeDayOrNight({bool isDay}) => dataBox.write(isDayKey, isDay);

  void storeTimezoneOffset(int offset) =>
      dataBox.write(timezoneOffsetKey, offset);

/* -------------------------------------------------------------------------- */
/*                             RETREIVAL FUNCTIONS                            */
/* -------------------------------------------------------------------------- */

  List restoreSearchHistory() {
    final list = searchHistoryBox.read(searchHistoryKey) as List ?? [];
    final restoreList = [];

    if (list != []) {
      for (int i = 0; i < list.length; i++) {
        final map = list[i] as Map;
        final placeId = map['placeId'] as String;
        final description = map['description'] as String;
        final suggestion =
            SearchSuggestion(placeId: placeId, description: description);
        restoreList.add(suggestion);
      }
    }
    return restoreList;
  }

  String restoreCurrentPlaceId() => dataBox.read(placeIdKey) ?? '';

  Map<String, dynamic> restoreLocationData() =>
      locationBox.read(locationMapKey) ?? {};

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey) ?? true;

  bool firstTimeUse() => dataBox.read(dataMapKey) == null;

  String storedImage() => dataBox.read(backgroundImageKey) ?? clearDay1;

  bool restoreTempUnitSetting() => dataBox.read(tempUnitsMetricKey) ?? false;

  bool restorePrecipUnitSetting() => dataBox.read(precipUnitKey) ?? false;

  bool restoreTimeFormatSetting() => dataBox.read(timeFormatKey) ?? false;

  bool restoreSpeedUnitSetting() => dataBox.read(speedUnitKey) ?? false;

  SearchSuggestion restoreLatestSuggestion() {
    final map = searchHistoryBox.read(mostRecentSearchKey) ?? {};
    final placeId = map['placeId'] as String;
    final description = map['description'] as String;
    final suggestion =
        SearchSuggestion(placeId: placeId, description: description);
    return suggestion;
  }

  bool restoreDayOrNight() => dataBox.read(isDayKey);

  int restoreTimezoneOffset() => dataBox.read(timezoneOffsetKey);

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchList() => searchHistoryBox.erase();

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }
}
