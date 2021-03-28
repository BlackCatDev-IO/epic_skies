import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsTile extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;
  final Widget settingsSwitch;
  final double height;

  const SettingsTile(
      {this.title,
      this.onPressed,
      this.icon,
      this.settingsSwitch,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function(),
      splashColor: Colors.white54,
      child: RoundedContainer(
        height: height ?? 70,
        color: blackCustom,
        borderColor: Colors.white12,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 25,
            ),
            const SizedBox(width: 7.5),
            MyTextWidget(
              text: title,
              fontSize: 17,
              // color: Colors.blue,
            ).paddingAll(8),
            // Expanded(flex: 1, child: Container()),
            const Spacer(),
            if (settingsSwitch == null) Container() else settingsSwitch,
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    ).paddingSymmetric(vertical: 5);
  }
}
