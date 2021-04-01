import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import '../../global/local_constants.dart';
import 'gallery_image_screen.dart';

class BgSettingsScreen extends GetView<BgImageController> {
  static const id = 'bg_settings_screen';

  @override
  Widget build(BuildContext context) {
    final dynamicImageSetting = GetBuilder<BgImageController>(
      builder: (_) {
        return Switch(
          value: controller.bgImageDynamic,
          activeColor: Colors.white,
          activeTrackColor: Colors.greenAccent,
          onChanged: (value) {},
        );
      },
    );

    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpace,
        child: Column(
          children: [
            const SettingsHeader(title: 'BG Settings'),
            Column(
              children: [
                SettingsTile(
                    title: 'Home',
                    onPressed: () => goHomeFromNestedSettingPage(),
                    icon: Icons.home),
                SettingsTile(
                    title: 'Dynamic (based on current weather)',
                    settingsSwitch: dynamicImageSetting,
                    height: 60,
                    onPressed: () => controller.handleDynamicSwitchTap()),

                DefaultButton(
                        label: 'Select image from your device',
                        fontColor: Colors.white70,
                        onPressed: () {
                          controller.selectImageFromDeviceGallery();
                        },
                        fontSize: 20,
                        buttonColor: kBlackCustom)
                    .paddingSymmetric(vertical: 10),

                DefaultButton(
                        label: 'Select from Epic Skies weather image gallery',
                        fontColor: Colors.white70,
                        onPressed: () {
                          Get.to(() => WeatherImageGallery());
                        },
                        fontSize: 20,
                        buttonColor: kBlackCustom)
                    .paddingSymmetric(vertical: 10),
                // const Spacer(),
              ],
            ).paddingSymmetric(horizontal: 12).expanded(),
          ],
        ),
      ),
    );
  }
}
