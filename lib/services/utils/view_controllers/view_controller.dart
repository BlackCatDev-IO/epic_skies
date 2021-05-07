import 'dart:io';

import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/screens/settings_screens/gallery_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset_image_controllers/bg_image_controller.dart';

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  static ViewController get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                              ANIMATION & TABS                              */
/* -------------------------------------------------------------------------- */

  late TabController tabController;

  late AnimationController animationController;

  late Animation<Color?> animation;

  bool canBeDragged = false;

  double maxSlide = Get.size.width;
  double index = 0;

  final pageController = PageController();

  void jumpToGalleryPage({ImageProvider? image, String? path, int? index}) {
    Get.dialog(GalleryViewPage(image: image, path: path, index: index));
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index!);
      }
    });
  }

  void goHomeFromNestedSettingPage() {
    if (Get.isSnackbarOpen!) {
      Get.back();
      Get.back();
      animationController.reverse();
    } else {
      Get.back();
      animationController.reverse();
    }
  }

  void previousPage({required int index}) {
    int newIndex = index - 1;
    final length = BgImageController.to.imageFileList.length;

    if (index == 0) {
      newIndex = length - 1;
    }
    if (pageController.hasClients) {
      pageController.jumpToPage(newIndex);
    }
  }

  void nextPage({required int index}) {
    int newIndex = index + 1;
    final length = BgImageController.to.imageFileList.length;

    if (newIndex == length) {
      newIndex = 0;
    }
    if (pageController.hasClients) {
      pageController.jumpToPage(newIndex);
    }
  }

  void onDragStart(DragStartDetails details) {
    final isDragOpenFromLeft = animationController.isDismissed;
    final isDragCloseFromRight = animationController.isCompleted;
    canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      final delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    const _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      final visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(Get.context!).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    pageController.addListener(() {
      index = pageController.page!;
    });

    animation = ColorTween(
      begin: Colors.white38,
      end: Colors.transparent,
    ).animate(animationController)
      ..addListener(() {});
  }

  @override
  void onClose() {
    tabController.dispose();
    animationController.dispose();
    pageController.dispose();
    debugPrint('ViewController onClose');

    super.onClose();
  }

/* -------------------------------------------------------------------------- */
/*                    FONT STYLING FOR DIFFERENT BG IMAGES                    */
/* -------------------------------------------------------------------------- */

  Color bgImageTextColor = Colors.white70;
  Color bgImageFeelsLikeColor = Colors.white70;
  Color bgImageCityColor = Colors.white70;
  Color bgImageStreetColor = Colors.white70;
  Color bgImageConditionColor = Colors.white70;
  Color borderTextColor = Colors.white70;
  Color soloCardColor = Colors.black54;
  Color layeredCardColor = Colors.black38;

  Color appBarColor = Colors.black45;

  bool textIsDark = false;

  bool textBorder = false;

  void updateBgTextColor(File file) {
    // TODO: Update this with new images
    final path = file.path;

    if (path.endsWith(clearNight1)) {
      _setTextToLight();
      debugPrint(clearNight1);
    } else if (path.endsWith(clearDay1)) {
      _setTextToLight();
      debugPrint(clearDay1);
    } else if (path.endsWith(earthFromSpace)) {
      _setTextToLight();
      debugPrint(earthFromSpace);
    } else if (path.endsWith(clearNight1)) {
      _setTextToLight();
      debugPrint(clearNight1);
    } else if (path.endsWith(cloudyDay1)) {
      _setTextToLight();
      debugPrint(cloudyDay1);
    } else if (path.endsWith(cloudyDaySunset2)) {
      _setcloudyDaySunset2Theme();
      debugPrint(cloudyDaySunset2);
    } else if (path.endsWith(cloudyDayPalmTree3)) {
      _setRainSadFaceTheme();
      debugPrint(cloudyDayPalmTree3);
    } else if (path.endsWith(rainSadFace1)) {
      _setTextToDark();
      debugPrint(rainSadFace1);
    } else if (path.endsWith(snowDay1)) {
      _setTextToLight();
      debugPrint(snowDay1);
      _setTextToDark();
    } else if (path.endsWith(snowNight1)) {
      _setTextToLight();
      debugPrint(snowNight1);
    } else if (path.endsWith(stormNight1)) {
      _setTextToLight();
      debugPrint(stormNight1);
    } else {
      _setTextToLight();
    }
  }

  void _setTextToDark() {
    textBorder = true;
    borderTextColor = Colors.white70;

    bgImageTextColor = Colors.black;
    bgImageFeelsLikeColor = Colors.black;
    bgImageCityColor = Colors.black;
    bgImageStreetColor = Colors.black;
    bgImageConditionColor = Colors.black;
    textIsDark = true;
    update();
  }

  void _setcloudyDaySunset2Theme() {
    textBorder = false;
    borderTextColor = Colors.white70;

    bgImageTextColor = Colors.black;
    bgImageFeelsLikeColor = Colors.black;
    bgImageCityColor = Colors.black;
    bgImageStreetColor = Colors.black;
    bgImageConditionColor = Colors.black;
    textIsDark = true;
    update();
  }

  void _setTextToLight() {
    textBorder = false;
    appBarColor = Colors.black38;
    bgImageTextColor = Colors.white70;
    bgImageFeelsLikeColor = Colors.white70;
    bgImageCityColor = Colors.white70;
    bgImageStreetColor = Colors.white70;
    bgImageConditionColor = Colors.white70;
    textIsDark = false;
    update();
  }

  void _setRainSadFaceTheme() {
    textBorder = true;
    appBarColor = kBlackCustom;
    soloCardColor = Colors.black54;
    layeredCardColor = Colors.black38;
    borderTextColor = Colors.white70;

    bgImageTextColor = Colors.black;
    bgImageFeelsLikeColor = Colors.black;
    bgImageCityColor = Colors.black;
    bgImageStreetColor = Colors.black;
    bgImageConditionColor = Colors.black;
    textIsDark = true;
    update();
  }
}
