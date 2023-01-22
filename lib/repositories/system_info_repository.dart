import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemInfoRepository {
  SystemInfoRepository({
    required StorageController storage,
    DeviceInfoPlugin? deviceInfo,
  })  : _storage = storage,
        _deviceInfo = deviceInfo ?? DeviceInfoPlugin();

  final StorageController _storage;

  final DeviceInfoPlugin _deviceInfo;
  late PackageInfo _packageInfo;

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iOSInfo;

  String get previousAppVersion => _storage.lastInstalledAppVersion();

  String get currentAppVersion => _packageInfo.version;

  Future<void> initDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      androidInfo = await _deviceInfo.androidInfo;
    } else {
      iOSInfo = await _deviceInfo.iosInfo;
    }
  }

  void storeAppVersion() {
    _storage.storeAppVersion(appVersion: _packageInfo.version);
  }
}
