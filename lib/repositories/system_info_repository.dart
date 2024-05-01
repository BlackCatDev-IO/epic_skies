import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  String get iOsModelCode => iOSInfo?.utsname.machine ?? 'unknown';

  String get androidModel => androidInfo?.model ?? 'unknown';

  bool get isStaging => _packageInfo.packageName.endsWith('.stg');

  String systemVersion = '';

  String deviceId = '';

  List<String> get mostRecentChanges => [
        '''Much improved weather accuracy with Apples WeatherKit (formerly Dark Sky) weather API''',
        'Severe weather and precipitation notices on the home screen',
        'Status bar is now transparent',
      ];

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    late String log;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      systemVersion = androidInfo?.version.release ?? '';
      log = 'Platform: Android Phone: ${androidInfo?.model ?? 'unknown'}';
      const androidIdPlugin = AndroidId();

      deviceId = await androidIdPlugin.getId() ?? '';
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
      systemVersion = iOSInfo?.systemVersion ?? '';
      deviceId = iOSInfo?.identifierForVendor ?? '';
      log = 'Platform: iOS \nInfo: $iOSInfo';
    }
    _logSystemInfo(log);
  }

  void _logSystemInfo(String message) {
    AppDebug.log(message, name: 'SystemInfoRepository');
  }
}
