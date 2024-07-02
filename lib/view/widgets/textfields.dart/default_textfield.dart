import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.controller,
    super.key,
    this.maxTitleLength,
    this.hintText,
    this.fillColor,
    this.borderColor,
    this.onChanged,
    this.borderRadius,
    this.onFieldSubmitted,
    this.onTap,
    this.hintSize,
    this.fontSize,
    this.fontFamily,
    this.textColor,
    this.fontWeight,
    this.autoFocus,
    this.obscureText,
    this.suffixIcon,
  });
  
  final int? maxTitleLength;
  final TextEditingController controller;
  final String? hintText;
  final String? fontFamily;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final double? borderRadius;
  final double? hintSize;
  final double? fontSize;
  final bool? autoFocus;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    bool obscureText;
    if (hintText == 'Password') {
      obscureText = true;
    } else {
      obscureText = false;
    }
    return TextFormField(
      controller: controller,
      autofocus: true,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxTitleLength,
      obscureText: obscureText,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w300,
        fontSize: fontSize ?? 20,
      ),
      onTap: onTap,
      decoration: InputDecoration(
        filled: autoFocus ?? false,
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          borderSide: BorderSide(color: borderColor ?? Colors.black),
        ),
        focusedBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintSize ?? 19,
          color: Colors.grey[600],
          fontFamily: fontFamily ?? 'Roboto',
          fontWeight: FontWeight.w200,
        ),
        counterText: '',
        suffixIcon: suffixIcon,
      ),
    );
  }
}
