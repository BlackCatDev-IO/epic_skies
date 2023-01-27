import 'package:epic_skies/global/local_constants.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/logging/app_debug_log.dart';

class StorageController {
/* ------------------------------ Storage Keys ------------------------------ */

  static const _installDate = 'install_date';
  static const _localIsDay = 'local_is_day';
  static const _localPath = 'local_path';
  static const _firstTime = 'first_time';

  Future<void> initStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: directory);

    HydratedBloc.storage.write(_localPath, directory.path);
  }

  void storeDayOrNight({required bool isDay}) =>
      HydratedBloc.storage.write(isDayKey, isDay);

  void storeLocalIsDay({required bool isDay}) =>
      HydratedBloc.storage.write(_localIsDay, isDay);

  bool restoreDayOrNight() =>
      HydratedBloc.storage.read(isDayKey) as bool? ?? true;

/* ------------------------------ Image Storage ----------------------------- */

  void storeBgImageFileNames(Map<String, dynamic> fileList) =>
      HydratedBloc.storage.write(imageFileNameListKey, fileList);

/* ---------------------------- Image Retrieival ---------------------------- */

  Map restoreBgImageFileList() =>
      HydratedBloc.storage.read(imageFileNameListKey) as Map? ?? {};

/* ------------------------------ Util Storage ------------------------------ */

  DateTime getInstallDate() {
    return DateTime.now().toUtc().subtract(const Duration(days: 2));
  }

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

  DateTime? appInstallDate() {
    final installDateString =
        HydratedBloc.storage.read(_installDate) as String?;

    // This should never happen as its stored on first install
    if (installDateString == null) {
      return null;
    }

    return DateTime.parse(installDateString).toUtc();
  }

  void storeAppVersion({required String appVersion}) {
    HydratedBloc.storage.write(appUtilsStorageKey, appVersion);
  }

  String lastInstalledAppVersion() =>
      HydratedBloc.storage.read(appUtilsStorageKey) as String? ?? '';

  String restoreAppDirectory() =>
      HydratedBloc.storage.read(_localPath) as String;

  void _logStorageController(String message) {
    AppDebug.log(message, name: 'StorageController');
  }
}
