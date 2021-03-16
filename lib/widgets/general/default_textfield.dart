import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final int maxTitleLength;
  final TextEditingController controller;
  final String hintText;
  final Color fillColor, borderColor;
  final Function onChanged, onFieldSubmitted, onTap;
  final double borderRadius;

  const DefaultTextField(
      {Key key,
      this.maxTitleLength,
      this.controller,
      this.hintText,
      this.fillColor,
      this.borderColor,
      this.onChanged,
      this.borderRadius,
      this.onFieldSubmitted,
      this.onTap})
      : super(key: key);

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
      onChanged: onChanged as void Function(String),
      onFieldSubmitted: onFieldSubmitted as void Function(String),
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxTitleLength,
      obscureText: obscureText,
      style: kGoogleFontOpenSansCondensed.copyWith(
        color: fillColor,
      ),
      onTap: onTap as void Function(),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          borderSide: BorderSide(color: borderColor ?? Colors.blue),
        ),
        hintText: hintText,
        hintStyle: kGoogleFontOpenSansCondensed.copyWith(
            fontSize: 19, color: Colors.grey[400]),
        counterText: ' ',
      ),
    );
  }
}
