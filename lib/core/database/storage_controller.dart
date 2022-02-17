import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/location/remote_location/models/remote_location_model.dart';
import '../../features/location/user_location/models/location_model.dart';
import '../../features/sun_times/models/sun_time_model.dart';
import '../../models/weather_response_models/weather_data_model.dart';
import '../../objectbox.g.dart';
import '../../services/settings/bg_image_settings/image_settings.dart';
import '../../services/settings/unit_settings/unit_settings_model.dart';

class StorageController extends GetxService {
  static StorageController get to => Get.find();

  late Store _store;
  late Box _unitSettingsBox;
  late Box _weatherDataBox;
  late Box _sunTimeBox;
  late Box _locationBox;
  late Box _remoteLocationBox;
  late Box _searchHistoryBox;

  final _appUtilsBox = GetStorage(appUtilsStorageKey);

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage({String? path}) async {
    await Future.wait([
      _initStore(),
      GetStorage.init(appUtilsStorageKey),
    ]);
    await _storeLocalPath();
    _unitSettingsBox = _store.box<UnitSettings>();
    _weatherDataBox = _store.box<WeatherResponseModel>();
    _sunTimeBox = _store.box<SunTimesModel>();
    _locationBox = _store.box<LocationModel>();
    _remoteLocationBox = _store.box<RemoteLocationModel>();
    _searchHistoryBox = _store.box<SearchSuggestion>();
  }

  Future<void> _initStore() async => _store = await openStore();

  bool firstTimeUse() => _weatherDataBox.isEmpty();

  Future<void> _storeLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    _appUtilsBox.write('local_path', directory.path);
  }

/* -------------------------------------------------------------------------- */
/*                             APP VERSION STORAGE                            */
/* -------------------------------------------------------------------------- */

  void storeAppVersion({required String appVersion}) {
    _appUtilsBox.write(appUtilsStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      _appUtilsBox.read(appUtilsStorageKey) as String;

  String restoreAppDirectory() => _appUtilsBox.read('local_path') as String;

/* -------------------------------------------------------------------------- */
/*                                WEATHER DATA                                */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeWeatherData({required WeatherResponseModel data}) {
    _weatherDataBox.put(data);
  }

  void storeDayOrNight({required bool isDay}) =>
      _appUtilsBox.write(isDayKey, isDay);

  void storeLocalIsDay({required bool isDay}) =>
      _appUtilsBox.write('local_is_day', isDay);

  void storeTimezoneOffset(int offset) =>
      _appUtilsBox.write(timezoneOffsetKey, offset);

  void storeForecastIsDay({required bool isDay, required int index}) =>
      _appUtilsBox.write('forecast_is_day:$index', isDay);

  void storeSunTimeList({required List<SunTimesModel> sunTimes}) {
    if (!_sunTimeBox.isEmpty()) {
      _sunTimeBox.removeAll();
    }
    _sunTimeBox.putMany(sunTimes);
  }

  void storeCurrentLocalCondition({required String condition}) {
    _appUtilsBox.write('current_local_condition', condition);
  }

  void storeCurrentLocalTemp({required int temp}) {
    _appUtilsBox.write('current_local_temp', temp);
  }

/* -------------------------- Weather Data Retrieval ------------------------- */

  WeatherResponseModel restoreWeatherData() {
    return _weatherDataBox.get(1) as WeatherResponseModel;
  }

  int restoreTimezoneOffset() => _appUtilsBox.read(timezoneOffsetKey) ?? 0;

  bool restoreDayOrNight() => _appUtilsBox.read(isDayKey) ?? true;

  bool restoreLocalIsDay() => _appUtilsBox.read('local_is_day') ?? true;

  bool restoreForecastIsDay({required int index}) =>
      _appUtilsBox.read('forecast_is_day:$index') as bool;

  List<SunTimesModel> restoreSunTimeList() =>
      _sunTimeBox.getAll() as List<SunTimesModel>;

  int restoreCurrentLocalTemp() =>
      _appUtilsBox.read('current_local_temp') as int;

  String restoreCurrentLocalCondition() =>
      _appUtilsBox.read('current_local_condition') as String;

/* -------------------------------------------------------------------------- */
/*                                LOCATION DATA                               */
/* -------------------------------------------------------------------------- */

  void storeLocalLocationData({required LocationModel data}) {
    _locationBox.put(data);
  }

  void storeRemoteLocationData({required RemoteLocationModel data}) {
    _remoteLocationBox.put(data);
  }

  LocationModel restoreLocalLocationData() =>
      _locationBox.get(1) as LocationModel;

  RemoteLocationModel? restoreRemoteLocationData() =>
      _remoteLocationBox.get(1) as RemoteLocationModel?;

/* -------------------------------------------------------------------------- */
/*                                 IMAGE DATA                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      _appUtilsBox.write(imageFileNameListKey, fileList);

  void storeBgImageDynamicPath({required String path}) =>
      _appUtilsBox.write(bgImageDynamicKey, path);

  void storeBgImageAppGalleryPath({required String path}) =>
      _appUtilsBox.write(bgImageAppGalleryKey, path);

  void storeDeviceImagePath(String path) =>
      _appUtilsBox.write(deviceImagePathKey, path);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map<String, dynamic> restoreBgImageFileList() =>
      _appUtilsBox.read(imageFileNameListKey) ?? {};

  String? restoreDeviceImagePath() => _appUtilsBox.read(deviceImagePathKey);

  String restoreBgImageDynamicPath() =>
      _appUtilsBox.read(bgImageDynamicKey) ?? clearDay1;

  String restoreBgImageAppGalleryPath() =>
      _appUtilsBox.read(bgImageAppGalleryKey) ?? clearDay1;

/* -------------------------------------------------------------------------- */
/*                                 SETTINGS                                   */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Settings Storage ---------------------------- */

  void storeInitialUnitSettings({required UnitSettings settings}) {
    _unitSettingsBox.put(settings);
  }

  void updateUnitSettings({
    required UnitSettings settings,
  }) {
    final oldSettings = _unitSettingsBox.get(1) as UnitSettings;
    oldSettings.id = 2;
    _unitSettingsBox.put(settings);
    _unitSettingsBox.put(oldSettings);
  }

  void storeBgImageSettings(ImageSettings settings) {
    final settingsString = EnumToString.convertToString(settings);
    _appUtilsBox.write('image_settings', settingsString);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  UnitSettings savedUnitSettings() {
    return _unitSettingsBox.get(1) as UnitSettings;
  }

  UnitSettings oldSavedUnitSettings() {
    return _unitSettingsBox.get(2) as UnitSettings;
  }

  ImageSettings restoreBgImageSettings() {
    final settingsString = _appUtilsBox.read('image_settings') as String? ?? '';
    if (settingsString != '') {
      return EnumToString.fromString(ImageSettings.values, settingsString)!;
    } else {
      storeBgImageSettings(ImageSettings.dynamic);
      return ImageSettings.dynamic;
    }
  }

/* ------------------------- Search History Storage ------------------------- */

  void storeSearchHistory([
    RxList<SearchSuggestion>? list,
    SearchSuggestion? suggestion,
  ]) {
    _searchHistoryBox.removeAll();

    if (list != null) {
      _searchHistoryBox.putMany(list);

      if (suggestion != null) {
        _storeLatestSearch(suggestion: suggestion);
      }
    }
  }

  void _storeLatestSearch({required SearchSuggestion suggestion}) {
    final map = {
      'placeId': suggestion.placeId,
      'description': suggestion.description
    };

    _appUtilsBox.write(mostRecentSearchKey, map);
  }

  void storeLocalOrRemote({required bool searchIsLocal}) =>
      _appUtilsBox.write(searchIsLocalKey, searchIsLocal);

  String restoreCurrentPlaceId() => _appUtilsBox.read(placeIdKey) ?? '';

  bool restoreSavedSearchIsLocal() =>
      _appUtilsBox.read(searchIsLocalKey) ?? true;

  SearchSuggestion restoreLatestSuggestion() {
    final map = _appUtilsBox.read(mostRecentSearchKey) as Map? ?? {};
    final placeId = map['placeId'] as String?;
    final description = map['description'] as String?;
    final suggestion =
        SearchSuggestion(placeId: placeId!, description: description!);
    return suggestion;
  }

/* ------------------------ Search History Retrieval ------------------------ */

  List<SearchSuggestion> restoreSearchHistory() {
    return _searchHistoryBox.getAll() as List<SearchSuggestion>;
  }

/* -------------------------------------------------------------------------- */
/*                                SESSION TOKEN                               */
/* -------------------------------------------------------------------------- */

  void storeSessionToken({required String token}) =>
      _appUtilsBox.write('session_token', token);

  String restoreSessionToken() => _appUtilsBox.read('session_token') as String;

/* -------------------------------------------------------------------------- */
/*                             CLEARING FUNCTIONS                             */
/* -------------------------------------------------------------------------- */

  void clearSearchHistory() => _searchHistoryBox.removeAll();

  @visibleForTesting
  void clearAllStorage() {
    _appUtilsBox.erase();
  }
}
