import 'package:flutter/material.dart';

class Snackbars {
  static void showSnackBar(
    BuildContext context, {
    required String text,
  }) {
    final snackbar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static void bgImageUpdatedSnackbar(BuildContext context) {
    showSnackBar(context, text: 'Background Image Updated');
  }
}
