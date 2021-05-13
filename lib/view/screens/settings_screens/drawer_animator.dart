import 'dart:math' as math;
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'settings_main_page.dart';

class CustomAnimatedDrawer extends GetView<ViewController> {
  static const id = 'custom_animated_drawer';

  const CustomAnimatedDrawer();

  @override
  Widget build(BuildContext context) => IphoneHasNotch.hasNotch
      ? DrawerAnimator()
      : SafeArea(child: DrawerAnimator());
}

class DrawerAnimator extends GetView<ViewController> {
  @override
  Widget build(BuildContext context) {
    final animationController = controller.animationController;

    return GestureDetector(
      onHorizontalDragStart: controller.onDragStart,
      onHorizontalDragUpdate: controller.onDragUpdate,
      onHorizontalDragEnd: controller.onDragEnd,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.black45,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset:
                      Offset(screenWidth * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: SettingsMainPage(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(screenWidth * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: HomeTabView(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
