import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({
    required this.temp,
    super.key,
  });

  final int temp;

  static const _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          '$temp',
          style: TextStyle(
            fontSize: _fontSize,
            color: Colors.blueGrey[100],
          ),
        ),
        Text(
          degreeSymbol,
          style: const TextStyle(
            fontSize: _fontSize,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
