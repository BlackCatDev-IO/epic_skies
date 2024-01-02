import 'package:flutter/material.dart';

class PartialRoundedContainer extends StatelessWidget {
  const PartialRoundedContainer({
    super.key,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.height,
    this.width,
    this.borderWidth,
    this.color,
    this.borderColor,
    this.child,
  });
  
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? color;
  final Color? borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? 0),
          topRight: Radius.circular(topRight ?? 0),
          bottomLeft: Radius.circular(bottomLeft ?? 0),
          bottomRight: Radius.circular(bottomRight ?? 0),
        ),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1.0,
        ),
      ),
      child: child,
    );
  }
}
