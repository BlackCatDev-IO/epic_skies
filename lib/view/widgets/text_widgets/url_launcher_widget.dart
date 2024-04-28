import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/url_launcher.dart/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlLauncherTextWidget extends StatelessWidget {
  const UrlLauncherTextWidget({
    required this.url,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.showUnderline = true,
    super.key,
  });

  final String url;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => UrlLauncher.launchInBrowser(url: url),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: Colors.blue,
          decoration: showUnderline ? TextDecoration.underline : null,
          fontWeight: fontWeight,
        ),
      ).paddingSymmetric(vertical: 10),
    );
  }
}
