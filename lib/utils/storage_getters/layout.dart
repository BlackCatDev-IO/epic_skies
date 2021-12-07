import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:sizer/sizer.dart';

class Layout {
  Layout._();

  static double get appBarHeight => StorageController.to.appBarHeight();

  static double get appBarPadding => StorageController.to.appBarPadding();

  static double get savedLocationScreenPadding =>
      (StorageController.to.appBarPadding() - 0.5).h;

  static double get settingsHeaderHeight =>
      StorageController.to.settingsHeaderHeight();
}
