import 'package:flutter/material.dart';

const roboto = 'Roboto';
const montserrat = 'Montserrat';

const defaultTextStyle = TextStyle(
  color: Colors.white70,
  fontSize: 16,
  fontWeight: FontWeight.w300,
  fontFamily: roboto,
);

final ThemeData epicSkiesTheme = ThemeData(
  useMaterial3: false,
  indicatorColor: Colors.blueGrey[300],
  dialogBackgroundColor: Colors.white60,
  textSelectionTheme:
      const TextSelectionThemeData(selectionColor: Colors.blueGrey),
  fontFamily: roboto,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white12,
      minimumSize: const Size(double.maxFinite, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  ),
  dialogTheme: dialogTheme,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey[300]),
  textTheme: const TextTheme(
    bodyMedium: defaultTextStyle,
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: defaultTextStyle.copyWith(fontSize: 17),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: defaultTextStyle.copyWith(fontSize: 17),
  ),
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
  fontSize: 20,
  fontWeight: FontWeight.w300,
);

const dialogActionTextStyle = TextStyle(
  color: Colors.blue,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
  fontSize: 20,
);

const iOSContentTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
);
