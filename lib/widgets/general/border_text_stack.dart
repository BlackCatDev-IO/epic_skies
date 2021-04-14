import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class BorderTextStack extends StatelessWidget {
  final String text;
  final double fontSize, height;

  const BorderTextStack({this.text, this.fontSize, this.height});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) {
        return Stack(
          children: [
            if (controller.textBorder)
              Text(
                text,
                style: kGoogleFontOpenSansCondensed.copyWith(
                  fontSize: fontSize ?? 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.5
                    ..color = controller.borderTextColor,
                  height: height,
                ),
              )
            else
              const SizedBox(),
            Text(
              text,
              style: kGoogleFontOpenSansCondensed.copyWith(
                color: controller.bgImageTextColor,
                // color: Colors.white,
                fontSize: fontSize ?? 20,
                height: height,
              ),
            ),
          ],
        );
      },
    );
  }
}
