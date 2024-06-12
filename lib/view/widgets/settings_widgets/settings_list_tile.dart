import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.onPressed,
    required this.title,
    required this.icon,
    this.settingsSwitch,
    super.key,
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
        height: 70,
        color: kBlackCustom,
        borderColor: Colors.white12,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white60,
              size: 25,
            ).paddingOnly(right: 10),
            const SizedBox(width: 7.5),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
            ),
            const Spacer(),
            if (settingsSwitch == null)
              const Icon(
                Icons.chevron_right,
                color: Colors.white24,
                size: 30,
              )
            else
              settingsSwitch!,
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    ).paddingSymmetric(vertical: 2.5);
  }
}
