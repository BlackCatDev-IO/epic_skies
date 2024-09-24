import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:flutter/material.dart';

class HomeFromSettingsButton extends StatelessWidget {
  const HomeFromSettingsButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Home',
      onPressed: () {
        getIt<TabNavigationController>().navigateToHome(context);
        Navigator.of(context).pop();
      },
      icon: Icons.home,
    ).paddingOnly(bottom: 2.5);
  }
}
