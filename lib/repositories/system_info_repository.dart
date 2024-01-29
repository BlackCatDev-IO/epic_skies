import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:epic_skies/services/app_updates/utils/change_log_string.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
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

  String get iOsModel => iOSInfo?.utsname.machine ?? 'unknown';

  String get androidModel => androidInfo?.model ?? 'unknown';

  bool get isStaging => _packageInfo.packageName.endsWith('.stg');

  late String deviceModelName;

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    late String log;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      deviceModelName = androidModel;
      log = 'Platform: Android Phone: ${androidInfo?.model ?? 'unknown'}';
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
      deviceModelName = iOsModel;
      log = 'Platform: iOS \nInfo: $iOSInfo';
    }
    _logSystemInfo(log);
  }

  void _logSystemInfo(String message) {
    AppDebug.log(message, name: 'SystemInfoRepository');
  }
}
