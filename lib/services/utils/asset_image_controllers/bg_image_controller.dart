import 'dart:io';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  String bgDynamicImageString = '';
  String bgUserImageString = '';
  String path = '';

  File image;

  bool isDayCurrent;
  bool forecastIsDay;
  bool bgImageDynamic = true;
  bool bgImageFromDeviceGallery = false;
  bool bgImageFromWeatherGallery = false;
  String _currentCondition;

  List<File> imageFileList = [];

  // list @ index 0 is daytime images, index 1 night
  List<List<File>> clearImageList = [[], []];
  List<List<File>> cloudyImageList = [[], []];
  List<List<File>> rainImageList = [[], []];
  List<List<File>> snowImageList = [[], []];

  ImageProvider bgImage;

  @override
  void onInit() {
    super.onInit();
    path = StorageController.to.appDirectoryPath;
    _restoreImageFiles();
  }

  void _setBgImage(String path) {
    if (bgImageFromDeviceGallery) {
      final image = File(path);
      bgImage = FileImage(image);
    } else {
      bgImage = AssetImage(path);
    }
    update();
  }

  void _setFileImage(File file) {
    bgImage = FileImage(file);
    update();
  }

  void setNewImage() {
    final image = clearImageList[0][0];
    bgImage = FileImage(image);
    update();
  }

  void _restoreImageFiles() {
    final Map<String, dynamic> map =
        StorageController.to.restoreBgImageFileList();

    map.forEach((key, value) {
      _createFileFromList(name: key, list: value as List);
    });
  }

  void _createFileFromList({String name, List list}) {
    final dayList = list[0] as List;
    final nightList = list[1] as List;

    final List<File> tempDayFileList = [];
    final List<File> tempNightFileList = [];

    for (final dayFile in dayList) {
      final file = File('$path/$dayFile');
      tempDayFileList.add(file);
    }

    for (final nightFile in nightList) {
      final file = File('$path/$nightFile');
      tempNightFileList.add(file);
    }

    switch (name) {
      case 'clear':
        clearImageList[0].addAll(tempDayFileList);
        clearImageList[1].addAll(tempNightFileList);
        break;
      case 'cloudy':
        cloudyImageList[0].addAll(tempDayFileList);
        cloudyImageList[1].addAll(tempNightFileList);
        break;
      case 'rain':
        rainImageList[0].addAll(tempDayFileList);
        clearImageList[1].addAll(tempNightFileList);
        break;
      case 'snow':
        snowImageList[0].addAll(tempDayFileList);
        snowImageList[1].addAll(tempNightFileList);
        break;
      default:
    }
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
        _getWindBgImagePath();
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
        _getSnowBgImagePath();
        break;
      case 'thunderstorm':
        _getThunderstormBgImage();
        break;

      default:
        throw 'getImagePath function failing condition: $_currentCondition ';
    }
    // if (bgImageDynamic) {
    //   _setBgImage(bgDynamicImageString);
    // }

    ColorController.to.updateBgText();
    StorageController.to.storeBgImageDynamic(path: bgDynamicImageString);
  }

  void _getClearBgImage() => isDayCurrent
      ? _setFileImage(clearImageList[0][0])
      : _setFileImage(clearImageList[1][0]);

  void _getThunderstormBgImage() {
    switch (_currentCondition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':

      default:
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

// TODO get better overcast picture for day time
  void _getCloudyBgImage() {
    _setFileImage(cloudyImageList[0][0]);
  }

  void _getRainBgImagePath() {
    _setFileImage(rainImageList[0][1]);
  }

  void _getWindBgImagePath() {
    switch (_currentCondition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        bgDynamicImageString = earthFromSpace;
        update();

        break;
      default:
    }
  }

  void _getSnowBgImagePath() {
    switch (_currentCondition) {
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

      default:

      // throw '_getSnowImagePath function failing on condition: $_currentCondition ';
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
      // image = File(pickedFile.path);
      _setBgImage(pickedFile.path);
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

  void selectImageFromAppGallery(String image) {
    bgUserImageString = image;
    bgImageFromWeatherGallery = true;
    bgImageDynamic = false;
    bgImageFromDeviceGallery = false;

    _setBgImage(bgUserImageString);
    // update();
    StorageController.to.storeBgImageAppGallery(path: bgUserImageString);
    StorageController.to.storeUserImageSettings(
        imageDynamic: bgImageDynamic,
        device: bgImageFromDeviceGallery,
        appGallery: bgImageFromWeatherGallery);

    bgImageUpdatedSnackbar();
  }

  void handleDynamicSwitchTap() {
    if (bgImageDynamic) {
      explainDynamicSwitch(context: Get.context);
      bgImageDynamic = true;
    } else {
      bgImageDynamic = true;
      bgImageFromDeviceGallery = false;
      bgImageFromWeatherGallery = false;
      bgDynamicImageString = StorageController.to.restoreBgImageDynamic();
      _setBgImage(bgDynamicImageString);

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

    bgDynamicImageString = StorageController.to.restoreBgImageDynamic();

    bgUserImageString = StorageController.to.restoreBgImageAppGallery();

    if (bgImageDynamic) {
      _setBgImage(bgDynamicImageString);
    } else if (bgImageFromWeatherGallery) {
      _setBgImage(bgUserImageString);
    } else if (bgImageFromDeviceGallery) {
      final path = StorageController.to.restoreDeviceImagePath();
      _setBgImage(path);
    }
  }
}
