import 'package:flutter/material.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

class NotchDependentSafeArea extends StatelessWidget {
  final Widget child;
  const NotchDependentSafeArea({required this.child});

  @override
  Widget build(BuildContext context) {
    return IphoneHasNotch.hasNotch ? child : SafeArea(child: child);
  }
}
