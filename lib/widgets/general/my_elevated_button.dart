import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Function onPressed;
  final Color color, textColor;
  final double height, fontSize;
  final String text;

  const MyElevatedButton(
      {Key key,
      this.onPressed,
      this.textColor,
      this.height,
      this.text,
      this.fontSize,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 70,
      child: ElevatedButton(
          onPressed: onPressed,
          // style: ElevatedButton.styleFrom(
          //   primary: color ?? Colors.white,
          //   minimumSize: const Size(double.maxFinite, 50),
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //   ),
          // ),
          child: MyTextWidget(
            color: textColor,
            text: text,
            fontSize: fontSize,
          )),
    );
  }
}
