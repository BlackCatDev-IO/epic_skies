import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.buttonColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontColor,
    this.fontFamily,
    this.fontWeight,
  });
  
  final Function onPressed;
  final String label;
  final String? fontFamily;
  final Color? buttonColor;
  final Color? fontColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed as void Function(),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.white24),
        ),
        foregroundColor: buttonColor ?? Colors.transparent,
        disabledForegroundColor:
            buttonColor ?? Colors.transparent.withOpacity(0.38),
        backgroundColor: buttonColor ?? Colors.transparent,
        minimumSize: Size(width ?? double.maxFinite, height ?? 55),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize ?? 15,
          color: fontColor ?? Colors.blueAccent[100],
          fontWeight: fontWeight ?? FontWeight.w200,
          fontFamily: fontFamily ?? 'Roboto',
        ),
      ),
    );
  }
}
