import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/dialogs/settings_dialogs.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../settings/bg_image_settings/image_settings.dart';
import '../ticker_controllers/tab_navigation_controller.dart';

class BgImageController extends GetxController {
  static BgImageController get to => Get.find();
  BgImageController({
    required StorageController storage,
    required Map<String, List<File>> imageFiles,
  })  : _storage = storage,
        imageFileMap = imageFiles;

  final StorageController _storage;

  final Map<String, List<File>> imageFileMap;

  late bool _isDayCurrent;

  late String _currentCondition;

  ImageSettings settings = ImageSettings.dynamic;

  late ImageProvider bgImage;

  /// for random selection of image within an image list sorted by condition
  final _random = math.Random();
  int _randomNumber = 0;

  @override
  void onInit() {
    super.onInit();
    if (!_storage.firstTimeUse()) {
      _initImageSettingsFromStorage();
    }

    _isDayCurrent = _storage.restoreDayOrNight();
  }

  /// TEMP FUNCTION TO QUICKLY CHANGE BG PICS ON BUTTON PUSH WHEN
  /// WORKING ON TEXT CONTRAST STYLING FOR EACH IMAGE
  // void changeBGPic() {
  //   _setBgImage(file: imageFileMap[ImageFileKeys.clearDay]![0]);
  // }

  void _setBgImage({required File file}) {
    if (settings == ImageSettings.dynamic) {
      _storage.storeBgImageDynamicPath(path: file.path);
    }

    bgImage = FileImage(file);

    if (settings != ImageSettings.deviceGallery) {
      ColorController.to.updateTextAndContainerColors(path: file.path);
    }
    update();
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  void updateBgImageOnRefresh({
    required String condition,
    required bool isDay,
  }) {
    final searchIsLocal = _storage.restoreSavedSearchIsLocal();

    _isDayCurrent = isDay;

    _storage.storeDayOrNight(isDay: _isDayCurrent);

    if (searchIsLocal) {
      _storage.storeLocalIsDay(isDay: _isDayCurrent);
    }

    _currentCondition = condition.toLowerCase();
    if (_currentCondition.contains('clear')) {
      return _chooseWeatherImageFromCondition(condition: 'clear');
    }

    if (_currentCondition.contains('cloud') ||
        _currentCondition.contains('fog') ||
        _currentCondition.contains('overcast') ||
        _currentCondition.contains('wind')) {
      return _chooseWeatherImageFromCondition(condition: 'cloudy');
    }

    if (_currentCondition.contains('rain') ||
        _currentCondition.contains('drizzle')) {
      return _chooseWeatherImageFromCondition(condition: 'rain');
    }

    if (_currentCondition.contains('snow') ||
        _currentCondition.contains('ice') ||
        _currentCondition.contains('hail') ||
        _currentCondition.contains('flurries')) {
      return _chooseWeatherImageFromCondition(condition: 'snow');
    }

    if (_currentCondition.contains('storm')) {
      return _chooseWeatherImageFromCondition(condition: 'storm');
    }

    /// This should never happen
    AppDebug.log(
      'Unaccounted Weather Condition: $_currentCondition',
      name: 'BGImageController',
    );

    _setBgImage(file: imageFileMap['clear_day']![0]);
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
      _storage.storeDeviceImagePath(pickedFile.path);
      settings = ImageSettings.deviceGallery;

      _setBgImage(file: image);
      TabNavigationController.to.navigateToHome();
      Snackbars.bgImageUpdatedSnackbar();
    } else {
      // TODO handle this error
      log('No image selected.');
    }

    _storage.storeBgImageSettings(settings);
  }

  void selectImageFromAppGallery({required File imageFile}) {
    settings = ImageSettings.appGallery;

    _setBgImage(file: imageFile);

    _storage.storeBgImageAppGalleryPath(path: imageFile.path);

    _storage.storeBgImageSettings(settings);

    TabNavigationController.to.navigateToHome();

    Snackbars.bgImageUpdatedSnackbar();
  }

  void handleDynamicSwitchTap() {
    if (settings == ImageSettings.dynamic) {
      SettingsDialogs.explainDynamicSwitch();
      settings = ImageSettings.dynamic;
    } else {
      settings = ImageSettings.dynamic;

      final path = _storage.restoreBgImageDynamicPath();
      _setBgImage(file: File(path));

      Snackbars.bgImageUpdatedSnackbar();

      _storage.storeBgImageSettings(settings);
    }
  }

  void _initImageSettingsFromStorage() {
    settings = _storage.restoreBgImageSettings();

    switch (settings) {
      case ImageSettings.appGallery:
        final path = _storage.restoreBgImageAppGalleryPath();
        _setBgImage(file: File(path));
        break;
      case ImageSettings.deviceGallery:
        final path = _storage.restoreDeviceImagePath()!;
        _setBgImage(file: File(path));
        break;
      case ImageSettings.dynamic:
        final path = _storage.restoreBgImageDynamicPath();
        _setBgImage(file: File(path));
        break;
    }
  }
}
