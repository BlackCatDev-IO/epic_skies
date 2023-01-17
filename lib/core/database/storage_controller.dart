import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/location/remote_location/models/remote_location_model.dart';
import '../../features/location/user_location/models/location_model.dart';
import '../../features/sun_times/models/sun_time_model.dart';
import '../../models/weather_response_models/weather_data_model.dart';
import '../../objectbox.g.dart';
import '../../services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import '../../services/settings/unit_settings/unit_settings_model.dart';
import '../../utils/logging/app_debug_log.dart';

class StorageController {
  late Store _store;
  late Box _unitSettingsBox;
  late Box _weatherDataBox;
  late Box _sunTimeBox;
  late Box _locationBox;
  late Box _remoteLocationBox;
  late Box _searchHistoryBox;

  final _appUtilsBox = GetStorage(appUtilsStorageKey);

/* ------------------------------ Storage Keys ------------------------------ */

  static const _installDate = 'install_date';
  static const _localIsDay = 'local_is_day';
  static const _localPath = 'local_path';
  static const _currentLocalLocation = 'current_local_condition';
  static const _currentLocalTemp = 'current_local_temp';
  static const _imageSettings = 'image_settings';

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage() async {
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

  Future<void> _storeLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    _appUtilsBox.write(_localPath, directory.path);
  }

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
      _appUtilsBox.write(_localIsDay, isDay);

  void storeTimezoneOffset(int offset) =>
      _appUtilsBox.write(timezoneOffsetKey, offset);

  void storeSunTimeList({required List<SunTimesModel> sunTimes}) {
    if (!_sunTimeBox.isEmpty()) {
      _sunTimeBox.removeAll();
    }
    _sunTimeBox.putMany(sunTimes);
  }

  void storeCurrentLocalCondition({required String condition}) {
    _appUtilsBox.write(_currentLocalLocation, condition);
  }

  void storeCurrentLocalTemp({required int temp}) {
    _appUtilsBox.write(_currentLocalTemp, temp);
  }

/* -------------------------- Weather Data Retrieval ------------------------- */

  WeatherResponseModel? restoreWeatherData() {
    return _weatherDataBox.get(1) as WeatherResponseModel?;
  }

  bool restoreDayOrNight() => _appUtilsBox.read(isDayKey) ?? true;

  bool restoreLocalIsDay() => _appUtilsBox.read(_localIsDay) ?? true;

  List<SunTimesModel> restoreSunTimeList() =>
      _sunTimeBox.getAll() as List<SunTimesModel>? ?? [];

  int restoreCurrentLocalTemp() => _appUtilsBox.read(_currentLocalTemp) as int;

  String restoreCurrentLocalCondition() =>
      _appUtilsBox.read(_currentLocalLocation) as String;

/* -------------------------------------------------------------------------- */
/*                                LOCATION DATA                               */
/* -------------------------------------------------------------------------- */

  void storeLocalLocationData({required LocationModel data}) {
    _locationBox.put(data);
  }

  void storeRemoteLocationData({
    required RemoteLocationModel data,
    required SearchSuggestion suggestion,
  }) {
    _remoteLocationBox.put(data);
    _storeLatestSearch(suggestion: suggestion);
  }

  LocationModel restoreLocalLocationData() =>
      _locationBox.get(1) as LocationModel? ??
      const LocationModel(
        subLocality: '',
        administrativeArea: '',
        country: '',
        longNameList: null,
      );

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

  void updateUnitSettings({required UnitSettings settings}) {
    _unitSettingsBox.put(settings);
  }

  void storeBgImageSettings(ImageSettings settings) {
    final settingsString = EnumToString.convertToString(settings);
    _appUtilsBox.write(_imageSettings, settingsString);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  UnitSettings savedUnitSettings() {
    return _unitSettingsBox.get(1) as UnitSettings? ??
        const UnitSettings(
          tempUnitsMetric: false,
          timeIn24Hrs: false,
          precipInMm: false,
          speedInKph: false,
        );
  }

  ImageSettings restoreBgImageSettings() {
    final settingsString = _appUtilsBox.read(_imageSettings) as String? ?? '';
    if (settingsString != '') {
      return EnumToString.fromString(ImageSettings.values, settingsString)!;
    } else {
      storeBgImageSettings(ImageSettings.dynamic);
      return ImageSettings.dynamic;
    }
  }

/* ------------------------- Search History Storage ------------------------- */

  void updateSearchHistory([
    List<SearchSuggestion>? list,
  ]) {
    _searchHistoryBox.removeAll();

    if (list != null) {
      _searchHistoryBox.putMany(list);
    }
  }

  void storeSearchHistory2(SearchSuggestion suggestion) {
    _searchHistoryBox.put(suggestion);
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
    return _searchHistoryBox.getAll() as List<SearchSuggestion>? ?? [];
  }

/* -------------------------------------------------------------------------- */
/*                                UTIL STORAGE                                */
/* -------------------------------------------------------------------------- */

  DateTime getInstallDate() {
    return DateTime.now().toUtc().subtract(const Duration(days: 2));
  }

  bool firstTimeUse() {
    final isFirstTime = _weatherDataBox.isEmpty();

    if (isFirstTime) {
      final dateString = '${DateTime.now().toUtc()}';
      _appUtilsBox.write(_installDate, dateString);
      _logStorageController('install_date stored: $dateString');
    }

    return isFirstTime;
  }

  DateTime? appInstallDate() {
    final installDateString = _appUtilsBox.read(_installDate) as String?;

    // This should never happen as its stored on first install
    if (installDateString == null) {
      return null;
    }

    return DateTime.parse(installDateString).toUtc();
  }

  void storeAppVersion({required String appVersion}) {
    _appUtilsBox.write(appUtilsStorageKey, appVersion);
  }

  String? lastInstalledAppVersion() =>
      _appUtilsBox.read(appUtilsStorageKey) as String;

  String restoreAppDirectory() => _appUtilsBox.read(_localPath) as String;

  void _logStorageController(String message) {
    AppDebug.log(message, name: 'StorageController');
  }
}
