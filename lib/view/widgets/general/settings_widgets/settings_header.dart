import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_app_bar.dart';

class SettingsHeader extends StatelessWidget {
  final String title;
  final bool? backButtonShown;
  const SettingsHeader({
    required this.title,
    this.backButtonShown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      height: screenHeight * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          settingsAppBar(label: title, backButtonShown: backButtonShown)
              .paddingOnly(top: 5),
          const Divider(color: Colors.white60, indent: 30, endIndent: 30)
              .paddingOnly(top: 10),
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
