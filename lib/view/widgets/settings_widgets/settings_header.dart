import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../services/view_controllers/adaptive_layout.dart';
import '../general/my_app_bar.dart';

class SettingsHeader extends StatelessWidget {
  final String title;
  final bool backButtonShown;

  const SettingsHeader({
    required this.title,
    required this.backButtonShown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      height: GetIt.instance<AdaptiveLayout>().appBarPadding.h,
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
