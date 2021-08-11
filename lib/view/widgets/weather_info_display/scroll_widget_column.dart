import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'hourly_widgets/hourly_detailed_row.dart';

class ScrollWidgetColumn extends StatelessWidget {
  final int temp;
  final String time, iconPath;
  final num precipitation;
  final String? month, date;
  final VoidCallback? onPressed;

  const ScrollWidgetColumn(
      {required this.temp,
      required this.time,
      required this.precipitation,
      required this.iconPath,
      this.month,
      this.date,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (month == null)
            MyTextWidget(
              text: time,
              fontSize: 10.5.sp,
              color: Colors.blueAccent[100],
            )
          else
            ScrollColumnDateWidget(month: month!, date: date!, time: time),
          TempWidget(temp: temp),
          Image(
            width: 4.h,
            image: AssetImage(iconPath),
          ),
          MyTextWidget(
            text: ' $precipitation%',
            fontSize: 10.sp,
            color: Colors.white54,
          ),
        ],
      ).paddingSymmetric(horizontal: 9),
    );
  }
}

class TempWidget extends StatelessWidget {
  final int temp;

  const TempWidget({
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        sizedBox10Wide,
        MyTextWidget(
          text: '$temp',
          fontSize: 11.5.sp,
          color: Colors.blueGrey[100],
        ),
        MyTextWidget(
          text: deg,
          fontSize: 11.sp,
          color: Colors.white70,
        ),
      ],
    );
  }
}

class ScrollColumnDateWidget extends StatelessWidget {
  final String month, date, time;

  const ScrollColumnDateWidget(
      {required this.date, required this.month, required this.time});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: time,
          color: Colors.blueAccent[100],
          fontSize: 10.5.sp,
        ),
        const SizedBox(height: 5),
        MyTextWidget(
          text: '$month $date',
          fontSize: 11.sp,
          fontWeight: FontWeight.w200,
          color: Colors.yellow[50],
        ),
      ],
    );
  }
}
