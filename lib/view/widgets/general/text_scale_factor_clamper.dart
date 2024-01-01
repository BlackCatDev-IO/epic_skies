import 'package:flutter/material.dart';

class TextScaleFactorClamper extends StatelessWidget {
  const TextScaleFactorClamper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final textScaler = mediaQueryData.textScaler.clamp(
      minScaleFactor: 1,
      maxScaleFactor: 1,
    );

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: textScaler,
      ),
      child: child,
    );
  }
}
