import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    required this.size,
    required this.child,
    super.key,
    this.color,
  });

  final Color? color;
  final double size;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color ?? Colors.black38,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
