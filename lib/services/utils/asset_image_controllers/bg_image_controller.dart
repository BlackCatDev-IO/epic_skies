import 'dart:io';
import 'dart:math';
import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/global/alert_dialogs/settings_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
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
  final _random = Random();
  int _randomNumber = 0;

  @override
  void onInit() {
    super.onInit();
    if (!StorageController.to.firstTimeUse()) {
      initImageSettingsFromStorage();
    }
    _initImageMap();
    _isDayCurrent = StorageController.to.restoreDayOrNight()!;
  }

  //TEMP FUNCTION
  void changeBGPic() {
    _setBgImage(_imageFileMap['cloudy_night']![2]);
  }

  void _setBgImage(File file) {
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }

    bgImage = FileImage(file);
    ViewController.to.updateTextAndContainerColors(file.path);
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

  void updateBgImageOnRefresh(String condition) {
    _isDayCurrent = TimeZoneController.to.isDayCurrent;
    debugPrint('isDayCurrent on update image function: $_isDayCurrent');
    _currentCondition = condition.toLowerCase();

    switch (_currentCondition) {
      case 'clear':
      case 'mostly clear':
        _chooseWeatherImageFromCondition(key: 'clear');
        break;
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        _chooseWeatherImageFromCondition(key: 'cloudy');
        break;
      case 'light wind':
      case 'strong wind':
      case 'wind':
        // TODO: find wind images and finish this function
        _chooseWeatherImageFromCondition(key: 'cloudy');
        break;
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        _chooseWeatherImageFromCondition(key: 'rain');
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
        _chooseWeatherImageFromCondition(key: 'snow');
        break;
      case 'thunderstorm':
        _chooseWeatherImageFromCondition(key: 'storm');
        break;
      default:
        _setBgImage(_imageFileMap['asset_backup']![0]);
        throw 'getImagePath function failing condition: $_currentCondition ';
    }
  }

  void _chooseWeatherImageFromCondition({required String key}) {
    List<File> tempFileList = [];

    if (_isDayCurrent) {
      if (_imageFileMap['${key}_day']!.isNotEmpty) {
        tempFileList = _imageFileMap['${key}_day']!;
      } else {
        tempFileList = _imageFileMap['${key}_night']!;
      }
    } else {
      if (_imageFileMap['${key}_night']!.isNotEmpty) {
        tempFileList = _imageFileMap['${key}_night']!;
      } else {
        tempFileList = _imageFileMap['${key}_day']!;
      }
    }

    if (tempFileList.length > 1) {
      _randomNumber = _random.nextInt(tempFileList.length - 1);
    } else {
      _randomNumber = 0;
    }
    _setBgImage(tempFileList[_randomNumber]);
  }

/* -------------------------------------------------------------------------- */
/*                           USER SETTING FUNCTIONS                           */
/* -------------------------------------------------------------------------- */

  Future<void> selectImageFromDeviceGallery() async {
    bgImageFromDeviceGallery = true;
    bgImageFromWeatherGallery = false;
    bgImageDynamic = false;

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      _setBgImage(image);
      bgImageUpdatedSnackbar();
      StorageController.to.storeDeviceImagePath(pickedFile.path);
    } else {
      // TODO handle this error
      debugPrint('No image selected.');
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
    _setBgImage(imageFile);

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
      explainDynamicSwitch();
      bgImageDynamic = true;
    } else {
      bgImageDynamic = true;
      bgImageFromDeviceGallery = false;
      bgImageFromWeatherGallery = false;

      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(File(path));

      bgImageUpdatedSnackbar();
      StorageController.to.storeUserImageSettings(
          imageDynamic: bgImageDynamic,
          device: bgImageFromDeviceGallery,
          appGallery: bgImageFromWeatherGallery);
    }
    update();
  }

  void initImageSettingsFromStorage() {
    final map = StorageController.to.restoreUserImageSetting();
    bgImageDynamic = map['dynamic'] as bool? ?? true;
    bgImageFromDeviceGallery = map['device'] as bool? ?? false;
    bgImageFromWeatherGallery = map['app_gallery'] as bool? ?? false;

    if (bgImageFromWeatherGallery) {
      final path = StorageController.to.restoreBgImageAppGallery();
      _setBgImage(File(path));
    } else if (bgImageFromDeviceGallery) {
      final path = StorageController.to.restoreDeviceImagePath()!;
      _setBgImage(File(path));
      bgImage = FileImage(File(path));
    } else {
      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(File(path));
    }
    update();
  }
}
