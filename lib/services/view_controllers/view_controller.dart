import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController
    with SingleGetTickerProviderMixin {
  static NavigationController get to => Get.find();

  late TabController tabController;

  late AnimationController animationController;

  late Animation<Color?> drawerIconColorAnimation;

  bool canBeDragged = false;

  double screenHeight = Get.height;
  double screenWidth = Get.width;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    drawerIconColorAnimation = ColorTween(
      begin: Colors.white38,
    ).animate(animationController)
      ..addListener(() => update(['app_bar']));
  }

  @override
  void onClose() {
    tabController.dispose();
    animationController.dispose();
    super.onClose();
  }

/* -------------------------------------------------------------------------- */
/*                              DRAWER ANIMATION                              */
/* -------------------------------------------------------------------------- */

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

  /* -------------------------------------------------------------------------- */
  /*                               TAB NAVIGATION                               */
  /* -------------------------------------------------------------------------- */

  void searchLocalAndHeadToHomeTab() {
    goToHomeTab();
    tabController.animateTo(0);
  }

  /// navigation wise the whole app except for the search page basically lives inside the DrawerAnimator
  /// Going home from nested settings pages or search page caused a few errors
  /// depending on where the origin was etc...or didn't delete controllers
  /// this seems to cover all bases and still deletes controllers as expected
  void goToHomeTab() {
    Get.until((route) => Get.currentRoute == DrawerAnimator.id);
    animationController.reverse();
  }

  Future<void> jumpToTab({required int index}) async {
    tabController.animateTo(index);
  }
}
