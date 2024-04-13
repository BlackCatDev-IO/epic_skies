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

  String get changeLog => ChangeLog.log(
        currentVersion: currentAppVersion,
        newChanges: mostRecentChanges,
      );

  String get iOsModelCode => iOSInfo?.utsname.machine ?? 'unknown';

  String get androidModel => androidInfo?.model ?? 'unknown';

  bool get isStaging => _packageInfo.packageName.endsWith('.stg');

  String systemVersion = '';

  String get mostRecentChanges => '''
Thanks for updating to $currentAppVersion! This update includes:
 - Much improved weather accuracy with Apples WeatherKit (formerly Dark Sky) weather API
 - Severe weather alerts and precipitation warnings on the home screen
 - Fix error retrieving locale info from searches in "Europe/Kyiv" timezone
 ''';

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    late String log;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      systemVersion = androidInfo?.version.release ?? '';
      log = 'Platform: Android Phone: ${androidInfo?.model ?? 'unknown'}';
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
      systemVersion = iOSInfo?.systemVersion ?? '';
      log = 'Platform: iOS \nInfo: $iOSInfo';
    }
    _logSystemInfo(log);
  }

  void _logSystemInfo(String message) {
    AppDebug.log(message, name: 'SystemInfoRepository');
  }
}
