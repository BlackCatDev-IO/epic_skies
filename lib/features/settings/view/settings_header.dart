import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/general/epic_skies_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    required this.title,
    required this.backButtonShown,
    super.key,
  });
  final String title;
  final bool backButtonShown;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      height: getIt<AdaptiveLayout>().appBarPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          settingsAppBar(label: title, backButtonShown: backButtonShown)
              .paddingOnly(top: 5),
        ],
      ),
    ).paddingOnly(bottom: 5);
  }
}
