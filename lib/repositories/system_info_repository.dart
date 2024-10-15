import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class SystemInfoRepository {
  SystemInfoRepository({
    DeviceInfoPlugin? deviceInfo,
    ShorebirdCodePush? shoreBird,
  })  : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
        _shoreBird = shoreBird ?? ShorebirdCodePush();

  final DeviceInfoPlugin _deviceInfo;
  final ShorebirdCodePush _shoreBird;

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

  int? patchNumber;

  Future<void> initDeviceInfo() async {
    final packageInfoFuture = PackageInfo.fromPlatform();
    final patchNumberFuture = _shoreBird.currentPatchNumber();

    final results = await Future.wait([packageInfoFuture, patchNumberFuture]);

    _packageInfo = results[0]! as PackageInfo;
    patchNumber = results[1] as int?;

    late String log;

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
      systemVersion = androidInfo?.version.release ?? '';
      const androidIdPlugin = AndroidId();
      deviceId = await androidIdPlugin.getId() ?? '';

      log = '''
Platform: Android Phone: ${androidInfo?.model ?? 'unknown'} \nDevice ID: $deviceId''';
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
      systemVersion = iOSInfo?.systemVersion ?? '';
      deviceId = iOSInfo?.identifierForVendor ?? '';
      log = 'Platform: iOS \nInfo: $iOSInfo \nDevice ID: $deviceId';
    }

    final appVersion = 'App Version: $currentAppVersion \nPatch:$patchNumber';
    _logSystemInfo('$log \n$appVersion');
  }

  void _logSystemInfo(String message) {
    AppDebug.log(message, name: 'SystemInfoRepository');
  }
}
