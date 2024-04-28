import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({
    required this.temp,
    super.key,
  });

  final int temp;

  static const _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
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
