import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsTile extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final IconData? icon;
  final Widget? settingsSwitch;

  const SettingsTile({
    this.title,
    this.onPressed,
    this.icon,
    this.settingsSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function()?,
      splashColor: Colors.white54,
      child: RoundedContainer(
        height: 70,
        color: kBlackCustom,
        borderColor: Colors.white12,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 25,
            ).paddingOnly(right: 5),
            const SizedBox(width: 7.5),
            MyTextWidget(
              text: title!,
              fontSize: 15,
            ),
            const Spacer(),
            if (settingsSwitch == null)
              const Icon(Icons.chevron_right, color: Colors.white24)
            else
              settingsSwitch!,
            sizedBox5Wide
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    ).paddingSymmetric(vertical: 5);
  }
}
