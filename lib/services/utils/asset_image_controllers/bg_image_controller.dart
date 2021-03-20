import 'dart:io';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BgImageController extends GetxController {
  RxString bgDynamicImageString = ''.obs;
  RxString bgUserImageString = ''.obs;
  File image;

  bool isDayCurrent;
  bool forecastIsDay;
  RxBool bgImageDynamic = true.obs;
  RxBool bgImageFromDeviceGallery = false.obs;
  RxBool bgImageFromWeatherGallery = false.obs;
  String _currentCondition;

  @override
  void onInit() {
    super.onInit();
    initBgImageFromStorage();
    _initImageSettingListeners();
  }

/* -------------------------------------------------------------------------- */
/*                           DYNAMIC IMAGE SETTINGS                           */
/* -------------------------------------------------------------------------- */

  Future<void> updateBgImageOnRefresh(String condition) async {
    isDayCurrent = Get.find<WeatherRepository>().isDayCurrent;
    _currentCondition = condition.toLowerCase();

    debugPrint('Update BG Imagecondition: $condition : isDay: $isDayCurrent');
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
        bgDynamicImageString.value = snowyCityStreetPortrait;
        throw 'getImagePath function failing condition: $_currentCondition ';
    }
    Get.find<ColorController>().updateBgText();
    Get.find<StorageController>()
        .storeBgImage(path: bgDynamicImageString.value);
  }

  void _getClearBgImage() => isDayCurrent
      ? bgDynamicImageString.value = clearDay1
      : bgDynamicImageString.value = starryMountainPortrait;

  void _getThunderstormBgImage() {
    switch (_currentCondition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':

      default:
        bgDynamicImageString.value = lightingCropped;
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

// TODO get better overcast picture for day time
  void _getCloudyBgImage() {
    switch (_currentCondition) {
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
      default:
        bgDynamicImageString.value =
            isDayCurrent ? cloudyPortrait : starryMountainPortrait;
      // throw '_getCloudImagePath function failing on main: $_condition ';
    }
  }

  void _getRainBgImagePath() {
    switch (_currentCondition) {
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        bgDynamicImageString.value = earthFromSpacePortrait;
        update();

        break;
      default:
        bgDynamicImageString.value = earthFromSpacePortrait;
        update();

        break;
        throw '_getRainImagePath function failing on condition: $_currentCondition ';
    }
  }

  void _getWindBgImagePath() {
    switch (_currentCondition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        bgDynamicImageString.value = earthFromSpacePortrait;
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
        bgDynamicImageString.value =
            isDayCurrent ? snowPortrait : snowyCityStreetPortrait;
        update();

      // throw '_getSnowImagePath function failing on condition: $_currentCondition ';
    }
  }

/* -------------------------------------------------------------------------- */
/*                           USER SETTING FUNCTIONS                           */
/* -------------------------------------------------------------------------- */

  Future<void> selectImageFromDeviceGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      // TODO handle this error
      debugPrint('No image selected.');
    }
    bgImageFromDeviceGallery(true);
    Get.snackbar(
      '',
      '',
      messageText: const MyTextWidget(text: 'Background Image Updaded')
          .center()
          .paddingOnly(bottom: 15),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.blue,
    );
  }

  void userUpdateBgImageFromAppGallery(String image) {
    bgUserImageString.value = image;
    bgImageFromWeatherGallery(true);
    bgImageDynamic(false);
    // TODO Improve this snackbar
    // Get.snackbar(
    //   '',
    //   '',
    //   margin: EdgeInsets.zero,
    //   padding: EdgeInsets.zero,
    //   borderRadius: 0,
    //   snackStyle: SnackStyle.GROUNDED,
    //   messageText: MyTextWidget(text: 'Background Image Updaded').center(),
    //   // .paddingOnly(bottom: 15),
    //   snackPosition: SnackPosition.BOTTOM,
    //   colorText: Colors.white,
    // );

    bgImageUpdatedSnackbar();
  }

  void handleDynamicSwitchTap() {
    if (bgImageDynamic.value) {
      explainDynamicSwitch(context: Get.context);
      bgImageDynamic(true);
    } else {
      bgImageDynamic(true);
    }
  }

  void _initImageSettingListeners() {
    ever(bgImageFromDeviceGallery, (_) {
      if (bgImageFromDeviceGallery.value) {
        bgImageFromWeatherGallery(false);
        bgImageDynamic(false);
      }
    });
    ever(bgImageDynamic, (_) {
      if (bgImageDynamic.value) {
        dynamicUpdatedSnackbar();
        bgImageFromWeatherGallery(false);
        bgImageFromDeviceGallery(false);
      }
    });
    ever(bgImageFromWeatherGallery, (_) {
      if (bgImageFromWeatherGallery.value) {
        bgImageFromDeviceGallery(false);
        bgImageDynamic(false);
      }
    });
  }

  void initBgImageFromStorage() =>
      bgDynamicImageString.value = Get.find<StorageController>().storedImage();
}
