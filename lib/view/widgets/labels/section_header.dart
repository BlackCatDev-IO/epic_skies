import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/view/widgets/containers/containers.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.label,
    this.isPartiallyRounded = true,
    super.key,
  });

  final String label;
  final bool isPartiallyRounded;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 17,
            letterSpacing: 5,
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 2);

    if (isPartiallyRounded) {
      return PartialRoundedContainer(
        topLeft: 10,
        topRight: 10,
        color: Colors.black87,
        child: child,
      );
    }

    return RoundedContainer(
      color: Colors.black87,
      child: child,
    );
  }
}
