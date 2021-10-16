import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SuntimeWidget extends StatelessWidget {
  const SuntimeWidget(
      {required this.time, required this.isSunrise, required this.onPressed});

  final String time;
  final bool isSunrise;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyTextWidget(
            text: time,
            fontSize: 10.5.sp,
            color: Colors.blueAccent[100],
          ).paddingOnly(top: 2),
          Icon(isSunrise ? Icons.north : Icons.south, color: Colors.yellow),
          Image(
            width: 4.h,
            image: const AssetImage(sunriseIcon),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
