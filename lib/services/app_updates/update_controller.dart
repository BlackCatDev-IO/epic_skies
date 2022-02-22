import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/view/dialogs/update_dialogs.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateController extends GetxController {
  UpdateController(this.storage);

  static UpdateController get to => Get.find();

  final StorageController storage;

  late PackageInfo packageInfo;
  late String currentAppVersion;

  Future<void> checkForFirstInstallOfUpdatedAppVersion() async {
    if (!storage.firstTimeUse()) {
      await _initAppVersion();
      log('Storing app version $currentAppVersion on first install');

      final lastInstalledAppVersion = storage.lastInstalledAppVersion();
      if (currentAppVersion != lastInstalledAppVersion) {
        const changeLog = '''
- Implemented search by postal code  

- Search history is now re-orderable

- Fixed text overflow issues on hourly page

- Fixed mismatching data between hourly forecast on home page and hourly page
        ''';
        UpdateDialog.showChangeLogDialog(
          changeLog: changeLog,
          appVersion: currentAppVersion,
        );
        storage.storeAppVersion(appVersion: currentAppVersion);
      }
    }
  }

  Future<void> storeCurrentAppVersion() async {
    await _initAppVersion();
    storage.storeAppVersion(appVersion: currentAppVersion);
  }

  Future<void> _initAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    currentAppVersion = packageInfo.version;
  }
}
