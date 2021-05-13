import 'dart:io';
import 'dart:math';
import 'package:epic_skies/global/alert_dialogs/settings_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../master_getx_controller.dart';
import '../view_controllers/view_controller.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  late bool isDayCurrent;
  bool? forecastIsDay;
  bool bgImageDynamic = true;
  bool bgImageFromDeviceGallery = false;
  bool bgImageFromWeatherGallery = false;
  String? _currentCondition;

  List<File?> imageFileList = [];

  /// list @ index 0 is daytime images, index 1 night time images
  List<List<File>> clearImageList = [[], []];
  List<List<File>> cloudyImageList = [[], []];
  List<List<File>> rainImageList = [[], []];
  List<List<File>> snowImageList = [[], []];
  List<List<File>> stormImageList = [[], []];

  late ImageProvider bgImage;

  final random = Random();

  late int randomNumber;

  @override
  void onInit() {
    super.onInit();
    if (!MasterController.to.firstTimeUse) {
      initImageSettingsFromStorage();
    }
  }

  void _setBgImage(File file) {
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }

    bgImage = FileImage(file);
    // bgImage = FileImage(clearImageList[1][0]);
    // bgImage = FileImage(cloudyImageList[0][1]);
    // bgImage = FileImage(rainImageList[0][0]);
    // bgImage = FileImage(snowImageList[0][0]);
    // bgImage = FileImage(stormImageList[0][0]);
    update();
    ViewController.to.updateBgTextColor(file.path);
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  Future<void> updateBgImageOnRefresh(String condition) async {
    if (WeatherRepository.to.isLoading.value) {
      TimeZoneController.to.getCurrentDayOrNight();
    }

    isDayCurrent = TimeZoneController.to.isDayCurrent;
    _currentCondition = condition.toLowerCase();
    // _currentCondition = 'cloudy';

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
  }

  void _getClearBgImage() {
    if (isDayCurrent) {
      // randomNumber = random.nextInt(clearImageList[0].length);
      // _setBgImage(clearImageList[0][randomNumber]);
      _setBgImage(clearImageList[0][0]);
    } else {
      randomNumber = random.nextInt(clearImageList[1].length);
      _setBgImage(clearImageList[1][0]);
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
    if (!CurrentWeatherController.to.falseSnow) {
      if (isDayCurrent) {
        randomNumber = random.nextInt(snowImageList[0].length);
        _setBgImage(snowImageList[0][randomNumber]);
      } else {
        randomNumber = random.nextInt(snowImageList[1].length);
        _setBgImage(snowImageList[1][randomNumber]);
      }
    } else {
      _getCloudyBgImage();
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
