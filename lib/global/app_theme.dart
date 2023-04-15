import 'package:black_cat_lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData defaultOpaqueBlack = ThemeData(
  indicatorColor: Colors.blueGrey[300],
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
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey[300]),
);

final dialogTheme = DialogTheme(
  backgroundColor: Colors.grey[900],
  titleTextStyle: dialogTitleTextStyle,
  contentTextStyle: dialogContentTextStyle,
);

const dialogTitleTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Roboto',
  fontSize: 18,
  fontWeight: FontWeight.normal,
);

const dialogContentTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Roboto',
  fontSize: 16,
  fontWeight: FontWeight.w300,
);

const dialogActionTextStyle = TextStyle(
  color: Colors.blue,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 17,
);

const iOSContentTextStyle = TextStyle(fontSize: 18);
