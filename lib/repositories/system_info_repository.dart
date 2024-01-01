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

  bool get isStaging =>
      _packageInfo.packageName == 'com.blackcatdev.epic_skies.stg';
      
  late String deviceModelName;

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    late String log;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      deviceModelName = androidModel;
      log = 'OS: Android Phone: ${androidInfo?.model ?? 'unknown'}';
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
      deviceModelName = iOsModel;
      log =
          'Platform: iOS \nModel ID: ${_getiPhoneModelFromID(deviceModelName)}';
    }
    _logSystemInfo(log);
  }

  void _logSystemInfo(String message) {
    AppDebug.log(message, name: 'SystemInfoRepository');
  }
}

String _getiPhoneModelFromID(String modelId) {
  return switch (modelId) {
    'iPhone1,1' => 'iPhone',
    'iPhone1,2' => 'iPhone 3G',
    'iPhone2,1' => 'iPhone 3GS',
    'iPhone3,1' => 'iPhone 4',
    'iPhone3,2' => 'iPhone 4 GSM Rev A',
    'iPhone3,3' => 'iPhone 4 CDMA',
    'iPhone4,1' => 'iPhone 4S',
    'iPhone5,1' => 'iPhone 5 (GSM)',
    'iPhone5,2' => 'iPhone 5 (GSM+CDMA)',
    'iPhone5,3' => 'iPhone 5C (GSM)',
    'iPhone5,4' => 'iPhone 5C (Global)',
    'iPhone6,1' => 'iPhone 5S (GSM)',
    'iPhone6,2' => 'iPhone 5S (Global)',
    'iPhone7,1' => 'iPhone 6 Plus',
    'iPhone7,2' => 'iPhone 6',
    'iPhone8,1' => 'iPhone 6s',
    'iPhone8,2' => 'iPhone 6s Plus',
    'iPhone8,4' => 'iPhone SE (GSM)',
    'iPhone9,1' => 'iPhone 7',
    'iPhone9,2' => 'iPhone 7 Plus',
    'iPhone9,3' => 'iPhone 7',
    'iPhone9,4' => 'iPhone 7 Plus',
    'iPhone10,1' => 'iPhone 8',
    'iPhone10,2' => 'iPhone 8 Plus',
    'iPhone10,3' => 'iPhone X Global',
    'iPhone10,4' => 'iPhone 8',
    'iPhone10,5' => 'iPhone 8 Plus',
    'iPhone10,6' => 'iPhone X GSM',
    'iPhone11,2' => 'iPhone XS',
    'iPhone11,4' => 'iPhone XS Max',
    'iPhone11,6' => 'iPhone XS Max Global',
    'iPhone11,8' => 'iPhone XR',
    'iPhone12,1' => 'iPhone 11',
    'iPhone12,3' => 'iPhone 11 Pro',
    'iPhone12,5' => 'iPhone 11 Pro Max',
    'iPhone12,8' => 'iPhone SE 2nd Gen',
    'iPhone13,1' => 'iPhone 12 Mini',
    'iPhone13,2' => 'iPhone 12',
    'iPhone13,3' => 'iPhone 12 Pro',
    'iPhone13,4' => 'iPhone 12 Pro Max',
    'iPhone14,2' => 'iPhone 13 Pro',
    'iPhone14,3' => 'iPhone 13 Pro Max',
    'iPhone14,4' => 'iPhone 13 Mini',
    'iPhone14,5' => 'iPhone 13',
    'iPhone14,6' => 'iPhone SE 3rd Gen',
    'iPhone14,7' => 'iPhone 14',
    'iPhone14,8' => 'iPhone 14 Plus',
    'iPhone15,2' => 'iPhone 14 Pro',
    'iPhone15,3' => 'iPhone 14 Pro Max',
    _ => 'Unknown iPhone'
  };
}
