import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/general/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    super.key,
    required this.title,
    required this.backButtonShown,
  });
  final String title;
  final bool backButtonShown;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      height: GetIt.instance<AdaptiveLayout>().appBarPadding,
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
