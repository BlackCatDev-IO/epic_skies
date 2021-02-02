import 'package:black_cat_lib/constants.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  const DialogButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        onPressed();
      },
      color: kDefaultDarkBlue4,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
