import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// All local device storage is managed through this class. Most storage is
/// handled via HydradedBloc/Cubit classes with the exception of a few util
/// storage items
class StorageController {
/* ------------------------------ Storage Keys ------------------------------ */

  static const _installDate = 'install_date';
  static const _localPath = 'local_path';
  static const _firstTime = 'first_time';

  /// Inits storage directory in main.dart before `runApp`
  Future<void> initStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: directory);

    await HydratedBloc.storage.write(_localPath, directory.path);
  }

  /// Used to maintain day or night icon for the `SearchLocalWeatherButton`
  void storeDayOrNight({required bool isDay}) =>
      HydratedBloc.storage.write(isDayKey, isDay);

  /// Used to restore previous day or night icon for the
  /// `SearchLocalWeatherButton`
  bool restoreDayOrNight() =>
      HydratedBloc.storage.read(isDayKey) as bool? ?? true;

/* ------------------------------ Image Storage ----------------------------- */

  /// Stores file names retreived from Firebase Storage onto the users device
  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      HydratedBloc.storage.write(imageFileNameListKey, fileList);

  /// Stores file names retreived from Firebase Storage onto the users device
  Map<dynamic, dynamic> restoreBgImageFileList() =>
      HydratedBloc.storage.read(imageFileNameListKey) as Map? ?? {};

/* ------------------------------ Util Storage ------------------------------ */

  /// Used on app start to determine whether to show opening splash screen or
  /// navigate to `HomeTabView`
  bool isNewInstall() {
    if (HydratedBloc.storage.read(_firstTime) == null) {
      HydratedBloc.storage.write(_firstTime, false);
      final dateString = '${DateTime.now().toUtc()}';
      HydratedBloc.storage.write(_installDate, dateString);
      _logStorageController('install_date stored: $dateString');
      return true;
    }

    return false;
  }

  /// Stores the date of install to track Ad Free trial period
  DateTime? appInstallDate() {
    final installDateString =
        HydratedBloc.storage.read(_installDate) as String?;

    // This should never happen as its stored on first install
    if (installDateString == null) {
      return null;
    }

    return DateTime.parse(installDateString).toUtc();
  }

  /// Stores on app updates to track when user updates to new version so a
  /// dialog with changes can be shown
  void storeAppVersion({required String appVersion}) {
    HydratedBloc.storage.write(appUtilsStorageKey, appVersion);
  }

  /// Restores app version to check if user has updated on app start
  String lastInstalledAppVersion() =>
      HydratedBloc.storage.read(appUtilsStorageKey) as String? ?? '';

  /// Used in `file_controller.dart` and `firestore_database.dart` to prefix
  /// image file names with local directory path
  String restoreAppDirectory() =>
      HydratedBloc.storage.read(_localPath) as String;

  void _logStorageController(String message) {
    AppDebug.log(message, name: 'StorageController');
  }
}
