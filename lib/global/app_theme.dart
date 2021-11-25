import 'package:black_cat_lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

final ThemeData defaultOpaqueBlack = ThemeData(
  accentColor: Colors.blueGrey[300],
  dialogBackgroundColor: Colors.white60,
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Colors.blueGrey),
  fontFamily: 'Roboto',
  elevatedButtonTheme: ElevatedButtonThemeData(style: roundedWhiteButton),
  dialogTheme: dialogTheme,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
);

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
