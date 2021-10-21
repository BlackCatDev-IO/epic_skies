import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  final locationBox = GetStorage(localLocationKey);
  final dataBox = GetStorage(dataMapKey);
  final searchHistoryBox = GetStorage(searchHistoryKey);
  final appVersionBox = GetStorage(appVersionStorageKey);

  String appDirectoryPath = '';

  Map dataMap = {};
  Map settingsMap = {};
  List searchHistory = [];

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage() async {
    await Future.wait([
      GetStorage.init(dataMapKey),
      GetStorage.init(localLocationKey),
      GetStorage.init(searchHistoryKey),
      GetStorage.init(appVersionStorageKey),
      _initLocalPath(),
    ]);
    _restoreSettingsMap();
    dataMap.addAll(dataBox.read(dataMapKey) ?? {});
  }

  bool firstTimeUse() => dataBox.read(dataMapKey) == null;

  Future<void> _initLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    appDirectoryPath = directory.path;
  }

  /* -------------------------------------------------------------------------- */
  /*                             APP VERSION STORAGE                            */
  /* -------------------------------------------------------------------------- */

  void storeAppVersion({required String appVersion}) {
    appVersionBox.write(appVersionStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      appVersionBox.read(appVersionStorageKey) as String;

/* -------------------------------------------------------------------------- */
/*                              STORING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeLocalLocationData({required Map<String, dynamic> map}) {
    locationBox.write(localLocationKey, map);
  }

  void storeRemoteLocationData({required Map<String, dynamic> map}) {
    locationBox.write(remoteLocationKey, map);
  }

  void storeWeatherData({required Map map}) {
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

  void storeDayOrNight({bool? isDay}) => dataBox.write(isDayKey, isDay);

  void storeTimezoneOffset(int offset) =>
      dataBox.write(timezoneOffsetKey, offset);

  void storeForecastIsDay({required bool isDay, required int index}) =>
      dataBox.write('forecast_is_day:$index', isDay);

  void storeSunsetAndSunriseTimes(
      {required DateTime sunset, required DateTime sunrise}) {
    dataBox.write('sunrise', '$sunrise');
    dataBox.write('sunset', '$sunset');
  }

  void storeSunTimeList({required List<Map<String, dynamic>> sunTimes}) {
    dataBox.write('sun_times', sunTimes);
  }

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      dataBox.write(imageFileNameListKey, fileList);

  void storeBgImageDynamic({required String path}) =>
      dataBox.write(bgImageDynamicKey, path);

  void storeBgImageAppGallery({required String path}) =>
      dataBox.write(bgImageAppGalleryKey, path);

  void storeDeviceImagePath(String path) =>
      dataBox.write(deviceImagePathKey, path);

/* ---------------------------- Settings Storage ---------------------------- */

  void storeTempUnitSetting({required bool setting}) {
    settingsMap[tempUnitsMetricKey] = setting;
    dataBox.write(settingsMapKey, settingsMap);
  }

  void storePrecipUnitSetting({required bool setting}) {
    settingsMap[precipInMmKey] = setting;
    dataBox.write(settingsMapKey, settingsMap);
  }

  void storeTimeFormatSetting({required bool setting}) {
    settingsMap[timeIs24HrsKey] = setting;
    dataBox.write(settingsMapKey, settingsMap);
  }

  void storeSpeedUnitSetting({required bool setting}) {
    settingsMap[speedInKphKey] = setting;
    dataBox.write(settingsMapKey, settingsMap);
  }

  void storeUserImageSettings(
      {required bool imageDynamic,
      required bool device,
      required bool appGallery}) {
    final map = {
      'dynamic': imageDynamic,
      'device': device,
      'app_gallery': appGallery
    };
    dataBox.write(imageSettingKey, map);
  }

  String tempUnitString() {
    final bool tempUnitsMetric = settingsMap[tempUnitsMetricKey] as bool;
    return tempUnitsMetric ? 'C' : 'F';
  }

  String precipUnitString() {
    final bool precipUnitsMetric = settingsMap[precipInMmKey] as bool;
    return precipUnitsMetric ? 'mm' : 'in';
  }

  String speedUnitString() {
    final bool speedUnitsMetric = settingsMap[speedInKphKey] as bool;
    return speedUnitsMetric ? 'kph' : 'mph';
  }

/* ------------------------- Search History Storage ------------------------- */

  void storeSearchHistory([RxList? list, SearchSuggestion? suggestion]) {
    searchHistory.clear();

    if (list != null) {
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
    } else {
      searchHistoryBox.remove(searchHistoryKey);
    }
  }

  void _storeLatestSearch({required SearchSuggestion suggestion}) {
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };

    searchHistoryBox.write(mostRecentSearchKey, map);
  }

  void storeLocalOrRemote({required bool searchIsLocal}) =>
      dataBox.write(searchIsLocalKey, searchIsLocal);

/* -------------------------------------------------------------------------- */
/*                             RETRIEVAL FUNCTIONS                            */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Retrieval ------------------------- */

  Map<String, dynamic> restoreLocalLocationData() =>
      locationBox.read(localLocationKey) ?? {};

  Map<String, dynamic> restoreRemoteLocationData() =>
      locationBox.read(remoteLocationKey) ?? {};

  int? restoreTimezoneOffset() => dataBox.read(timezoneOffsetKey);

  bool? restoreDayOrNight() => dataBox.read(isDayKey) ?? true;

  bool restoreForecastIsDay({required int index}) =>
      dataBox.read('forecast_is_day:$index') as bool;

  DateTime restoreSunrise() {
    final sunrise = dataBox.read('sunrise') as String;
    return DateTime.parse(sunrise);
  }

  DateTime? restoreSunset() {
    if (dataBox.read('sunset') != null) {
      return DateTime.parse(dataBox.read('sunset') as String);
    } else {
      return null;
    }
  }

  List restoreSunTimeList() => dataBox.read('sun_times') as List? ?? [];

/* ---------------------------- Image Retrieival ---------------------------- */

  Map<String, dynamic> restoreBgImageFileList() =>
      dataBox.read(imageFileNameListKey) ?? {};

  String? restoreDeviceImagePath() => dataBox.read(deviceImagePathKey);

  String restoreBgImageDynamic() =>
      dataBox.read(bgImageDynamicKey) ?? clearDay1;

  String restoreBgImageAppGallery() =>
      dataBox.read(bgImageAppGalleryKey) ?? clearDay1;

/* --------------------------- Settings Retrieval --------------------------- */

  Map restoreUserImageSetting() => dataBox.read(imageSettingKey) ?? {};

  void _restoreSettingsMap() {
    if (dataBox.read(settingsMapKey) == null) {
      settingsMap = {
        tempUnitsMetricKey: false,
        precipInMmKey: false,
        timeIs24HrsKey: false,
        speedInKphKey: false
      };
      dataBox.write(settingsMapKey, settingsMap);
    } else {
      settingsMap = dataBox.read(settingsMapKey) as Map;
    }
  }

/* ------------------------ Search History Retrieval ------------------------ */

  List restoreSearchHistory() {
    final list = searchHistoryBox.read(searchHistoryKey) as List? ?? [];
    final restoreList = [];

    if (list != []) {
      for (int i = 0; i < list.length; i++) {
        final map = list[i] as Map;
        final placeId = map['placeId'] as String?;
        final description = map['description'] as String?;
        final suggestion =
            SearchSuggestion(placeId: placeId!, description: description!);
        restoreList.add(suggestion);
      }
    }
    return restoreList;
  }

  String restoreCurrentPlaceId() => dataBox.read(placeIdKey) ?? '';

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey) ?? true;

  SearchSuggestion restoreLatestSuggestion() {
    final map = searchHistoryBox.read(mostRecentSearchKey) ?? {};
    final placeId = map['placeId'] as String?;
    final description = map['description'] as String?;
    final suggestion =
        SearchSuggestion(placeId: placeId!, description: description!);
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
