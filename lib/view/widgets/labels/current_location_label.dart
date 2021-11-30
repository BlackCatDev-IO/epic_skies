import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'rounded_label.dart';

class CurrentLocationLabel extends StatelessWidget {
  const CurrentLocationLabel();

  @override
  Widget build(BuildContext context) {
    return RoundedLabel(
      label: 'Current Location',
      height: 20.sp,
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      icon: Icon(
        Icons.near_me,
        color: Colors.blue.shade900,
        size: 14.sp,
      ),
    );
  }
}
