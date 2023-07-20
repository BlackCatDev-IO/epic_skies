import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:epic_skies/services/app_updates/utils/change_log_string.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemInfoRepository {
  SystemInfoRepository({
    DeviceInfoPlugin? deviceInfo,
  }) : _deviceInfo = deviceInfo ?? DeviceInfoPlugin();

  final DeviceInfoPlugin _deviceInfo;

  late PackageInfo _packageInfo;

  AndroidDeviceInfo? androidInfo;

  IosDeviceInfo? iOSInfo;

  String get currentAppVersion => _packageInfo.version;

  String get mostRecentChanges => '';

  String get changeLog => ChangeLog.log(
        currentVersion: currentAppVersion,
        newChanges: mostRecentChanges,
      );

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
    }
  }
}
