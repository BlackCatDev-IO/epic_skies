import 'package:black_cat_lib/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class Snackbars {
  static const _fontSize = 16.0;

  static void bgImageUpdatedSnackbar(BuildContext context) {
    const snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Background Image Updated',
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: _fontSize,
        fontWeight: FontWeight.w200,
      ),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void dynamicUpdatedSnackbar(BuildContext context) {
    const snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Background images will now be updated based on current weather',
        fontFamily: 'Roboto',
        fontSize: _fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void tempUnitsUpdateSnackbar(
    BuildContext context, {
    required bool tempUnitsMetric,
  }) {
    final unit = tempUnitsMetric ? 'Celcius' : 'Fahrenheit';

    final snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Temperature units updated to $unit',
        fontFamily: 'Roboto',
        fontSize: _fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static void timeUnitsUpdateSnackbar(
    BuildContext context, {
    required bool timeIn24hrs,
  }) {
    final unit = timeIn24hrs ? '24 hrs' : '12 hrs';
    final snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Time units updated to $unit',
        fontFamily: 'Roboto',
        fontSize: _fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static void precipitationUnitsUpdateSnackbar(
    BuildContext context, {
    required bool precipInMm,
  }) {
    final unit = precipInMm ? 'Millimeters' : 'Inches';
    final snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Precipitation units updated to $unit',
        fontSize: _fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static void windSpeedUnitsUpdateSnackbar(
    BuildContext context, {
    required bool speedInKph,
  }) {
    final unit = speedInKph ? 'KPH' : 'MPH';
    final snackbar = SnackBar(
      content: MyTextWidget(
        text: 'Speed units updated to $unit',
        fontSize: _fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
