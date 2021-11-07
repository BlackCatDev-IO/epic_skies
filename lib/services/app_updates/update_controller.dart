import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/view/dialogs/update_dialogs.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateController extends GetxController {
  static UpdateController get to => Get.find();

  late PackageInfo packageInfo;
  late String currentAppVersion;

  Future<void> checkForFirstInstallOfUpdatedAppVersion() async {
    final firstTimeUse = StorageController.to.firstTimeUse();
    if (!firstTimeUse) {
      await _initAppVersion();
      final lastInstalledAppVersion =
          StorageController.to.lastInstalledAppVersion();
      if (currentAppVersion != lastInstalledAppVersion) {
        const changeLog = '''
- Back button on Android navigates to home tab instead of out of the app

- Show Dialog on first time running updated app version

- Fix address formatting for UK addresses

- General bug fixes
        ''';
        UpdateDialog.showChangeLogDialog(
          changeLog: changeLog,
          appVersion: currentAppVersion,
        );
        StorageController.to.storeAppVersion(appVersion: currentAppVersion);
      }
    }
  }

  Future<void> storeCurrentAppVersion() async {
    await _initAppVersion();
    log('Storing app version $currentAppVersion on first install');
    StorageController.to.storeAppVersion(appVersion: currentAppVersion);
  }

  Future<void> _initAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    currentAppVersion = packageInfo.version;
  }
}
