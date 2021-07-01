import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RoundedLabel extends GetView<ViewController> {
  final String label;
  final Color? labelColor;

  const RoundedLabel({required this.label, this.labelColor});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (_) {
        return RoundedContainer(
          width: 175,
          radius: 25,
          color: controller.theme.roundedLabelColor,
          child: MyTextWidget(
                  text: label,
                  fontSize: 11.sp,
                  color: controller.theme.roundedLabelColor == Colors.white54
                      ? Colors.black
                      : Colors.white70)
              .center()
              .paddingSymmetric(vertical: 2.5, horizontal: 10),
        );
      },
    );
  }
}
