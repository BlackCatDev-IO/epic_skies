import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotchDependentSafeArea extends StatelessWidget {
  const NotchDependentSafeArea({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetIt.I<AdaptiveLayout>().hasNotchOrDynamicIsland
        ? child
        : SafeArea(child: child);
  }
}
