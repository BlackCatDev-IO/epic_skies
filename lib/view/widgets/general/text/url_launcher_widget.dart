import 'package:epic_skies/services/url_launcher.dart/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class UrlLauncherTextWidget extends StatelessWidget {
  const UrlLauncherTextWidget(
      {required this.url, required this.text, this.fontSize});

  final String url;
  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => UrlLauncher.launchInBrowser(url: url),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 12.sp,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ).paddingSymmetric(vertical: 10),
    );
  }
}
