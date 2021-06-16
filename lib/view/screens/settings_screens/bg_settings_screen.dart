import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'gallery_image_screen.dart';

class BgImageSettingsScreen extends GetView<BgImageController> {
  static const id = 'bg_settings_screen';

  @override
  Widget build(BuildContext context) => ViewController.to.iPhoneHasNotch
      ? const BgSettingsScreen()
      : const SafeArea(child: BgSettingsScreen());
}

class BgSettingsScreen extends GetView<BgImageController> {
  const BgSettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpace,
        child: Column(
          children: [
            const SettingsHeader(title: 'BG Settings', backButtonShown: true),
            Column(
              children: [
                const HomeFromSettingsButton(),
                SettingsTile(
                    title: 'Dynamic (based on current weather)',
                    settingsSwitch: const DynamicImageSwitch(),
                    onPressed: () => controller.handleDynamicSwitchTap(),
                    icon: Icons.brightness_6),
                SettingsTile(
                  title: 'Select image from your device',
                  onPressed: () => controller.selectImageFromDeviceGallery(),
                  icon: Icons.add_a_photo,
                ),
                SettingsTile(
                  title: 'Select from Epic Skies weather image gallery',
                  onPressed: () => Get.to(() => WeatherImageGallery()),
                  icon: Icons.photo,
                ),
              ],
            ).paddingSymmetric(horizontal: 12).expanded(),
          ],
        ),
      ),
    );
  }
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
