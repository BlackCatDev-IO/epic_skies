import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../my_app_bar.dart';

class SettingsHeader extends GetView<ViewController> {
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
      height: controller.settingsHeaderHeight.h,
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
