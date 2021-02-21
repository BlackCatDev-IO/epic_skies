import 'dart:ui';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsDrawer extends StatelessWidget {
  // final tabBarController = Get.find<TabBarController>();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.black26),
      child: Drawer(
        child: Stack(
          children: [
            BlurFilter(
              child: Container(
                decoration: BoxDecoration(color: Colors.black38),
              ),
            ),
            Container(
              child: ListView(
                children: [
                  OBXToggleSwitch(
                      settingsBool:
                          Get.find<SettingsController>().tempUnitsCelcius),
                  DrawerHeader(
                    child: Text(
                      'Preferences',
                      style: kGoogleFontOpenSansCondensed.copyWith(
                          color: Colors.blue, fontSize: 50),
                    ).center(),
                    // ),
                    // CustomListTile(
                    //     title: 'Temp Units', onPressed: () {}, icon: Icons.add),

                    // CustomListTile(
                    //   icon: Icons.color_lens,
                    //   title: 'Themes',
                    //   onPressed: () {
                    //     // MyAlertDialogs().showThemeSelectionDialog(context);
                    //   },
                    // ),
                    // CustomListTile(
                    //     title: 'Notifications',
                    //     onPressed: () {
                    //       // MyAlertDialogs().showNotificationOptions();
                    //     },
                    //     icon: Icons.notifications_active),
                    // ElevatedButton(
                    //   onPressed: () {

                    //   },
                    //   child: Container(
                    //       width: 80,
                    //       height: 30,
                    //       child: Center(child: Text('Erase Timer Box'))),
                    // ).paddingOnly(bottom: 80),
                    // ElevatedButton(
                    //   onPressed: () {

                    //   },
                    //   child: Container(
                    //       width: 80,
                    //       height: 30,
                    //       child: Center(child: Text('Erase Stopwatch Box'))),
                    // ).paddingOnly(bottom: 80)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeSettingsRow extends StatelessWidget {
  final String title;

  const ThemeSettingsRow({this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            child: Card(
              color: primaryColor(context),
              child: Text(title),
            ),
          ),
        )
      ],
    );
  }
}

class NotificationSettingsRow extends StatelessWidget {
  final String title;
  final bool setting;

  const NotificationSettingsRow({Key key, this.title, this.setting})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kGoogleFontOpenSansCondensed.copyWith(
                color: Colors.blue, fontSize: 20),
          ),
          // ObxValue(
          //   (settingsBool) => Switch(
          //       value: settingsController.notificationSound.value,
          //       onChanged: (value) {
          //         settingsController.notificationSound.value = value; // Rx
          //       }),
          //   false.obs,
          // )
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
