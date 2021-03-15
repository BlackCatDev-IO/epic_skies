import 'dart:math' as math;

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import 'my_app_bar.dart';

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
                    icon: Icon(Icons.menu),
                    onPressed: controller.toggle,
                    color: Colors.white38,
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
  final List<Widget> widgetList = [];
  @override
  Widget build(BuildContext context) {
    return FixedImageContainer(
      image: earthFromSpacePortrait,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          settingsAppBar(label: 'Settings'),
          const Divider(color: Colors.white60, indent: 40, endIndent: 40),
          ListView(
            children: [
              CustomListTile(
                  title: 'Home',
                  onPressed: controller.toggle,
                  icon: Icons.home),
              CustomListTile(
                  title: 'Notifications', onPressed: () {}, icon: Icons.alarm),
              CustomListTile(
                title: 'Unit Settings',
                onPressed: () {
                  Get.to(() => UnitsScreen());
                },
                icon: Icons.add,
              ),
              CustomListTile(
                  title: 'Background Image Settings',
                  onPressed: () {
                    Get.to(() => BgSettingsScreen());
                  },
                  icon: Icons.add_a_photo),
              CustomListTile(
                  title: 'Image Credits', onPressed: () {}, icon: Icons.photo),
              CustomListTile(
                  title: 'Contact',
                  onPressed: () async {
                    final Email email = Email(
                      subject: 'Epic Skies Feedback',
                      recipients: ['loren@blackcataudio.net'],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  },
                  icon: Icons.email),
            ],
          ).expanded(),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;
  final Widget settingsSwitch;
  final double height;

  const CustomListTile(
      {Key key,
      this.title,
      this.onPressed,
      this.icon,
      this.settingsSwitch,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white54,
      child: RoundedContainer(
        height: height ?? 70,
        color: blackCustom,
        borderColor: Colors.white12,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 25,
            ),
            const SizedBox(width: 7.5),
            MyTextWidget(
              text: title,
              fontSize: 17,
              // color: Colors.blue,
            ).paddingAll(8),
            // Expanded(flex: 1, child: Container()),
            const Spacer(),
            settingsSwitch == null
                ? Container()
                : settingsSwitch.paddingOnly(right: 5),
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    ).paddingSymmetric(vertical: 5);
  }
}
