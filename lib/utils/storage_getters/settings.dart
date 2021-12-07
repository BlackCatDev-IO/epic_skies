import 'package:epic_skies/core/database/storage_controller.dart';

class Settings {
  Settings._();

  static bool get firstTimeUse => StorageController.to.firstTimeUse();
  static bool get searchIsLocal =>
      StorageController.to.restoreSavedSearchIsLocal();

/* -------------------------------------------------------------------------- */
/*                                UNIT SETTINGS                               */
/* -------------------------------------------------------------------------- */

  static bool get tempUnitsCelcius => StorageController.to.tempUnitsCelcius();
  static bool get timeIs24Hrs => StorageController.to.timeIs24Hrs();
  static bool get speedInKph => StorageController.to.speedInKph();
  static bool get precipInMm => StorageController.to.precipInMm();

/* -------------------------------------------------------------------------- */
/*                              BG IMAGE SETTINGS                             */
/* -------------------------------------------------------------------------- */

  static bool get bgImageDynamic => StorageController.to.bgImageDynamic();
  static bool get bgImageFromAppGallery =>
      StorageController.to.bgImageFromAppGallery();
  static bool get bgImageFromDevice => StorageController.to.bgImageFromDevice();
}
