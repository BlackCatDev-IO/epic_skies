import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gallery_image_screen.dart';

class BgImageSettingsScreen extends GetView<BgImageController> {
  static const id = '/bg_settings_screen';

  @override
  Widget build(BuildContext context) => NotchDependentSafeArea(
        child: Scaffold(
          body: FixedImageContainer(
            imagePath: earthFromSpace,
            child: Column(
              children: [
                const SettingsHeader(
                  title: 'Image Settings',
                  backButtonShown: true,
                ),
                Column(
                  children: [
                    const HomeFromSettingsButton(),
                    SettingsTile(
                      title: 'Dynamic (based on current weather)',
                      settingsSwitch: const DynamicImageSwitch(),
                      onPressed: () => controller.handleDynamicSwitchTap(),
                      icon: Icons.brightness_6,
                    ),
                    SettingsTile(
                      title: 'Select image from your device',
                      onPressed: () =>
                          controller.selectImageFromDeviceGallery(),
                      icon: Icons.add_a_photo,
                    ),
                    SettingsTile(
                      title: 'Select from Epic Skies image gallery',
                      onPressed: () => Get.toNamed(WeatherImageGallery.id),
                      icon: Icons.photo,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 5).expanded(),
              ],
            ),
          ),
        ),
      );
}

class DynamicImageSwitch extends StatelessWidget {
  const DynamicImageSwitch();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BgImageController>(
      builder: (controller) {
        return Switch(
          value: controller.bgImageDynamic,
          activeColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          activeTrackColor: Colors.greenAccent,
          onChanged: (_) => controller.handleDynamicSwitchTap(),
        );
      },
    );
  }
}
