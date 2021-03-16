import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/material.dart';

class LoginButtonWithIcon extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Icon icon;
  final bool iconIsImage;
  final String imageIcon;

  const LoginButtonWithIcon({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
    this.iconIsImage,
    this.imageIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!iconIsImage)
            icon
          else
            ImageIcon(
              AssetImage(imageIcon),
              color: Colors.black,
            ),
          sizedBox5Wide,
          Text(text, style: kGoogleFontOpenSansCondensed),
        ],
      ),
    );
  }

  Widget weatherIcon() {
    return !iconIsImage
        ? icon
        : ImageIcon(
            AssetImage(imageIcon),
            color: Colors.black,
          );
  }
}

class LoginButtonNoIcon extends StatelessWidget {
  final String text;
  final Function onPressed;

  const LoginButtonNoIcon({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: kGoogleFontOpenSansCondensed),
        ],
      ),
    );
  }
}
