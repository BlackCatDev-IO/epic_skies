import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({
    super.key,
    required this.temp,
  });

  final int temp;

  static const _fontSize = 19.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        sizedBox10Wide,
        MyTextWidget(
          text: '$temp',
          fontSize: _fontSize,
          color: Colors.blueGrey[100],
        ),
        MyTextWidget(
          text: degreeSymbol,
          fontSize: _fontSize,
          color: Colors.white70,
        ),
      ],
    );
  }
}
