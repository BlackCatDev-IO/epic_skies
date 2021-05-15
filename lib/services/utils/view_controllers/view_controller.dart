import 'package:black_cat_lib/constants.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset_image_controllers/bg_image_controller.dart';

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  static ViewController get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                    FONT STYLING FOR DIFFERENT BG IMAGES                    */
/* -------------------------------------------------------------------------- */

  Color bgImageTextColor = Colors.white70;
  Color bgImageParamColor = Colors.white70;
  Color paramValueColor = Colors.white70;
  Color conditionColor = Colors.white70;
  Color soloCardColor = Colors.black54;
  Color layeredCardColor = Colors.black38;
  Color containerColor = Colors.transparent;

  Color appBarColor = Colors.black45;

  FontWeight cityFontWeight = FontWeight.w500;
  FontWeight streetFontWeight = FontWeight.w500;
  FontWeight countryFontWeight = FontWeight.w500;

  void updateBgTextColor(String path) {
    if (path.endsWith(clearNight1)) {
      _setClearNight1Theme();
    } else if (path.endsWith(clearDay1)) {
      _setClearDay1Theme();
    } else if (path.endsWith(earthFromSpace)) {
      _setClearDay1Theme();
    } else if (path.endsWith(clearNight1)) {
      _setClearDay1Theme();
    } else if (path.endsWith(cloudyDay1)) {
      _setClearDay1Theme();
    } else if (path.endsWith(cloudyDaySunset2)) {
      _setcloudyDaySunset2Theme();
    } else if (path.endsWith(rainSadFace1)) {
      _setRainSadFaceTheme();
    } else if (path.endsWith(snowDay1)) {
      _setTextToDark();
    } else if (path.endsWith(snowNight1)) {
      _setClearDay1Theme();
    } else if (path.endsWith(stormNight1)) {
      _setClearDay1Theme();
    } else {
      _setClearDay1Theme();
    }
    debugPrint(path);
  }

  void _setClearDay1Theme() {
    appBarColor = Colors.black26;
    containerColor = Colors.black38;
    bgImageTextColor = Colors.teal[100]!;
    bgImageParamColor = Colors.blueAccent[100]!;
    conditionColor = Colors.teal[100]!;
    paramValueColor = Colors.yellow[50]!;
    update();
  }

  void _setClearNight1Theme() {
    appBarColor = Colors.black12;
    containerColor = Colors.black38;
    bgImageTextColor = Colors.teal[100]!;
    bgImageParamColor = Colors.blueAccent[100]!;
    conditionColor = Colors.teal[100]!;
    paramValueColor = Colors.yellow[50]!;
    update();
  }

  void _setcloudyDay1Theme() {
    containerColor = Colors.black26;
    bgImageTextColor = Colors.blueGrey[50]!;
    bgImageParamColor = Colors.blueAccent[100]!;
    conditionColor = Colors.teal[100]!;
    update();
  }

  void _setcloudyDaySunset2Theme() {
    appBarColor = Colors.black38;
    containerColor = Colors.black38;
    bgImageTextColor = Colors.teal[100]!;
    bgImageParamColor = Colors.yellow[100]!;
    conditionColor = Colors.teal[100]!;
    paramValueColor = Colors.yellow[50]!;
    update();
  }

  void _setTextToDark() {
    containerColor = Colors.black38;

    bgImageTextColor = Colors.black;

    update();
  }

  void _setRainSadFaceTheme() {
    // containerColor = Colors.black54;
    containerColor = kBlackCustom;
    bgImageTextColor = Colors.teal[100]!;
    appBarColor = kBlackCustom;

    bgImageParamColor = Colors.yellow[100]!;
    conditionColor = Colors.teal[100]!;
    paramValueColor = Colors.yellow[50]!;
    update();
  }

/* -------------------------------------------------------------------------- */
/*                               ADAPTIVE LAYOUT                              */
/* -------------------------------------------------------------------------- */

  double appBarPadding = 0.0;
  double forecastWidgetHeight = 0.0;

  void _setAdaptiveHeights() {
    if (screenHeight > 900) {
      appBarPadding = screenHeight * 0.23;
      forecastWidgetHeight = screenHeight * 0.23;
    } else {
      appBarPadding = screenHeight * 0.18;
      forecastWidgetHeight = screenHeight * 0.22;
    }
  }

/* -------------------------------------------------------------------------- */
/*                              ANIMATION & TABS                              */
/* -------------------------------------------------------------------------- */

  late TabController tabController;

  late AnimationController animationController;

  late Animation<Color?> animation;

  bool canBeDragged = false;

  double index = 0;

  final pageController = PageController();

  void jumpToGalleryPage({ImageProvider? image, String? path, int? index}) {
    Get.dialog(SelectedImagePage(image: image, path: path, index: index))
        .then((value) {
      /// ensures scroll controller is deleted and initialized again in case
      /// user hits back button without selecting an image, and then selects an image thumbnail
      Get.delete<ViewController>(tag: 'gallery');
      Get.put<ViewController>(ViewController(), tag: 'gallery');
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index!);
      }
    });
  }

  void goHomeFromNestedSettingsPage() {
    if (Get.isSnackbarOpen!) {
      Get.back();
      Get.back();
      animationController.reverse();
    } else {
      Get.to(() => const CustomAnimatedDrawer());
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
      final delta = details.primaryDelta! / screenWidth;
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
    ).animate(animationController);

    _setAdaptiveHeights();
  }

  @override
  void onClose() {
    tabController.dispose();
    animationController.dispose();
    pageController.dispose();
    debugPrint('ViewController onClose');

    super.onClose();
  }
}
