import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  const DialogButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: child,
    );
  }
}
