import 'dart:io';
import 'dart:math';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();

  String path = '';

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
    if (bgImageDynamic) {
      StorageController.to.storeBgImageDynamic(path: file.path);
    }
    bgImage = FileImage(file);
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

    for (final dayImage in dayList) {
      final file = File('$path/$dayImage');
      tempDayFileList.add(file);
      imageFileList.add(file);
    }

    for (final nightImage in nightList) {
      final file = File('$path/$nightImage');
      tempNightFileList.add(file);
      imageFileList.add(file);
    }

    _sortImageFiles(
        dayList: tempDayFileList, nightList: tempNightFileList, name: name);
  }

  void _sortImageFiles(
      {List<File> dayList, List<File> nightList, String name}) {
    switch (name) {
      case 'clear':
        clearImageList[0].addAll(dayList);
        clearImageList[1].addAll(nightList);
        break;
      case 'cloudy':
        cloudyImageList[0].addAll(dayList);
        cloudyImageList[1].addAll(nightList);
        break;
      case 'rain':
        rainImageList[0].addAll(dayList);
        rainImageList[1].addAll(nightList);
        break;
      case 'snow':
        snowImageList[0].addAll(dayList);
        snowImageList[1].addAll(nightList);
        break;
      case 'thunder_storm':
        stormImageList[0].addAll(dayList);
        stormImageList[1].addAll(nightList);
        break;
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
        _setFileImage(clearImageList[0][0]);
        throw 'getImagePath function failing condition: $_currentCondition ';
    }

    ColorController.to.updateBgText();
  }

  void _getClearBgImage() {
    if (isDayCurrent) {
      randomNumber = random.nextInt(clearImageList[0].length);
      _setFileImage(clearImageList[0][randomNumber]);
    } else {
      randomNumber = random.nextInt(clearImageList[1].length);
      _setFileImage(clearImageList[1][randomNumber]);
    }
  }

  void _setThunderstormBgImage() {
    _setFileImage(stormImageList[1][0]);
  }

// TODO get better overcast picture for day time
  void _getCloudyBgImage() {
    randomNumber = random.nextInt(cloudyImageList[0].length);
    _setFileImage(cloudyImageList[0][randomNumber]);
  }

  void _getRainBgImagePath() {
    randomNumber = random.nextInt(rainImageList[0].length);
    _setFileImage(rainImageList[0][randomNumber]);
  }

// TODO: find wind images and finish this function
  void _getWindBgImagePath() {}

  void _setSnowBgImage() {
    if (isDayCurrent) {
      randomNumber = random.nextInt(snowImageList[0].length);
      _setFileImage(snowImageList[0][randomNumber]);
    } else {
      randomNumber = random.nextInt(snowImageList[1].length);
      _setFileImage(snowImageList[1][randomNumber]);
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
      _setFileImage(image);
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

  void selectImageFromAppGallery(
      {@required ImageProvider image, String path, String asset}) {
    bgImageFromWeatherGallery = true;
    bgImageDynamic = false;
    bgImageFromDeviceGallery = false;
    bgImage = image;
    update();

    final storeString = path ?? asset;

    StorageController.to.storeBgImageAppGallery(path: storeString);
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

      final path = StorageController.to.restoreBgImageDynamic();
      final file = File(path);
      _setFileImage(file);

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
      bgImage = _setGalleryImageFromStorage();
    } else if (bgImageFromDeviceGallery) {
      final path = StorageController.to.restoreDeviceImagePath();
      bgImage = FileImage(File(path));
    } else {
      bgImage = _restoreDynamicImage();
    }
    update();
  }

  ImageProvider _setGalleryImageFromStorage() {
    final imageString = StorageController.to.restoreBgImageAppGallery();

    ImageProvider tempImage;

    if (imageString.startsWith('/data')) {
      tempImage = FileImage(File(imageString));
    } else {
      tempImage = AssetImage(imageString);
    }
    return tempImage;
  }

  ImageProvider _restoreDynamicImage() {
    final path = StorageController.to.restoreBgImageDynamic();
    return FileImage(File(path));
  }
}
