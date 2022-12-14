import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/ticker_controllers/tab_navigation_controller.dart';

class HomeFromSettingsButton extends GetView<TabNavigationController> {
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
