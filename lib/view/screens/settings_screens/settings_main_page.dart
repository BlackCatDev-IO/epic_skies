import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../../widgets/general/settings_widgets/settings_header.dart';
import '../../widgets/general/settings_widgets/settings_list_tile.dart';
import 'about_screen.dart';
import 'bg_settings_screen.dart';
import 'units_screen.dart';

class SettingsMainPage extends GetView<NavigationController> {
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
                padding: EdgeInsets.zero,
                children: [
                  const HomeFromSettingsButton(),
                  // SettingsTile(
                  //     title: 'Notifications',
                  //     onPressed: () {},
                  //     icon: Icons.alarm),
                  SettingsTile(
                    title: 'Unit Settings',
                    onPressed: () => Get.toNamed(UnitsScreen.id),
                    icon: Icons.thermostat,
                  ),
                  SettingsTile(
                    title: 'Background Image Settings',
                    onPressed: () => Get.toNamed(BgImageSettingsScreen.id),
                    icon: Icons.add_a_photo,
                  ),
                  // SettingsTile(
                  //     title: 'Image & Icon Credits',
                  //     onPressed: () => Get.toNamed(ImageCreditScreen.id),
                  //     icon: Icons.photo),
                  SettingsTile(
                    title: 'Contact',
                    onPressed: () async {
                      final email = Email(
                        subject: 'Epic Skies Feedback',
                        recipients: [myEmail],
                      );
                      await FlutterEmailSender.send(email);
                    },
                    icon: Icons.email,
                  ),
                  SettingsTile(
                    title: 'About',
                    onPressed: () => Get.toNamed(AboutPage.id),
                    icon: Icons.info,
                  )
                ],
              ).expanded(),
            ],
          ).paddingSymmetric(horizontal: 5).expanded(),
        ],
      ),
    );
  }
}
