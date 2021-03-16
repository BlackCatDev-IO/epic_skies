import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  ScrollController scrollController;
  final pageController = PageController();

  double alignment = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  AnimationController animationController;
  bool canBeDragged = false;
  double maxSlide = Get.size.width;

  void scrollToIndex(int index) => itemScrollController.scrollTo(
      index: index,
      alignment: alignment,
      duration: const Duration(milliseconds: 200));

  void onDragStart(DragStartDetails details) {
    final isDragOpenFromLeft = animationController.isDismissed;
    final isDragCloseFromRight = animationController.isCompleted;
    canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      final delta = details.primaryDelta / maxSlide;
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
          MediaQuery.of(Get.context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
    scrollController = ScrollController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    animationController.dispose();
    debugPrint('ViewController onClose');

    super.onClose();
  }
}
