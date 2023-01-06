import 'dart:io';

import 'package:get/get.dart';

import '../../core/database/storage_controller.dart';
import '../../core/network/api_keys.dart';

class AdController extends GetxController {
  AdController(StorageController storage) : _storage = storage;

  static AdController get to => Get.find();

  final StorageController _storage;

  bool showAds = false;

  // @override
  // void onInit() {
  //   super.onInit();

  //   final installDate = _storage.appInstallDate();

  //   if (installDate != null) {
  //     final daysSinceInstall = DateTime.now().toUtc().difference(installDate);

  //     final trialPeriodExpired = daysSinceInstall.inDays > 30;

  //     if (trialPeriodExpired) {
  //       showAds = true;
  //       update();
  //     }
  //   }
  // }

  static String get testNativeAdUnitId {
    return Platform.isAndroid
        ? AdMobKeys.androidNativeId
        : AdMobKeys.iOSNativeId;
  }
}
