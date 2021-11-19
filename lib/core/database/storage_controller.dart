import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/map_keys/location_map_keys.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  final _locationBox = GetStorage(LocationMapKeys.localLocation);
  final _dataBox = GetStorage(dataMapKey);
  final _searchHistoryBox = GetStorage(searchHistoryKey);
  final _appVersionBox = GetStorage(appVersionStorageKey);

  String appDirectoryPath = '';

  Map settingsMap = {};

  final _searchHistory = [];

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage() async {
    await Future.wait([
      GetStorage.init(dataMapKey),
      GetStorage.init(LocationMapKeys.localLocation),
      GetStorage.init(searchHistoryKey),
      GetStorage.init(appVersionStorageKey),
      _initLocalPath(),
    ]);
    _restoreSettingsMap();
  }

  bool firstTimeUse() => _dataBox.read(dataMapKey) == null;

  Future<void> _initLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();

    appDirectoryPath = directory.path;
  }

/* -------------------------------------------------------------------------- */
/*                             APP VERSION STORAGE                            */
/* -------------------------------------------------------------------------- */

  void storeAppVersion({required String appVersion}) {
    _appVersionBox.write(appVersionStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      _appVersionBox.read(appVersionStorageKey) as String;

/* -------------------------------------------------------------------------- */
/*                                WEATHER DATA                                */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeWeatherData({required Map map}) => _dataBox.write(dataMapKey, map);

  Map<String, dynamic> restoreWeatherData() =>
      _dataBox.read(dataMapKey) as Map<String, dynamic>;

  Map<String, dynamic> restoreTodayData() {
    final storedData = _dataBox.read(dataMapKey) as Map<String, dynamic>;

    return storedData['timelines'][Timelines.daily]['intervals'][0]['values']
        as Map<String, dynamic>;
  }

  void storeDayOrNight({bool? isDay}) => _dataBox.write(isDayKey, isDay);

  void storeTimezoneOffset(int offset) =>
      _dataBox.write(timezoneOffsetKey, offset);

  void storeForecastIsDay({required bool isDay, required int index}) =>
      _dataBox.write('forecast_is_day:$index', isDay);

  void storeSunsetAndSunriseTimes({
    required DateTime sunset,
    required DateTime sunrise,
  }) {
    _dataBox.write('sunrise', '$sunrise');
    _dataBox.write('sunset', '$sunset');
  }

  void storeSunTimeList({required List<Map<String, dynamic>> sunTimes}) {
    _dataBox.write('sun_times', sunTimes);
  }

/* -------------------------- Weather Data Retrieval ------------------------- */

  int? restoreTimezoneOffset() => _dataBox.read(timezoneOffsetKey);

  bool? restoreDayOrNight() => _dataBox.read(isDayKey) ?? true;

  bool restoreForecastIsDay({required int index}) =>
      _dataBox.read('forecast_is_day:$index') as bool;

  DateTime restoreSunrise() {
    final sunrise = _dataBox.read('sunrise') as String;
    return DateTime.parse(sunrise);
  }

  DateTime? restoreSunset() {
    if (_dataBox.read('sunset') != null) {
      return DateTime.parse(_dataBox.read('sunset') as String);
    } else {
      return null;
    }
  }

  List restoreSunTimeList() => _dataBox.read('sun_times') as List? ?? [];

/* -------------------------------------------------------------------------- */
/*                                LOCATION DATA                               */
/* -------------------------------------------------------------------------- */

  void storeLocalLocationData({required Map<String, dynamic> map}) {
    _locationBox.write(LocationMapKeys.localLocation, map);
  }

  void storeRemoteLocationData({required Map<String, dynamic> map}) {
    _locationBox.write(LocationMapKeys.remoteLocation, map);
  }

  Map<String, dynamic> restoreLocalLocationData() =>
      _locationBox.read(LocationMapKeys.localLocation) ?? {};

  Map<String, dynamic> restoreRemoteLocationData() =>
      _locationBox.read(LocationMapKeys.remoteLocation) ?? {};

/* -------------------------------------------------------------------------- */
/*                                 IMAGE DATA                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      _dataBox.write(imageFileNameListKey, fileList);

  void storeBgImageDynamic({required String path}) =>
      _dataBox.write(bgImageDynamicKey, path);

  void storeBgImageAppGallery({required String path}) =>
      _dataBox.write(bgImageAppGalleryKey, path);

  void storeDeviceImagePath(String path) =>
      _dataBox.write(deviceImagePathKey, path);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map<String, dynamic> restoreBgImageFileList() =>
      _dataBox.read(imageFileNameListKey) ?? {};

  String? restoreDeviceImagePath() => _dataBox.read(deviceImagePathKey);

  String restoreBgImageDynamic() =>
      _dataBox.read(bgImageDynamicKey) ?? clearDay1;

  String restoreBgImageAppGallery() =>
      _dataBox.read(bgImageAppGalleryKey) ?? clearDay1;

/* -------------------------------------------------------------------------- */
/*                                UNIT SETTINGS                               */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Settings Storage ---------------------------- */

  void storeTempUnitMetricSetting({required bool setting}) {
    settingsMap[tempUnitsMetricKey] = setting;
    _dataBox.write(settingsMapKey, settingsMap);
  }

  void storePrecipInMmSetting({required bool setting}) {
    settingsMap[precipInMmKey] = setting;
    _dataBox.write(settingsMapKey, settingsMap);
  }

  void storeTimeIn24HrsSetting({required bool setting}) {
    settingsMap[timeIs24HrsKey] = setting;
    _dataBox.write(settingsMapKey, settingsMap);
  }

  void storeSpeedInKphSetting({required bool setting}) {
    settingsMap[speedInKphKey] = setting;
    _dataBox.write(settingsMapKey, settingsMap);
  }

  void storeUserImageSettings({
    required bool imageDynamic,
    required bool device,
    required bool appGallery,
  }) {
    final map = {
      'dynamic': imageDynamic,
      'device': device,
      'app_gallery': appGallery
    };
    _dataBox.write(imageSettingKey, map);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  Map restoreUserImageSetting() => _dataBox.read(imageSettingKey) ?? {};

  void _restoreSettingsMap() {
    if (_dataBox.read(settingsMapKey) == null) {
      settingsMap = {
        tempUnitsMetricKey: false,
        precipInMmKey: false,
        timeIs24HrsKey: false,
        speedInKphKey: false
      };
      _dataBox.write(settingsMapKey, settingsMap);
    } else {
      settingsMap = _dataBox.read(settingsMapKey) as Map;
    }
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
    _searchHistory.clear();

    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        final suggestion = list[i];
        final placeId = suggestion.placeId;
        final description = suggestion.description;
        final map = {'placeId': placeId, 'description': description};
        _searchHistory.add(map);
      }
      _searchHistoryBox.write(searchHistoryKey, _searchHistory);

      if (suggestion != null) {
        _storeLatestSearch(suggestion: suggestion);
      }
    } else {
      _searchHistoryBox.remove(searchHistoryKey);
    }
  }

  void _storeLatestSearch({required SearchSuggestion suggestion}) {
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };

    _searchHistoryBox.write(mostRecentSearchKey, map);
  }

  void storeLocalOrRemote({required bool searchIsLocal}) =>
      _dataBox.write(searchIsLocalKey, searchIsLocal);

  String restoreCurrentPlaceId() => _dataBox.read(placeIdKey) ?? '';

  bool restoreSavedSearchIsLocal() => _dataBox.read(searchIsLocalKey) ?? true;

  SearchSuggestion restoreLatestSuggestion() {
    final map = _searchHistoryBox.read(mostRecentSearchKey) ?? {};
    final placeId = map['placeId'] as String?;
    final description = map['description'] as String?;
    final suggestion =
        SearchSuggestion(placeId: placeId!, description: description!);
    return suggestion;
  }

/* ------------------------ Search History Retrieval ------------------------ */

  List restoreSearchHistory() {
    final list = _searchHistoryBox.read(searchHistoryKey) as List? ?? [];
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
    _dataBox.write('adaptiveLayoutModel', map);
  }

  Map adaptiveLayoutModel() {
    return _dataBox.read('adaptiveLayoutModel') ?? {};
  }

  double appBarPadding() =>
      _dataBox.read('adaptiveLayoutModel')['appBarPadding'] as double;

  double appBarHeight() =>
      _dataBox.read('adaptiveLayoutModel')['appBarHeight'] as double;

  double settingsHeaderHeight() =>
      _dataBox.read('adaptiveLayoutModel')['settingsHeaderHeight'] as double;

/* -------------------------------------------------------------------------- */
/*                                SESSION TOKEN                               */
/* -------------------------------------------------------------------------- */

  void storeSessionToken({required String token}) =>
      _dataBox.write('session_token', token);

  String restoreSessionToken() => _dataBox.read('session_token') as String;

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchList() => _searchHistoryBox.erase();

  void clearAllStorage() {
    _locationBox.erase();
    _dataBox.erase();
  }
}
