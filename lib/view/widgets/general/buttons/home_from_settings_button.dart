import 'package:epic_skies/services/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFromSettingsButton extends GetView<NavigationController> {
  const HomeFromSettingsButton();
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Home',
      onPressed: () => controller.goToHomeTab(),
      icon: Icons.home,
    ).paddingOnly(bottom: 2.5);
  }
}
