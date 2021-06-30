import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import '../asset_image_controllers/bg_image_controller.dart';

class CustomColorTheme {
  Color bgImageTextColor;
  Color bgImageParamColor;
  Color paramValueColor;
  Color conditionColor;
  Color soloCardColor;
  Color layeredCardColor;
  Color homeContainerColor;
  Color epicSkiesHeaderFontColor;
  Color roundedLabelColor;
  Color tabTitleColor;

  Color appBarColor;

  CustomColorTheme(
      {required this.bgImageParamColor,
      required this.paramValueColor,
      required this.conditionColor,
      required this.soloCardColor,
      required this.layeredCardColor,
      required this.homeContainerColor,
      required this.epicSkiesHeaderFontColor,
      required this.roundedLabelColor,
      required this.tabTitleColor,
      required this.appBarColor,
      required this.bgImageTextColor});
}

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  static ViewController get to => Get.find();

  double screenHeight = Get.height;
  double screenWidth = Get.width;

/* -------------------------------------------------------------------------- */
/*                    FONT STYLING FOR DIFFERENT BG IMAGES                    */
/* -------------------------------------------------------------------------- */

  CustomColorTheme theme = CustomColorTheme(
      bgImageTextColor: Colors.white70,
      bgImageParamColor: Colors.white70,
      paramValueColor: Colors.white70,
      conditionColor: Colors.white70,
      soloCardColor: Colors.black54,
      layeredCardColor: Colors.black38,
      homeContainerColor: Colors.transparent,
      epicSkiesHeaderFontColor: Colors.blueGrey,
      roundedLabelColor: Colors.white54,
      tabTitleColor: Colors.white60,
      appBarColor: Colors.black45);

  FontWeight cityFontWeight = FontWeight.w500;
  FontWeight streetFontWeight = FontWeight.w500;
  FontWeight countryFontWeight = FontWeight.w500;

  void updateTextAndContainerColors({required String path}) {
    if (path.endsWith(clearDay1)) {
      _setDefaultTheme();
    } else if (path.endsWith(clearNight1)) {
      _setClearNight1Theme();
    } else if (path.endsWith(clearNight2)) {
      _setClearNight2Theme();
    } else if (path.endsWith(cloudyDay1)) {
      _setcloudyDay1Theme();
    } else if (path.endsWith(cloudyDaySunset2)) {
      _setcloudyDaySunset2Theme();
    } else if (path.endsWith(cloudyNight1)) {
      _setcloudyNight1Theme();
    } else if (path.endsWith(cloudyNight2)) {
      _setcloudyNight2Theme();
    } else if (path.endsWith(cloudyNight3)) {
      _setcloudyNight3Theme();
    } else if (path.endsWith(cloudyNight4)) {
      _setcloudyNight4Theme();
    } else if (path.endsWith(rainSadFace1)) {
      _setRainSadFaceTheme();
    } else if (path.endsWith(snowDay1)) {
      _setSnowFlakeTheme();
    } else if (path.endsWith(snowNight1)) {
      _setSnowNight1Theme();
    } else if (path.endsWith(stormNight1)) {
      _setThunderStormNightTheme();
    } else if (path.endsWith(earthFromSpace)) {
      _setDefaultTheme();
    } else {
      _setDefaultTheme();
    }
    debugPrint(path);
    update();
    update(['app_bar']);
  }

  void _setDefaultTheme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black26,
        homeContainerColor: Colors.black26,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: Colors.blueGrey[200]!,
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setClearNight1Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black12,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setClearNight2Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black12,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.65),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: Colors.blueGrey[200]!,
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyDay1Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black45,
        homeContainerColor: Colors.black26,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.teal[100]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.55),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyDaySunset2Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black38,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.yellow[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: kBlackCustom,
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.7),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyNight1Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black38,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.75),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.75),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyNight2Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black12,
        homeContainerColor: Colors.transparent,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.75),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyNight3Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black12,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.7),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.75),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.75),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setcloudyNight4Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black12,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.8),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setSnowFlakeTheme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black26,
        homeContainerColor: const Color.fromRGBO(0, 0, 0, 0.3),
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bgImageParamColor: Colors.yellow[100]!,
        conditionColor: Colors.teal[50]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.725),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setRainSadFaceTheme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: const Color.fromRGBO(0, 0, 0, 0.6),
        homeContainerColor: const Color.fromRGBO(0, 0, 0, 0.45),
        bgImageTextColor: Colors.white,
        bgImageParamColor: Colors.yellow[100]!,
        conditionColor: Colors.white,
        paramValueColor: Colors.white,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.725),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.black54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setSnowNight1Theme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black38,
        homeContainerColor: Colors.black38,
        bgImageTextColor: const Color.fromRGBO(255, 255, 255, 0.8),
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: const Color.fromRGBO(255, 255, 255, 0.8),
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  void _setThunderStormNightTheme() {
    final updatedTheme = CustomColorTheme(
        appBarColor: Colors.black54,
        homeContainerColor: Colors.black38,
        bgImageTextColor: Colors.blueGrey[100]!,
        bgImageParamColor: Colors.blueAccent[100]!,
        conditionColor: Colors.teal[100]!,
        paramValueColor: Colors.yellow[50]!,
        soloCardColor: const Color.fromRGBO(0, 0, 0, 0.7),
        layeredCardColor: Colors.black12,
        roundedLabelColor: Colors.white54,
        epicSkiesHeaderFontColor: Colors.blueGrey[100]!,
        tabTitleColor: Colors.white60);

    theme = updatedTheme;
  }

  /* -------------------------------------------------------------------------- */
  /*                               ADAPTIVE LAOUT                               */
  /* -------------------------------------------------------------------------- */

  late double appBarPadding, appBarHeight, settingsHeaderHeight;

  void _setAppBarHeight() {
    if (IphoneHasNotch.hasNotch) {
      appBarHeight = 14;
      _setNotchPadding();
    } else {
      appBarHeight = 18;
      appBarPadding = 18.5;
      settingsHeaderHeight = 18;
    }
  }

  void _setNotchPadding() {
    if (screenHeight > 900) {
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    } else {
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    }
  }
/* -------------------------------------------------------------------------- */
/*                              ANIMATION & TABS                              */
/* -------------------------------------------------------------------------- */

  late TabController tabController;

  late AnimationController animationController;

  late Animation<Color?> drawerIconColorAnimation;

  bool canBeDragged = false;

  double index = 0;

  final pageController = PageController();

  void jumpToGalleryPage({ImageProvider? image, String? path, int? index}) {
    Get.dialog(SelectedImagePage(image: image!, path: path!, index: index!))
        .then((value) {
      /// ensures scroll controller is deleted and initialized again in case
      /// user hits back button without selecting an image, and then selects an image thumbnail
      Get.delete<ViewController>(tag: 'gallery');
      Get.put<ViewController>(ViewController(), tag: 'gallery');
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  /// navigation wise the whole app except for the search page basically lives inside the DrawerAnimator
  /// Going home from nested settings pages or search page caused a few errors
  /// depending on where the origin was etc...or didn't delete controllers
  /// this seems to cover all bases and still deletes controllers as expected
  void goToHomeTab() {
    Get.until((route) => Get.currentRoute == DrawerAnimator.id);
    animationController.reverse();
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
      final visualVelocity = details.velocity.pixelsPerSecond.dx / screenWidth;

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

    drawerIconColorAnimation = ColorTween(
      begin: Colors.white38,
    ).animate(animationController)
      ..addListener(() => update(['app_bar']));

    _setAppBarHeight();
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
