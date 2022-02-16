import 'dart:math' as math;

import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import '../../widgets/general/text_scale_factor_clamper.dart';
import 'settings_main_page.dart';

class DrawerAnimator extends StatefulWidget {
  static const id = '/drawer-animator';

  const DrawerAnimator();

  @override
  State<DrawerAnimator> createState() => _DrawerAnimatorState();
}

class _DrawerAnimatorState extends State<DrawerAnimator> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    AdaptiveLayoutController.to.setAdaptiveHeights(
      context: context,
      hasNotch: IphoneHasNotch.hasNotch,
    );
  }

  @override
  Widget build(BuildContext context) {
    final animationController =
        DrawerAnimationController.to.animationController;

    return NotchDependentSafeArea(
      child: WillPopScope(
        onWillPop: () async =>
            TabNavigationController.to.overrideAndroidBackButton(),
        child: GestureDetector(
          onHorizontalDragStart: DrawerAnimationController.to.onDragStart,
          onHorizontalDragUpdate: DrawerAnimationController.to.onDragUpdate,
          onHorizontalDragEnd: DrawerAnimationController.to.onDragEnd,
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
                        0,
                      ),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                            math.pi / 2 * (1 - animationController.value),
                          ),
                        alignment: Alignment.centerRight,
                        child:
                            TextScaleFactorClamper(child: SettingsMainPage()),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        MediaQuery.of(context).size.width *
                            animationController.value,
                        0,
                      ),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(-math.pi * animationController.value / 2),
                        alignment: Alignment.centerLeft,
                        child: TextScaleFactorClamper(child: HomeTabView()),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
