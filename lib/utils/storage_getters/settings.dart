import 'package:epic_skies/core/database/storage_controller.dart';

class Settings {
  Settings._();

  static bool get firstTimeUse => StorageController.to.firstTimeUse();
  static bool get searchIsLocal =>
      StorageController.to.restoreSavedSearchIsLocal();

/* -------------------------------------------------------------------------- */
/*                              BG IMAGE SETTINGS                             */
/* -------------------------------------------------------------------------- */

  static bool get bgImageDynamic => StorageController.to.bgImageDynamic();
  static bool get bgImageFromAppGallery =>
      StorageController.to.bgImageFromAppGallery();
  static bool get bgImageFromDevice => StorageController.to.bgImageFromDevice();

  static String get sessionToken => StorageController.to.restoreSessionToken();
}
