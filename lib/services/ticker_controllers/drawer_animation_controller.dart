import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ticker_controller.dart';

class DrawerAnimationController extends GetXTickerController {
  static DrawerAnimationController get to => Get.find();

  late AnimationController animationController;
  late Animation<Color?> drawerIconColorAnimation;

  bool canBeDragged = false;

  @override
  void onInit() {
    super.onInit();

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
    animationController.dispose();
    super.onClose();
  }

  void onDragStart(DragStartDetails details) {
    final isDragOpenFromLeft = animationController.isDismissed;
    final isDragCloseFromRight = animationController.isCompleted;
    canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      final delta = details.primaryDelta! / Get.width;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    const _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      final visualVelocity = details.velocity.pixelsPerSecond.dx / Get.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  /// navigation wise the whole app except for the search page basically lives inside the DrawerAnimator
  /// Going home from nested settings pages or search page caused a few errors
  /// depending on where the origin was etc...or didn't delete controllers
  /// this seems to cover all bases and still deletes controllers as expected
  void navigateToHome() {
    Get.until((route) => Get.currentRoute == DrawerAnimator.id);
    animationController.reverse();
  }
}
