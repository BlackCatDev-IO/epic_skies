import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/text_widgets/url_launcher_widget.dart';
import 'package:flutter/material.dart';

class ImageCreditScreen extends StatelessWidget {
  const ImageCreditScreen({super.key});

  static const id = '/image_credit_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EarthFromSpaceBGContainer(
        child: Column(
          children: [
            const SettingsHeader(title: 'Image Credits', backButtonShown: true),
            const HomeFromSettingsButton().paddingSymmetric(horizontal: 5),
            const RoundedLabel(label: 'Icons', fontSize: 14, width: 200)
                .paddingOnly(bottom: 5),
            const IconCreditWidget().paddingSymmetric(horizontal: 5),
            const RoundedLabel(
              label: 'Weather Images',
              fontSize: 14,
              width: 200,
            ).paddingOnly(top: 5),
            const ImageCreditList(),
          ],
        ),
      ),
    );
  }
}

class IconCreditWidget extends StatelessWidget {
  const IconCreditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 7,
      color: kBlackCustom,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Image(
              image: AssetImage(fewCloudsDay),
              height: 4.5,
            ),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTextWidget(
                  text: '    All in app weather icons by ',
                  fontSize: 13,
                ).paddingSymmetric(vertical: 10),
                const UrlLauncherTextWidget(
                  text: 'Vcloud',
                  url: vcloudIconsUrl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCreditList extends StatelessWidget {
  const ImageCreditList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
    ).paddingSymmetric(vertical: 5, horizontal: 2).expanded();
  }
}

class ImageCreditThumbnail extends StatelessWidget {
  const ImageCreditThumbnail({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: height * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File('')),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class ImageCreditLabel extends StatelessWidget {
  const ImageCreditLabel({
    required this.model,
    super.key,
  });
  final ImageCreditModel model;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      child: UrlLauncherTextWidget(url: model.url, text: model.label)
          .paddingSymmetric(horizontal: 5),
    ).paddingOnly(bottom: 5);
  }
}

class ImageCreditModel {
  ImageCreditModel({required this.url, required this.label});
  final String url;
  final String label;
}
