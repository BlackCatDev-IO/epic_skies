import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final int maxTitleLength;
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final Function onChanged;
  final Function onFieldSubmitted;
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
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxTitleLength,
      obscureText: hintText == 'Password' ? true : false,
      style: kGoogleFontOpenSansCondensed.copyWith(
        color: fillColor,
      ),
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
