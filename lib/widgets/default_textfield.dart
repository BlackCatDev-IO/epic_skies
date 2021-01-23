import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

import '../local_constants.dart';

class DefaultTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int maxTitleLength;
  final TextEditingController controller;
  final String hintText;
  final Color color;

  const DefaultTextField(
      {Key key,
      this.formKey,
      this.maxTitleLength,
      this.controller,
      this.hintText,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        maxLength: maxTitleLength,
        obscureText: hintText == 'Password' ? true : false,
        style: kGoogleFontOpenSansCondensed.copyWith(
          color: color,
        ),
        validator: (String val) {
          if (val.trim().isEmpty) return 'Task title is required.';
          return null;
        },
        decoration: InputDecoration(
          // fillColor: Colors.red,
          // fillColor: dialogBackgroundColor(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          hintText: hintText,
          hintStyle: kGoogleFontOpenSansCondensed.copyWith(
              fontSize: 19, color: Colors.grey[400]),
          counterText: ' ',
//                            hasFloatingPlaceholder: false,
        ),
      ),
    );
  }
}
