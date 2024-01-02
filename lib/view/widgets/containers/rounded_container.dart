import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.radius,
    this.color,
    this.child,
    this.height,
    this.width,
    this.borderColor,
    this.padding,
    this.borderWidth,
  });

  final double? radius;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: color ?? Colors.transparent,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1.0,
        ),
      ),
      child: child,
    );
  }
}
