import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/map_keys/location_map_keys.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';
import '../../services/settings/unit_settings/unit_settings_model.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  late Store store;
  late Box unitSettingsBox;

  final _locationBox = GetStorage(LocationMapKeys.local);
  final _dataBox = GetStorage(dataMapKey);
  final _searchHistoryBox = GetStorage(searchHistoryKey);
  final _appUtilsBox = GetStorage(appVersionStorageKey);

  String appDirectoryPath = '';

  final _searchHistory = [];

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage({String? path}) async {
    store = await openStore();
    unitSettingsBox = store.box<UnitSettings>();

    await Future.wait([
      GetStorage.init(dataMapKey),
      GetStorage.init(LocationMapKeys.local),
      GetStorage.init(searchHistoryKey),
      GetStorage.init(appVersionStorageKey),
      _initLocalPath(),
    ]);
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
    _appUtilsBox.write(appVersionStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      _appUtilsBox.read(appVersionStorageKey) as String;

/* -------------------------------------------------------------------------- */
/*                                WEATHER DATA                                */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeWeatherData({required Map map}) => _dataBox.write(dataMapKey, map);

  void storeDayOrNight({required bool isDay}) =>
      _dataBox.write(isDayKey, isDay);

  void storeLocalIsDay({required bool isDay}) =>
      _dataBox.write('local_is_day', isDay);

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

  void storeCurrentLocalCondition({required String condition}) {
    _dataBox.write('current_local_condition', condition);
  }

  void storeCurrentLocalTemp({required int temp}) {
    _dataBox.write('current_local_temp', temp);
  }

/* -------------------------- Weather Data Retrieval ------------------------- */

  Map<String, dynamic> restoreWeatherData() =>
      _dataBox.read(dataMapKey) as Map<String, dynamic>;

  Map<String, dynamic> restoreTodayData() {
    final storedData = _dataBox.read(dataMapKey) as Map<String, dynamic>;

    final dailyTimeline = (storedData['timelines'] as List)[Timelines.daily]
        as Map<String, dynamic>;

    final intervalList =
        (dailyTimeline['intervals'] as List)[0] as Map<String, dynamic>;

    return intervalList['values'] as Map<String, dynamic>;
  }

  int? restoreTimezoneOffset() => _dataBox.read(timezoneOffsetKey);

  bool restoreDayOrNight() => _dataBox.read(isDayKey) ?? true;

  bool restoreLocalIsDay() => _dataBox.read('local_is_day') ?? true;

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

  int restoreCurrentLocalTemp() => _dataBox.read('current_local_temp') as int;

  String restoreCurrentLocalCondition() =>
      _dataBox.read('current_local_condition') as String;

/* -------------------------------------------------------------------------- */
/*                                LOCATION DATA                               */
/* -------------------------------------------------------------------------- */

  void storeLocalLocationData({required Map<String, dynamic> map}) {
    _locationBox.write(LocationMapKeys.local, map);
  }

  void storeRemoteLocationData({required Map<String, dynamic> map}) {
    _locationBox.write(LocationMapKeys.remote, map);
  }

  Map<String, dynamic> restoreLocalLocationData() =>
      _locationBox.read(LocationMapKeys.local) ?? {};

  Map<String, dynamic> restoreRemoteLocationData() =>
      _locationBox.read(LocationMapKeys.remote) ?? {};

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

  void storeUnitSettings({
    required UnitSettings settings,
  }) {
    unitSettingsBox.put(settings);
  }

  void storeUserImageSettings({
    required bool imageDynamic,
    required bool device,
    required bool appGallery,
  }) {
    _appUtilsBox.write(bgImageDynamicKey, imageDynamic);
    _appUtilsBox.write(bgImageFromDeviceKey, device);
    _appUtilsBox.write(bgImageAppGalleryKey, appGallery);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  UnitSettings savedUnitSettings() {
    return unitSettingsBox.get(1) as UnitSettings;
  }

  bool bgImageDynamic() =>
      _appUtilsBox.read(bgImageDynamicKey) as bool? ?? true;

  bool bgImageFromAppGallery() =>
      _appUtilsBox.read(bgImageAppGalleryKey) as bool? ?? false;

  bool bgImageFromDevice() =>
      _appUtilsBox.read(bgImageFromDeviceKey) as bool? ?? false;

/* ------------------------- Search History Storage ------------------------- */

  void storeSearchHistory([
    RxList<SearchSuggestion>? list,
    SearchSuggestion? suggestion,
  ]) {
    _searchHistory.clear();

    if (list != null) {
      for (final SearchSuggestion suggestion in list) {
        final map = {
          'placeId': suggestion.placeId,
          'description': suggestion.description
        };
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
    final map = _searchHistoryBox.read(mostRecentSearchKey) as Map? ?? {};
    final placeId = map['placeId'] as String?;
    final description = map['description'] as String?;
    final suggestion =
        SearchSuggestion(placeId: placeId!, description: description!);
    return suggestion;
  }

/* ------------------------ Search History Retrieval ------------------------ */

  List<SearchSuggestion> restoreSearchHistory() {
    final list = _searchHistoryBox.read(searchHistoryKey) as List? ?? [];
    final restoreList = <SearchSuggestion>[];

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
      (_dataBox.read('adaptiveLayoutModel') as Map)['appBarPadding'] as double;

  double appBarHeight() =>
      (_dataBox.read('adaptiveLayoutModel') as Map)['appBarHeight'] as double;

  double settingsHeaderHeight() =>
      (_dataBox.read('adaptiveLayoutModel') as Map)['settingsHeaderHeight']
          as double;

/* -------------------------------------------------------------------------- */
/*                                SESSION TOKEN                               */
/* -------------------------------------------------------------------------- */

  void storeSessionToken({required String token}) =>
      _appUtilsBox.write('session_token', token);

  String restoreSessionToken() => _appUtilsBox.read('session_token') as String;

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchList() => _searchHistoryBox.erase();

  @visibleForTesting
  void clearAllStorage() {
    _locationBox.erase();
    _dataBox.erase();
  }
}
