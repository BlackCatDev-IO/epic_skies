import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
          text: degreeSymbol,
          fontSize: 11.sp,
          color: Colors.white70,
        ),
      ],
    );
  }
}
