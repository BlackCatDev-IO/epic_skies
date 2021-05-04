import 'package:epic_skies/screens/settings_screens/gallery_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../asset_image_controllers/bg_image_controller.dart';

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  static ViewController get to => Get.find();

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
}
