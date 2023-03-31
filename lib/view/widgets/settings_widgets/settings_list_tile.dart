import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
    this.settingsSwitch,
  });

  final String title;
  final void Function() onPressed;
  final IconData icon;
  final Widget? settingsSwitch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white54,
      child: RoundedContainer(
        height: 7.5,
        color: kBlackCustom,
        borderColor: Colors.white12,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 3,
            ).paddingOnly(right: 5),
            const SizedBox(width: 7.5),
            MyTextWidget(
              text: title,
              fontSize: 11,
            ),
            const Spacer(),
            if (settingsSwitch == null)
              const Icon(Icons.chevron_right, color: Colors.white24)
            else
              settingsSwitch!,
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    ).paddingSymmetric(vertical: 2.5);
  }
}
