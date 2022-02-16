import 'package:epic_skies/core/database/storage_controller.dart';

class Settings {
  Settings._();

  static bool get firstTimeUse => StorageController.to.firstTimeUse();
  static bool get searchIsLocal =>
      StorageController.to.restoreSavedSearchIsLocal();

/* -------------------------------------------------------------------------- */
/*                              BG IMAGE SETTINGS                             */
/* -------------------------------------------------------------------------- */

  static String get sessionToken => StorageController.to.restoreSessionToken();
}
