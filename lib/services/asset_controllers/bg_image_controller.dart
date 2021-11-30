import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/image_map_keys.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/settings/settings.dart';
import 'package:epic_skies/view/dialogs/settings_dialogs.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  late bool _isDayCurrent;
  bool bgImageDynamic = true;
  bool bgImageFromDeviceGallery = false;
  bool bgImageFromAppGallery = false;
  late String _currentCondition;

  Map<String, List<File>> imageFileMap = {};

  late ImageProvider bgImage;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();
  int _randomNumber = 0;

  @override
  void onInit() {
    super.onInit();
    if (!Settings.firstTimeUse) {
      _initImageSettingsFromStorage();
    }
    imageFileMap = FileController.to.imageFileMap;

    _isDayCurrent = StorageController.to.restoreDayOrNight();
  }

  /// TEMP FUNCTION TO QUICKLY CHANGE BG PICS ON BUTTON PUSH WHEN
  /// WORKING ON TEXT CONTRAST STYLING FOR EACH IMAGE
  void changeBGPic() {
    _setBgImage(file: imageFileMap[ImageFileKeys.clearDay]![0]);
  }

  void _setBgImage({required File file}) {
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }

    bgImage = FileImage(file);
    ColorController.to.updateTextAndContainerColors(path: file.path);
    update();
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  void updateBgImageOnRefresh({required String condition}) {
    _isDayCurrent = TimeZoneController.to.getCurrentIsDay();
    _currentCondition = condition.toLowerCase();

    switch (_currentCondition) {
      case 'clear':
      case 'mostly clear':
        _chooseWeatherImageFromCondition(condition: 'clear');
        break;
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        _chooseWeatherImageFromCondition(condition: 'cloudy');
        break;
      case 'light wind':
      case 'strong wind':
      case 'wind':
        // TODO: find wind images and finish this function
        _chooseWeatherImageFromCondition(condition: 'cloudy');
        break;
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        _chooseWeatherImageFromCondition(condition: 'rain');
        break;
      case 'snow':
      case 'flurries':
      case 'light snow':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
        _chooseWeatherImageFromCondition(condition: 'snow');
        break;
      case 'thunderstorm':
        _chooseWeatherImageFromCondition(condition: 'storm');
        break;
      default:
        _setBgImage(file: imageFileMap['clear_day']![0]);
        throw 'getImagePath function failing condition: $_currentCondition ';
    }
  }

  void _chooseWeatherImageFromCondition({required String condition}) {
    List<File> tempFileList = [];

    if (_isDayCurrent) {
      if (imageFileMap['${condition}_day']!.isNotEmpty) {
        tempFileList = imageFileMap['${condition}_day']!;
      } else {
        tempFileList = imageFileMap['${condition}_night']!;
      }
    } else {
      if (imageFileMap['${condition}_night']!.isNotEmpty) {
        tempFileList = imageFileMap['${condition}_night']!;
      } else {
        tempFileList = imageFileMap['${condition}_day']!;
      }
    }

    if (tempFileList.length > 1) {
      _randomNumber = _random.nextInt(tempFileList.length - 1);
    } else {
      _randomNumber = 0;
    }
    _setBgImage(file: tempFileList[_randomNumber]);
  }

/* -------------------------------------------------------------------------- */
/*                           USER SETTING FUNCTIONS                           */
/* -------------------------------------------------------------------------- */

  Future<void> selectImageFromDeviceGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      StorageController.to.storeDeviceImagePath(pickedFile.path);
      bgImageFromDeviceGallery = true;
      bgImageFromAppGallery = false;
      bgImageDynamic = false;
      _setBgImage(file: image);
      Snackbars.bgImageUpdatedSnackbar();
    } else {
      // TODO handle this error
      log('No image selected.');
    }

    StorageController.to.storeUserImageSettings(
      imageDynamic: bgImageDynamic,
      device: bgImageFromDeviceGallery,
      appGallery: bgImageFromAppGallery,
    );
  }

  void selectImageFromAppGallery({required File imageFile}) {
    bgImageFromAppGallery = true;
    bgImageDynamic = false;
    bgImageFromDeviceGallery = false;
    _setBgImage(file: imageFile);

    StorageController.to.storeBgImageAppGallery(path: imageFile.path);
    StorageController.to.storeUserImageSettings(
      imageDynamic: bgImageDynamic,
      device: bgImageFromDeviceGallery,
      appGallery: bgImageFromAppGallery,
    );

    Snackbars.bgImageUpdatedSnackbar();
  }

  void handleDynamicSwitchTap() {
    if (bgImageDynamic) {
      SettingsDialogs.explainDynamicSwitch();
      bgImageDynamic = true;
    } else {
      bgImageDynamic = true;
      bgImageFromDeviceGallery = false;
      bgImageFromAppGallery = false;

      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(file: File(path));

      Snackbars.bgImageUpdatedSnackbar();
      StorageController.to.storeUserImageSettings(
        imageDynamic: bgImageDynamic,
        device: bgImageFromDeviceGallery,
        appGallery: bgImageFromAppGallery,
      );
    }
  }

  void _initImageSettingsFromStorage() {
    bgImageDynamic = Settings.bgImageDynamic;
    bgImageFromDeviceGallery = Settings.bgImageFromDevice;
    bgImageFromAppGallery = Settings.bgImageFromAppGallery;

    if (bgImageFromAppGallery) {
      final path = StorageController.to.restoreBgImageAppGallery();
      _setBgImage(file: File(path));
    } else if (bgImageFromDeviceGallery) {
      final path = StorageController.to.restoreDeviceImagePath()!;
      _setBgImage(file: File(path));
      bgImage = FileImage(File(path));
    } else {
      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(file: File(path));
    }
  }
}
