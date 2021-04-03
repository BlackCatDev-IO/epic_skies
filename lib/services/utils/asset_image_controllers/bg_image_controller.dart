import 'dart:io';
import 'dart:math';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  bool isDayCurrent;
  bool forecastIsDay;
  bool bgImageDynamic = true;
  bool bgImageFromDeviceGallery = false;
  bool bgImageFromWeatherGallery = false;
  String _currentCondition;

  List<File> imageFileList = [];

  /// list @ index 0 is daytime images, index 1 night time images
  List<List<File>> clearImageList = [[], []];
  List<List<File>> cloudyImageList = [[], []];
  List<List<File>> rainImageList = [[], []];
  List<List<File>> snowImageList = [[], []];
  List<List<File>> stormImageList = [[], []];

  ImageProvider bgImage;

  final random = Random();

  int randomNumber;

  void _setBgImage(File file) {
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }
    bgImage = FileImage(file);
    update();
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  Future<void> updateBgImageOnRefresh(String condition) async {
    TimeZoneController.to.getCurrentDayOrNight();

    isDayCurrent = TimeZoneController.to.isDayCurrent;
    _currentCondition = condition.toLowerCase();

    switch (_currentCondition) {
      case 'clear':
      case 'mostly clear':
        _getClearBgImage();
        break;
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        _getCloudyBgImage();
        break;
      case 'light wind':
      case 'strong wind':
      case 'wind':
        _getCloudyBgImage();
        break;

      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        _getRainBgImagePath();
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
        _setSnowBgImage();
        break;
      case 'thunderstorm':
        _setThunderstormBgImage();
        break;

      default:
        _setBgImage(clearImageList[0][0]);
        throw 'getImagePath function failing condition: $_currentCondition ';
    }

    ColorController.to.updateBgText();
  }

  void _getClearBgImage() {
    if (isDayCurrent) {
      randomNumber = random.nextInt(clearImageList[0].length);
      _setBgImage(clearImageList[0][randomNumber]);
    } else {
      randomNumber = random.nextInt(clearImageList[1].length);
      _setBgImage(clearImageList[1][randomNumber]);
    }
  }

  void _setThunderstormBgImage() {
    _setBgImage(stormImageList[1][0]);
  }

// TODO get better overcast picture for day time
  void _getCloudyBgImage() {
    randomNumber = random.nextInt(cloudyImageList[0].length);
    _setBgImage(cloudyImageList[0][randomNumber]);
  }

  void _getRainBgImagePath() {
    randomNumber = random.nextInt(rainImageList[0].length);
    _setBgImage(rainImageList[0][randomNumber]);
  }

// TODO: find wind images and finish this function
  void _getWindBgImagePath() {}

  void _setSnowBgImage() {
    if (isDayCurrent) {
      randomNumber = random.nextInt(snowImageList[0].length);
      _setBgImage(snowImageList[0][randomNumber]);
    } else {
      randomNumber = random.nextInt(snowImageList[1].length);
      _setBgImage(snowImageList[1][randomNumber]);
    }
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
      // TODO: add dialog to confirm image selection
      final image = File(pickedFile.path);
      _setBgImage(image);
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
    bgImageUpdatedSnackbar();
  }

  void selectImageFromAppGallery({@required File imageFile, String asset}) {
    bgImageFromWeatherGallery = true;
    bgImageDynamic = false;
    bgImageFromDeviceGallery = false;
    bgImage = FileImage(imageFile);
    update();

    final storeString = imageFile.path ?? asset;

    StorageController.to.storeBgImageAppGallery(path: storeString);
    StorageController.to.storeUserImageSettings(
        imageDynamic: bgImageDynamic,
        device: bgImageFromDeviceGallery,
        appGallery: bgImageFromWeatherGallery);

    bgImageUpdatedSnackbar();
    Get.delete<GalleryController>();
  }

  void handleDynamicSwitchTap() {
    if (bgImageDynamic) {
      explainDynamicSwitch(context: Get.context);
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
    bgImageDynamic = map['dynamic'] as bool ?? true;
    bgImageFromDeviceGallery = map['device'] as bool ?? false;
    bgImageFromWeatherGallery = map['app_gallery'] as bool ?? false;

    if (bgImageFromWeatherGallery) {
      final path = StorageController.to.restoreBgImageAppGallery();
      _setBgImage(File(path));
    } else if (bgImageFromDeviceGallery) {
      final path = StorageController.to.restoreDeviceImagePath();
      _setBgImage(File(path));
      bgImage = FileImage(File(path));
    } else {
      final path = StorageController.to.restoreBgImageDynamic();
      _setBgImage(File(path));
    }
    update();
  }
}
