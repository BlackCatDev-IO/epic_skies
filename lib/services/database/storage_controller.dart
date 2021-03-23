import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  final locationBox = GetStorage(locationMapKey);
  final dataBox = GetStorage(dataMapKey);
  final recentSearchesBox = GetStorage(recentSearchesKey);

  Map dataMap = {};
  Map recentSearchesList = {};

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

  Future<void> _initSearchBox() async => GetStorage.init(recentSearchesKey);

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

  Map restoreRecentSearchMap() => recentSearchesBox.read(recentSearchesKey);

  String restoreCurrentPlaceId() => dataBox.read(placeIdKey);

  Map<String, dynamic> restoreLocationData() =>
      locationBox.read(locationMapKey);

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey) ?? true;

  bool firstTimeUse() => dataBox.read(dataMapKey) == null;

  String storedImage() => dataBox.read(backgroundImageKey) ?? clearDay1;

  bool restoreTempUnitSetting() => dataBox.read(tempUnitsMetricKey) ?? false;

  bool restorePrecipUnitSetting() => dataBox.read(precipUnitKey) ?? false;

  bool restoreTimeFormatSetting() => dataBox.read(timeFormatKey) ?? false;

  bool restoreSpeedUnitSetting() => dataBox.read(speedUnitKey) ?? false;

  SearchSuggestion restoreLatestSuggestion() {
    final map = recentSearchesBox.read(mostRecentSearchKey);
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

  void clearSearchList() => recentSearchesBox.erase();

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }
}
