import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hourly_widgets/hourly_detailed_row.dart';

class ScrollWidgetColumn extends StatelessWidget {
  final int temp;
  final String time;
  final num precipitation;
  final String iconPath;

  const ScrollWidgetColumn(
      {required this.temp,
      required this.time,
      required this.precipitation,
      required this.iconPath});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MyTextWidget(
          text: time,
          fontSize: 16,
          fontWeight: FontWeight.w200,
          color: Colors.blueAccent[100],
        ),
        Row(
          children: [
            MyTextWidget(
              text: '$temp',
              fontSize: 19,
              fontWeight: FontWeight.w200,
              color: Colors.blueGrey[50],
            ),
            MyTextWidget(
              text: deg,
              fontSize: 18,
              color: Colors.white70,
            ),
          ],
        ),
        Image(
          width: 40,
          image: AssetImage(iconPath),
        ),
        MyTextWidget(
          text: ' $precipitation%',
          fontSize: 16,
          color: Colors.white54,
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}
