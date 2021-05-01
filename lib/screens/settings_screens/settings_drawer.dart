import 'dart:math' as math;
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import '../../global/local_constants.dart';
import '../../widgets/general/settings_widgets/settings_header.dart';
import '../../widgets/general/settings_widgets/settings_list_tile.dart';

class CustomAnimatedDrawer extends GetView<ViewController> {
  static const id = 'custom_animated_drawer';

  const CustomAnimatedDrawer();

  @override
  Widget build(BuildContext context) {
    final animationController = controller.animationController;

    return GestureDetector(
      onHorizontalDragStart: controller.onDragStart,
      onHorizontalDragUpdate: controller.onDragUpdate,
      onHorizontalDragEnd: controller.onDragEnd,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, _) {
          return Material(
            color: Colors.black45,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(
                      controller.maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(
                      controller.maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: HomeTabView(),
                  ),
                ),
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * controller.maxSlide,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: controller.animationController.forward,
                    color: controller.animation.value,
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

class MyDrawer extends GetView<ViewController> {
  @override
  Widget build(BuildContext context) {
    return FixedImageContainer(
      image: earthFromSpace,
      child: Column(
        children: [
          const SettingsHeader(title: 'Settings', backButtonShown: false),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                children: [
                  SettingsTile(
                      title: 'Home',
                      onPressed: controller.animationController.reverse,
                      icon: Icons.home),
                  SettingsTile(
                      title: 'Notifications',
                      onPressed: () {},
                      icon: Icons.alarm),
                  SettingsTile(
                    title: 'Unit Settings',
                    onPressed: () {
                      Get.to(() => UnitsScreen());
                    },
                    icon: Icons.add,
                  ),
                  SettingsTile(
                      title: 'Background Image Settings',
                      onPressed: () {
                        Get.to(() => BgImageSettingsScreen());
                      },
                      icon: Icons.add_a_photo),
                  SettingsTile(
                      title: 'Image Credits',
                      onPressed: () {},
                      icon: Icons.photo),
                  SettingsTile(
                      title: 'Contact',
                      onPressed: () async {
                        final Email email = Email(
                          subject: 'Epic Skies Feedback',
                          recipients: ['loren@blackcataudio.net'],
                        );
                        await FlutterEmailSender.send(email);
                      },
                      icon: Icons.email),
                ],
              ).expanded(),
            ],
          ).paddingSymmetric(horizontal: 10).expanded(),
        ],
      ),
    );
  }
}
