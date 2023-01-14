import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../services/view_controllers/adaptive_layout_controller.dart';
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
      height: AdaptiveLayout.appBarPadding.h,
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
