import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppleWeatherCredit extends StatelessWidget {
  const AppleWeatherCredit({
    super.key,
    this.padding = EdgeInsets.zero,
  });

  final EdgeInsets padding;

  static const _creditColor = Colors.white60;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 19,
      color: _creditColor,
    );
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Weather Info by ',
            style: textStyle,
          ),
          SvgPicture.asset(
            appleLogo,
            width: 18,
            colorFilter: const ColorFilter.mode(
              Colors.white70,
              BlendMode.srcIn,
            ),
            semanticsLabel: 'Apple Logo',
          ).paddingOnly(bottom: 1.5, right: 3),
          const Text(
            'Weather',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
