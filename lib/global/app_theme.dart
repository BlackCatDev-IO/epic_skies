import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final dialogTheme = DialogTheme(
  backgroundColor: Colors.grey[900],
  titleTextStyle: dialogTitleTextStyle,
  contentTextStyle: dialogContentTextStyle,
);

final dialogTitleTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Roboto',
  fontSize: 14.sp,
  fontWeight: FontWeight.normal,
);

final dialogContentTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Roboto',
  fontSize: 12.sp,
  fontWeight: FontWeight.w300,
);

final dialogActionTextStyle = TextStyle(
  color: Colors.blue,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
);

final iOSContentTextStyle = TextStyle(fontSize: 11.5.sp);
