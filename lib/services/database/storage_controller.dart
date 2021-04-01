
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  final locationBox = GetStorage(localLocationKey);
  final dataBox = GetStorage(dataMapKey);
  final searchHistoryBox = GetStorage(searchHistoryKey);

  String appDirectoryPath = '';

  Map dataMap = {};
  List searchHistory = [];

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage() async {
    await Future.wait([
      GetStorage.init(dataMapKey),
      GetStorage.init(localLocationKey),
      GetStorage.init(searchHistoryKey),
      _initLocalPath(),
    ]);
    dataMap.addAll(dataBox.read(dataMapKey) ?? {});
  }

  bool firstTimeUse() => dataBox.read(dataMapKey) == null;

  Future<void> _initLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    appDirectoryPath = directory.path;
  }

/* -------------------------------------------------------------------------- */
/*                              STORING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void updateDatamapStorage() => dataBox.write(dataMapKey, dataMap);

  void storeLocalLocationData({@required Map<String, dynamic> map}) {
    locationBox.write(localLocationKey, map);
  }

  void storeRemoteLocationData({@required Map<String, dynamic> map}) {
    locationBox.write(remoteLocationKey, map);
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

  void storeDayOrNight({bool isDay}) => dataBox.write(isDayKey, isDay);

  void storeTimezoneOffset(int offset) =>
      dataBox.write(timezoneOffsetKey, offset);

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      dataBox.write(imageFileNameListKey, fileList);

  void storeBgImageDynamic({@required String path}) =>
      dataBox.write(bgImageDynamicKey, path);

  void storeBgImageAppGallery({@required String path}) =>
      dataBox.write(bgImageAppGalleryKey, path);

  void storeDeviceImagePath(String path) =>
      dataBox.write(deviceImagePathKey, path);

/* ---------------------------- Settings Storage ---------------------------- */

  void storeTempUnitSetting({bool setting}) =>
      dataBox.write(tempUnitsMetricKey, setting);

  void storePrecipUnitSetting({bool setting}) =>
      dataBox.write(precipUnitKey, setting);

  void storeTimeFormatSetting({bool setting}) =>
      dataBox.write(timeFormatKey, setting);

  void storeSpeedUnitSetting({bool setting}) =>
      dataBox.write(speedUnitKey, setting);

  void storeUserImageSettings(
      {@required bool imageDynamic,
      @required bool device,
      @required bool appGallery}) {
    final map = {
      'dynamic': imageDynamic,
      'device': device,
      'app_gallery': appGallery
    };
    dataBox.write(imageSettingKey, map);
  }

/* ------------------------- Search History Storage ------------------------- */

  void storeSearchHistory(RxList list, [SearchSuggestion suggestion]) {
    searchHistory.clear();
    for (int i = 0; i < list.length; i++) {
      final suggestion = list[i];
      final placeId = suggestion.placeId;
      final description = suggestion.description;
      final map = {'placeId': placeId, 'description': description};
      searchHistory.add(map);
    }
    searchHistoryBox.write(searchHistoryKey, searchHistory);

    if (suggestion != null) {
      _storeLatestSearch(suggestion: suggestion);
    }
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

/* -------------------------------------------------------------------------- */
/*                             RETRIEVAL FUNCTIONS                            */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Retrieval ------------------------- */

  Map<String, dynamic> restoreLocalLocationData() =>
      locationBox.read(localLocationKey) ?? {};

  Map<String, dynamic> restoreRemoteLocationData() =>
      locationBox.read(remoteLocationKey) ?? {};

  int restoreTimezoneOffset() => dataBox.read(timezoneOffsetKey);

  bool restoreDayOrNight() => dataBox.read(isDayKey);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map<String, dynamic> restoreBgImageFileList() =>
      dataBox.read(imageFileNameListKey);

  String restoreDeviceImagePath() => dataBox.read(deviceImagePathKey);

  String restoreBgImageDynamic() =>
      dataBox.read(bgImageDynamicKey) ?? clearDay1;

  String restoreBgImageAppGallery() =>
      dataBox.read(bgImageAppGalleryKey) ?? clearDay1;

/* --------------------------- Settings Retrieval --------------------------- */

  bool restoreTempUnitSetting() => dataBox.read(tempUnitsMetricKey) ?? false;

  bool restorePrecipUnitSetting() => dataBox.read(precipUnitKey) ?? false;

  bool restoreTimeFormatSetting() => dataBox.read(timeFormatKey) ?? false;

  bool restoreSpeedUnitSetting() => dataBox.read(speedUnitKey) ?? false;

  Map restoreUserImageSetting() => dataBox.read(imageSettingKey) ?? {};

/* ------------------------ Search History Retrieval ------------------------ */

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

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey) ?? true;

  SearchSuggestion restoreLatestSuggestion() {
    final map = searchHistoryBox.read(mostRecentSearchKey) ?? {};
    final placeId = map['placeId'] as String;
    final description = map['description'] as String;
    final suggestion =
        SearchSuggestion(placeId: placeId, description: description);
    return suggestion;
  }

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchList() => searchHistoryBox.erase();

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }
}
