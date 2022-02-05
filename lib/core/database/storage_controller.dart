import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/map_keys/location_map_keys.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  String appDirectoryPath = '';

  final _searchHistory = [];

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage({required String path}) async {
    await Hive.initFlutter(path);

    await Future.wait([
      Hive.openBox(dataMapKey),
      Hive.openBox(LocationMapKeys.local),
      Hive.openBox(appVersionStorageKey),
      Hive.openBox(searchHistoryKey),
      _initLocalPath(),
    ]);
  }

  bool firstTimeUse() => Hive.box(dataMapKey).get(dataMapKey) == null;

  Future<void> _initLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    appDirectoryPath = directory.path;
  }

/* -------------------------------------------------------------------------- */
/*                             APP VERSION STORAGE                            */
/* -------------------------------------------------------------------------- */

  void storeAppVersion({required String appVersion}) {
    Hive.box(appVersionStorageKey).put(appVersionStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      Hive.box(appVersionStorageKey).get(appVersionStorageKey) as String;

/* -------------------------------------------------------------------------- */
/*                                WEATHER DATA                                */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeWeatherData({required Map map}) =>
      Hive.box(dataMapKey).put(dataMapKey, map);

  void storeDayOrNight({required bool isDay}) =>
      Hive.box(dataMapKey).put(isDayKey, isDay);

  void storeLocalIsDay({required bool isDay}) =>
      Hive.box(dataMapKey).put('local_is_day', isDay);

  void storeTimezoneOffset(int offset) =>
      Hive.box(dataMapKey).put(timezoneOffsetKey, offset);

  void storeForecastIsDay({required bool isDay, required int index}) =>
      Hive.box(dataMapKey).put('forecast_is_day:$index', isDay);

  void storeSunsetAndSunriseTimes({
    required DateTime sunset,
    required DateTime sunrise,
  }) {
    Hive.box(dataMapKey).put('sunrise', '$sunrise');
    Hive.box(dataMapKey).put('sunset', '$sunset');
  }

  void storeSunTimeList({required List<Map> sunTimes}) {
    Hive.box(dataMapKey).put('sun_times', sunTimes);
  }

  void storeCurrentLocalCondition({required String condition}) {
    Hive.box(dataMapKey).put('current_local_condition', condition);
  }

  void storeCurrentLocalTemp({required int temp}) {
    Hive.box(dataMapKey).put('current_local_temp', temp);
  }

/* -------------------------- Weather Data Retrieval ------------------------- */

  Map restoreWeatherData() => Hive.box(dataMapKey).get(dataMapKey) as Map;

  Map restoreTodayData() {
    final storedData = Hive.box(dataMapKey).get(dataMapKey) as Map;

    return storedData['timelines'][Timelines.daily]['intervals'][0]['values']
        as Map;
  }

  int? restoreTimezoneOffset() =>
      Hive.box(dataMapKey).get(timezoneOffsetKey) as int? ?? 0;

  bool restoreDayOrNight() =>
      Hive.box(dataMapKey).get(isDayKey) as bool? ?? true;

  bool restoreLocalIsDay() =>
      Hive.box(dataMapKey).get('local_is_day') as bool? ?? true;

  bool restoreForecastIsDay({required int index}) =>
      Hive.box(dataMapKey).get('forecast_is_day:$index') as bool;

  DateTime restoreSunrise() {
    final sunrise = Hive.box(dataMapKey).get('sunrise') as String;
    return DateTime.parse(sunrise);
  }

  DateTime? restoreSunset() {
    if (Hive.box(dataMapKey).get('sunset') != null) {
      return DateTime.parse(Hive.box(dataMapKey).get('sunset') as String);
    } else {
      return null;
    }
  }

  List restoreSunTimeList() =>
      Hive.box(dataMapKey).get('sun_times') as List? ?? [];

  int restoreCurrentLocalTemp() =>
      Hive.box(dataMapKey).get('current_local_temp') as int;

  String restoreCurrentLocalCondition() =>
      Hive.box(dataMapKey).get('current_local_condition') as String;

/* -------------------------------------------------------------------------- */
/*                                LOCATION DATA                               */
/* -------------------------------------------------------------------------- */

  void storeLocalLocationData({required Map map}) {
    Hive.box(LocationMapKeys.local).put(LocationMapKeys.local, map);
  }

  void storeRemoteLocationData({required Map map}) {
    Hive.box(LocationMapKeys.local).put(LocationMapKeys.remote, map);
  }

  Map restoreLocalLocationData() =>
      Hive.box(LocationMapKeys.local).get(LocationMapKeys.local) as Map? ?? {};

  Map restoreRemoteLocationData() =>
      Hive.box(LocationMapKeys.local).get(LocationMapKeys.remote) as Map? ?? {};

/* -------------------------------------------------------------------------- */
/*                                 IMAGE DATA                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map fileList) =>
      Hive.box(dataMapKey).put(imageFileNameListKey, fileList);

  void storeBgImageDynamic({required String path}) =>
      Hive.box(dataMapKey).put(bgImageDynamicKey, path);

  void storeBgImageAppGallery({required String path}) =>
      Hive.box(dataMapKey).put(bgImageAppGalleryKey, path);

  void storeDeviceImagePath(String path) =>
      Hive.box(dataMapKey).put(deviceImagePathKey, path);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map restoreBgImageFileList() =>
      Hive.box(dataMapKey).get(imageFileNameListKey) as Map? ?? {};

  String? restoreDeviceImagePath() =>
      Hive.box(dataMapKey).get(deviceImagePathKey) as String;

  String restoreBgImageDynamic() =>
      Hive.box(dataMapKey).get(bgImageDynamicKey) as String? ?? clearDay1;

  String restoreBgImageAppGallery() =>
      Hive.box(dataMapKey).get(bgImageAppGalleryKey) as String? ?? clearDay1;

/* -------------------------------------------------------------------------- */
/*                                UNIT SETTINGS                               */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Settings Storage ---------------------------- */

  void storeTempUnitMetricSetting({required bool setting}) =>
      Hive.box(appVersionStorageKey).put(tempUnitsCelicusKey, setting);

  void storePrecipInMmSetting({required bool setting}) =>
      Hive.box(appVersionStorageKey).put(precipInMmKey, setting);

  void storeTimeIn24HrsSetting({required bool setting}) =>
      Hive.box(appVersionStorageKey).put(timeIs24HrsKey, setting);

  void storeSpeedInKphSetting({required bool setting}) =>
      Hive.box(appVersionStorageKey).put(speedInKphKey, setting);

  void storeUserImageSettings({
    required bool imageDynamic,
    required bool device,
    required bool appGallery,
  }) {
    Hive.box(appVersionStorageKey).put(bgImageDynamicKey, imageDynamic);
    Hive.box(appVersionStorageKey).put(bgImageFromDeviceKey, device);
    Hive.box(appVersionStorageKey).put(bgImageAppGalleryKey, appGallery);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  bool tempUnitsCelcius() =>
      Hive.box(appVersionStorageKey).get(tempUnitsCelicusKey) as bool? ?? false;

  bool speedInKph() =>
      Hive.box(appVersionStorageKey).get(speedInKphKey) as bool? ?? false;

  bool timeIs24Hrs() =>
      Hive.box(appVersionStorageKey).get(timeIs24HrsKey) as bool? ?? false;

  bool precipInMm() =>
      Hive.box(appVersionStorageKey).get(precipInMmKey) as bool? ?? false;

  bool bgImageDynamic() =>
      Hive.box(appVersionStorageKey).get(bgImageDynamicKey) as bool? ?? true;

  bool bgImageFromAppGallery() =>
      Hive.box(appVersionStorageKey).get(bgImageAppGalleryKey) as bool? ??
      false;

  bool bgImageFromDevice() =>
      Hive.box(appVersionStorageKey).get(bgImageFromDeviceKey) as bool? ??
      false;

/* ------------------------- Search History Storage ------------------------- */

  void storeSearchHistory([RxList? list, SearchSuggestion? suggestion]) {
    _searchHistory.clear();

    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        final suggestion = list[i];
        final placeId = suggestion.placeId;
        final description = suggestion.description;
        final map = {'placeId': placeId, 'description': description};
        _searchHistory.add(map);
      }
      Hive.box(searchHistoryKey).put(searchHistoryKey, _searchHistory);

      if (suggestion != null) {
        _storeLatestSearch(suggestion: suggestion);
      }
    } else {
      Hive.box(searchHistoryKey).delete(searchHistoryKey);
    }
  }

  void _storeLatestSearch({required SearchSuggestion suggestion}) {
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };

    Hive.box(searchHistoryKey).put(mostRecentSearchKey, map);
  }

  void storeLocalOrRemote({required bool searchIsLocal}) =>
      Hive.box(dataMapKey).put(searchIsLocalKey, searchIsLocal);

  String restoreCurrentPlaceId() =>
      Hive.box(dataMapKey).get(placeIdKey) as String? ?? '';

  bool restoreSavedSearchIsLocal() =>
      Hive.box(dataMapKey).get(searchIsLocalKey) as bool? ?? true;

  SearchSuggestion restoreLatestSuggestion() {
    final map = Hive.box(searchHistoryKey).get(mostRecentSearchKey) ?? {};
    final placeId = map['placeId'] as String?;
    final description = map['description'] as String?;
    final suggestion =
        SearchSuggestion(placeId: placeId!, description: description!);
    return suggestion;
  }

/* ------------------------ Search History Retrieval ------------------------ */

  List restoreSearchHistory() {
    final list =
        Hive.box(searchHistoryKey).get(searchHistoryKey) as List? ?? [];
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

/* -------------------------------------------------------------------------- */
/*                               ADAPTIVE LAYOUT                              */
/* -------------------------------------------------------------------------- */

  void storeAdaptiveLayoutValues(Map map) {
    Hive.box(dataMapKey).put('adaptiveLayoutModel', map);
  }

  Map adaptiveLayoutModel() {
    return Hive.box(dataMapKey).get('adaptiveLayoutModel') as Map? ?? {};
  }

  double appBarPadding() =>
      Hive.box(dataMapKey).get('adaptiveLayoutModel')['appBarPadding']
          as double;

  double appBarHeight() =>
      Hive.box(dataMapKey).get('adaptiveLayoutModel')['appBarHeight'] as double;

  double settingsHeaderHeight() =>
      Hive.box(dataMapKey).get('adaptiveLayoutModel')['settingsHeaderHeight']
          as double;

/* -------------------------------------------------------------------------- */
/*                                SESSION TOKEN                               */
/* -------------------------------------------------------------------------- */

  void storeSessionToken({required String token}) =>
      Hive.box(appVersionStorageKey).put('session_token', token);

  String restoreSessionToken() =>
      Hive.box(appVersionStorageKey).get('session_token') as String;

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchList() => Hive.box(searchHistoryKey).clear();

  @visibleForTesting
  Future<void> clearAllStorage() async {
    Hive.box(searchHistoryKey).clear();
    Hive.box(LocationMapKeys.local).clear();
    Hive.box(dataMapKey).clear();
    Hive.box(appVersionStorageKey).clear();
    Hive.deleteFromDisk();
  }
}
