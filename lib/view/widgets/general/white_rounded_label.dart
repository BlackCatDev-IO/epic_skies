import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhiteRoundedLabel extends StatelessWidget {
  final String label;

  const WhiteRoundedLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 175,
      radius: 25,
      color: Colors.white54,
      child: MyTextWidget(text: label, fontSize: 16, color: Colors.black)
          .center()
          .paddingSymmetric(vertical: 2.5, horizontal: 10),
    );
  }
}
