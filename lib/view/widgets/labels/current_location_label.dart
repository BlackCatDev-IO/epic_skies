import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:flutter/material.dart';

class CurrentLocationLabel extends StatelessWidget {
  const CurrentLocationLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedLabel(
      label: 'Current Location',
      height: 20,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      icon: Icon(
        Icons.near_me,
        color: Colors.blue.shade900,
        size: 14,
      ),
    );
  }
}
