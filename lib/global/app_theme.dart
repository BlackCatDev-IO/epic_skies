import 'package:black_cat_lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData defaultOpaqueBlack = ThemeData(
  accentColor: Colors.blueGrey[300],
  dialogBackgroundColor: Colors.white60,
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Colors.blueGrey),
  fontFamily: 'Roboto',
  primaryTextTheme: const TextTheme(bodyText2: kGoogleFontOpenSansCondensed),
  elevatedButtonTheme: ElevatedButtonThemeData(style: roundedWhiteButton),
  cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
  dialogTheme: dialogTheme,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light),
  ),
);

final dialogTheme = DialogTheme(
    backgroundColor: Colors.grey[900],
    titleTextStyle: dialogTitleTextStyle,
    contentTextStyle: dialogContentTextStyle);

const dialogTitleTextStyle = TextStyle(
    color: Colors.white70,
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.normal);

const dialogContentTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'Roboto',
    fontSize: 18,
    fontWeight: FontWeight.w300);

const dialogActionTextStyle = TextStyle(
    color: Colors.blue,
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.w300);
