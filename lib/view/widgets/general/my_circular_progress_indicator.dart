import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white60),
      height: 55,
      width: 55,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[900]),
      ).center(),
    ).center();
  }
}
