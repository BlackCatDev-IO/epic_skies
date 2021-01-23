import 'package:black_cat_lib/constants.dart';
import 'package:flutter/material.dart';

import '../local_constants.dart';

List<String> themeNames = [
  'Dark Blue (Default)',
  'Black...like your soul',
  'Dark',
  'Light...laaaamme'
];

final List<ThemeData> themeList = [defaultDarkBlue, black, dark, light];

bool darkBlueThemeIsSet = true;

final ThemeData defaultOpaqueBlack = ThemeData(
    primaryColor: kDefaultDarkBlue,
    scaffoldBackgroundColor: Colors.black54,
    accentColor: Colors.blueGrey[300],
    dialogBackgroundColor: Colors.white60,
    textSelectionColor: Colors.blueGrey,
    fontFamily: 'OpenSans',
    primaryTextTheme: const TextTheme(bodyText2: kGoogleFontOpenSansCondensed),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle));

final ThemeData defaultDarkBlue = ThemeData(
    primaryColor: kDefaultDarkBlue,
    scaffoldBackgroundColor: kDefaultDarkBlue2,
    accentColor: kAppBarColor1,
    appBarTheme: const AppBarTheme(color: kDefaultDarkBlue4),
    dialogBackgroundColor: kDefaultDarkBlue4,
    textSelectionColor: kAppBarColor1,
    fontFamily: 'OpenSans',
    primaryTextTheme: const TextTheme(bodyText2: kGoogleFontOpenSansCondensed),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle));

final ThemeData black = ThemeData(
  // primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  accentColor: kDefaultDarkBlue,
  appBarTheme: const AppBarTheme(color: Colors.black26),
  textSelectionColor: Colors.transparent,
  dialogBackgroundColor: Colors.black,
  // dialogBackgroundColor: kDarkModeDefaultColor2,

  // applyElevationOverlayColor: true,
);

final ThemeData dark = ThemeData(
    primaryColor: kDarkModeDefaultColor,
    primaryColorLight: kDarkModeDefaultColor,
    scaffoldBackgroundColor: kDarkModeDefaultColor,
    backgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(color: Colors.black),
    accentColor: kDarkModeDefaultColor,
    textSelectionColor: Colors.transparent,
    dialogBackgroundColor: kDarkModeDefaultColor);
// dialogBackgroundColor: kDarkModeDefaultColor2);

final ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.blue[900]),
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    accentColor: kDefaultDarkBlue,
    dialogBackgroundColor: Colors.white60,
    textSelectionColor: Colors.transparent);

//------------------------------ BUTTONSTYLES ---------------------------------

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.white12,
  minimumSize: const Size(double.maxFinite, 50),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
