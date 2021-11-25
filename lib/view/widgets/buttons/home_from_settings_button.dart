import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFromSettingsButton extends GetView<DrawerAnimationController> {
  const HomeFromSettingsButton();
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Home',
      onPressed: () => controller.navigateToHome(),
      icon: Icons.home,
    ).paddingOnly(bottom: 2.5);
  }
}
