import 'package:flutter/material.dart';

class TextScaleFactorClamper extends StatelessWidget {
  const TextScaleFactorClamper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final num constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(1.0, 1.0);

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor as double?,
      ),
      child: child,
    );
  }
}
