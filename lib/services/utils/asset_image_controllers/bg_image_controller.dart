import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:epic_skies/services/database/file_controller.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/view/dialogs/settings_dialogs.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../view_controllers/view_controller.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  late bool _isDayCurrent;
  bool bgImageDynamic = true;
  bool bgImageFromDeviceGallery = false;
  bool bgImageFromWeatherGallery = false;
  late String _currentCondition;

  List<File> imageFileList = []; // for use in settings image gallery
  Map<String, List<File>> _imageFileMap = {};

  late ImageProvider bgImage;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();
  int _randomNumber = 0;

  @override
  void onInit() {
    super.onInit();
    if (!StorageController.to.firstTimeUse()) {
      _initImageSettingsFromStorage();
    }
    _initImageMap();
    _isDayCurrent = StorageController.to.restoreDayOrNight()!;
  }

  /// TEMP FUNCTION TO QUICKLY CHANGE BG PICS ON BUTTON PUSH WHEN
  /// WORKING ON TEXT CONTRAST STYLING FOR EACH IMAGE
  void changeBGPic() {
    _setBgImage(file: _imageFileMap['storm_night']![0]);
  }

  void _setBgImage({required File file}) {
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }

    bgImage = FileImage(file);
    ViewController.to.updateTextAndContainerColors(path: file.path);
    update();
  }

  void _initImageMap() {
    _imageFileMap = FileController.to.imageFileMap;
    for (final fileList in _imageFileMap.values) {
      for (final file in fileList) {
        imageFileList.add(file);
      }
    }
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  void updateBgImageOnRefresh({required String condition}) {
    _isDayCurrent = TimeZoneController.to.isDayCurrent;
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
        _setBgImage(file: _imageFileMap['clear_day']![0]);
        throw 'getImagePath function failing condition: $_currentCondition ';
    }
  }

  void _chooseWeatherImageFromCondition({required String condition}) {
    List<File> tempFileList = [];

    if (_isDayCurrent) {
      if (_imageFileMap['${condition}_day']!.isNotEmpty) {
        tempFileList = _imageFileMap['${condition}_day']!;
      } else {
        tempFileList = _imageFileMap['${condition}_night']!;
      }
    } else {
      if (_imageFileMap['${condition}_night']!.isNotEmpty) {
        tempFileList = _imageFileMap['${condition}_night']!;
      } else {
        tempFileList = _imageFileMap['${condition}_day']!;
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      StorageController.to.storeDeviceImagePath(pickedFile.path);
      bgImageFromDeviceGallery = true;
      bgImageFromWeatherGallery = false;
      bgImageDynamic = false;
      _setBgImage(file: image);
      bgImageUpdatedSnackbar();
    } else {
      // TODO handle this error
      log('No image selected.');
    }

    update();
    StorageController.to.storeUserImageSettings(
        imageDynamic: bgImageDynamic,
        device: bgImageFromDeviceGallery,
        appGallery: bgImageFromWeatherGallery);
  }

  void selectImageFromAppGallery({required File imageFile}) {
    bgImageFromWeatherGallery = true;
    bgImageDynamic = false;
    bgImageFromDeviceGallery = false;
    _setBgImage(file: imageFile);

    StorageController.to.storeBgImageAppGallery(path: imageFile.path);
    StorageController.to.storeUserImageSettings(
        imageDynamic: bgImageDynamic,
        device: bgImageFromDeviceGallery,
        appGallery: bgImageFromWeatherGallery);

    bgImageUpdatedSnackbar();
    Get.delete<ViewController>(tag: 'gallery');
  }

  void handleDynamicSwitchTap() {
    if (bgImageDynamic) {
      SettingsDialogs.explainDynamicSwitch();
      bgImageDynamic = true;
    } else {
      bgImageDynamic = true;
      bgImageFromDeviceGallery = false;
      bgImageFromWeatherGallery = false;

      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(file: File(path));

      bgImageUpdatedSnackbar();
      StorageController.to.storeUserImageSettings(
          imageDynamic: bgImageDynamic,
          device: bgImageFromDeviceGallery,
          appGallery: bgImageFromWeatherGallery);
    }
    update();
  }

  void _initImageSettingsFromStorage() {
    final map = StorageController.to.restoreUserImageSetting();
    bgImageDynamic = map['dynamic'] as bool? ?? true;
    bgImageFromDeviceGallery = map['device'] as bool? ?? false;
    bgImageFromWeatherGallery = map['app_gallery'] as bool? ?? false;

    if (bgImageFromWeatherGallery) {
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
    update();
  }
}
