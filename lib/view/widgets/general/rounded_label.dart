import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RoundedLabel extends GetView<ViewController> {
  final String label;
  final Color? labelColor;
  final double? fontSize, width;

  const RoundedLabel({
    required this.label,
    this.labelColor,
    this.fontSize,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) {
        return RoundedContainer(
          width: width ?? 175,
          radius: 25,
          color: colorController.theme.roundedLabelColor,
          child: MyTextWidget(
            text: label,
            fontSize: fontSize ?? 11.sp,
            color: colorController.theme.roundedLabelColor == Colors.white54
                ? Colors.black
                : Colors.white70,
          ).center().paddingSymmetric(vertical: 2.5, horizontal: 10),
        );
      },
    );
  }
}
