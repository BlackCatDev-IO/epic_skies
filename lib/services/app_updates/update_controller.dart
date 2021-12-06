import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/utils/settings/settings.dart';
import 'package:epic_skies/view/dialogs/update_dialogs.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateController extends GetxController {
  static UpdateController get to => Get.find();

  late PackageInfo packageInfo;
  late String currentAppVersion;

  Future<void> checkForFirstInstallOfUpdatedAppVersion() async {
    if (!Settings.firstTimeUse) {
      await _initAppVersion();
      final lastInstalledAppVersion =
          StorageController.to.lastInstalledAppVersion();
      if (currentAppVersion != lastInstalledAppVersion) {
        const changeLog = '''
- Search Local Weather button now shows current weather info, and is visible on Locations tab (thanks Inti!)

- Selecting user bg image from device now naviates to home screen after selection

- Fixed bug where user selected bg image photo from device wasn't persisted after restart

- Fixed bug that showed Fahrenheit temps on "feels like" hourly tab when Celcius was selected
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
