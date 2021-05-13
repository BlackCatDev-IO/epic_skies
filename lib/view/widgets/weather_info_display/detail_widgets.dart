import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailWidgetHeaderRow extends StatelessWidget {
  final String deg, condition, iconPath;

  final int temp;

  final double height, tempFontSize;

  const DetailWidgetHeaderRow(
      {required this.deg,
      required this.condition,
      required this.iconPath,
      required this.temp,
      required this.height,
      required this.tempFontSize});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(text: condition),
            MyAssetImage(
              height: height,
              path: iconPath,
            ),
            TempDisplayWidget(
              temp: '  $temp',
              deg: deg,
              degFontSize: 30,
              tempFontsize: tempFontSize,
              unitFontsize: 20,
              unitPadding: 10,
            ),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 10),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String category, value;

  const DetailRow({required this.category, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(text: category, fontSize: 17),
            MyTextWidget(text: value, fontSize: 17, color: Colors.blue[200]),
          ],
        ).paddingSymmetric(horizontal: 15),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}
