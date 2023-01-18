import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import '../../utils/logging/app_debug_log.dart';

class StorageController {
  final _appUtilsBox = GetStorage(appUtilsStorageKey);

/* ------------------------------ Storage Keys ------------------------------ */

  static const _installDate = 'install_date';
  static const _localIsDay = 'local_is_day';
  static const _localPath = 'local_path';
  static const _currentLocalTemp = 'current_local_temp';
  static const _imageSettings = 'image_settings';
  static const _weatherState = 'weatherState';

/* -------------------------------------------------------------------------- */
/*                               INIT FUNCTIONS                               */
/* -------------------------------------------------------------------------- */

  Future<void> initAllStorage() async {
    await Future.wait([
      GetStorage.init(appUtilsStorageKey),
    ]);
    await _storeLocalPath();
  }

  Future<void> _storeLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: directory);

    _appUtilsBox.write(_localPath, directory.path);
  }

/* -------------------------------------------------------------------------- */
/*                                WEATHER DATA                                */
/* -------------------------------------------------------------------------- */

/* -------------------------- Weather Data Storage -------------------------- */

  void storeWeatherState(WeatherState state) {
    _appUtilsBox.write(_weatherState, state.toJson());
  }

  WeatherState restoreWeatherState() {
    final map = _appUtilsBox.read(_weatherState) as Map<String, dynamic>;

    return WeatherState.fromJson(map);
  }

  void storeDayOrNight({required bool isDay}) =>
      _appUtilsBox.write(isDayKey, isDay);

  void storeLocalIsDay({required bool isDay}) =>
      _appUtilsBox.write(_localIsDay, isDay);

  void storeCurrentLocalTemp({required int temp}) {
    _appUtilsBox.write(_currentLocalTemp, temp);
  }

  bool restoreDayOrNight() => _appUtilsBox.read(isDayKey) ?? true;

/* -------------------------------------------------------------------------- */
/*                                 IMAGE DATA                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      _appUtilsBox.write(imageFileNameListKey, fileList);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map<String, dynamic> restoreBgImageFileList() =>
      _appUtilsBox.read(imageFileNameListKey) ?? {};

/* -------------------------------------------------------------------------- */
/*                                 SETTINGS                                   */
/* -------------------------------------------------------------------------- */

/* ---------------------------- Settings Storage ---------------------------- */

  void storeBgImageSettings(ImageSettings settings) {
    final settingsString = EnumToString.convertToString(settings);
    _appUtilsBox.write(_imageSettings, settingsString);
  }

/* --------------------------- Settings Retrieval --------------------------- */

  ImageSettings restoreBgImageSettings() {
    final settingsString = _appUtilsBox.read(_imageSettings) as String? ?? '';
    if (settingsString != '') {
      return EnumToString.fromString(ImageSettings.values, settingsString)!;
    } else {
      storeBgImageSettings(ImageSettings.dynamic);
      return ImageSettings.dynamic;
    }
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

/* -------------------------------------------------------------------------- */
/*                                UTIL STORAGE                                */
/* -------------------------------------------------------------------------- */

  DateTime getInstallDate() {
    return DateTime.now().toUtc().subtract(const Duration(days: 2));
  }

  bool firstTimeUse() {
    final isFirstTime = _appUtilsBox.read(_weatherState) == null;

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
