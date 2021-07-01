import 'dart:math' as math;
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/widgets/general/notch_dependent_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_main_page.dart';

final localScreenwidth = Get.size.width;

class DrawerAnimator extends GetView<ViewController> {
  static const id = '/drawer-animator';

  const DrawerAnimator();

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'post responsive wrapper mediaQuery sizes width: ${MediaQuery.of(context).size.width} height: ${MediaQuery.of(context).size.height}');
    final animationController = controller.animationController;
    return NotchDependentSafeArea(
      child: GestureDetector(
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
                    offset: Offset(
                        MediaQuery.of(context).size.width *
                            (animationController.value - 1),
                        0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            math.pi / 2 * (1 - animationController.value)),
                      alignment: Alignment.centerRight,
                      child: SettingsMainPage(),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                        MediaQuery.of(context).size.width *
                            animationController.value,
                        0),
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
      ),
    );
  }
}
