import 'package:black_cat_lib/constants.dart';
import 'package:flutter/material.dart';

final ThemeData defaultOpaqueBlack = ThemeData(
    primaryColor: kDefaultDarkBlue,
    scaffoldBackgroundColor: Colors.black54,
    accentColor: Colors.blueGrey[300],
    dialogBackgroundColor: Colors.white60,
    textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.blueGrey),
    fontFamily: 'OpenSans',
    primaryTextTheme: const TextTheme(bodyText2: kGoogleFontOpenSansCondensed),
    elevatedButtonTheme: ElevatedButtonThemeData(style: roundedWhiteButton),
    dialogTheme: dialogTheme);
