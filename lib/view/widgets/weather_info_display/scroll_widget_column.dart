import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hourly_widgets/hourly_detailed_row.dart';

class ScrollWidgetColumn extends StatelessWidget {
  final int temp;
  final String time, iconPath;
  final num precipitation;
  final String? month, date;

  const ScrollWidgetColumn(
      {required this.temp,
      required this.time,
      required this.precipitation,
      required this.iconPath,
      this.month,
      this.date});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (month == null)
          MyTextWidget(
            text: time,
            fontSize: 16,
            color: Colors.blueAccent[100],
          )
        else
          ScrollColumnDateWidget(month: month!, date: date!, day: time),
        Row(
          children: [
            sizedBox10Wide,
            MyTextWidget(
              text: '$temp',
              fontSize: 18,
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
          fontSize: 14,
          color: Colors.white54,
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}

class ScrollColumnDateWidget extends StatelessWidget {
  final String month, date, day;

  const ScrollColumnDateWidget(
      {required this.date, required this.month, required this.day});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: day,
          color: Colors.blueAccent[100],
          fontSize: 17,
        ),
        const SizedBox(height: 2),
        MyTextWidget(
          text: '$month $date',
          fontSize: 13,
          fontWeight: FontWeight.w200,
          color: Colors.yellow[50],
        ),
      ],
    );
  }
}
