import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFromSettingsButton extends GetView<ViewController> {
  const HomeFromSettingsButton();
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
        title: 'Home',
        onPressed: () => controller.goHomeFromNestedSettingsPage(),
        icon: Icons.home);
  }
}
