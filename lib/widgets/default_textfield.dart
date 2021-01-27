import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final int maxTitleLength;
  final TextEditingController controller;
  final String hintText;
  final Color color;
  final Color borderColor;
  final Function onChanged;

  const DefaultTextField(
      {Key key,
      this.maxTitleLength,
      this.controller,
      this.hintText,
      this.color,
      this.borderColor,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      maxLength: maxTitleLength,
      obscureText: hintText == 'Password' ? true : false,
      style: kGoogleFontOpenSansCondensed.copyWith(
        color: color,
      ),
      decoration: InputDecoration(
        fillColor: Colors.red,
        // fillColor: dialogBackgroundColor(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
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
