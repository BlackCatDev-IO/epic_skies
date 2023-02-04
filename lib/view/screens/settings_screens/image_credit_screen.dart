import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/text_widgets/url_launcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ImageCreditScreen extends StatelessWidget {
  const ImageCreditScreen();

  static const id = '/image_credit_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        imagePath: earthFromSpace,
        child: Column(
          children: [
            const SettingsHeader(title: 'Image Credits', backButtonShown: true),
            const HomeFromSettingsButton().paddingSymmetric(horizontal: 5),
            RoundedLabel(label: 'Icons', fontSize: 14.sp, width: 200)
                .paddingOnly(bottom: 5),
            const IconCreditWidget().paddingSymmetric(horizontal: 5),
            RoundedLabel(label: 'Weather Images', fontSize: 14.sp, width: 200)
                .paddingOnly(top: 5),
            const ImageCreditList(),
          ],
        ),
      ),
    );
  }
}

class IconCreditWidget extends StatelessWidget {
  const IconCreditWidget();

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 7.h,
      color: kBlackCustom,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: MyAssetImage(path: fewCloudsDay, height: 4.5.h),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextWidget(
                  text: '    All in app weather icons by ',
                  fontSize: 13.sp,
                ).paddingSymmetric(vertical: 10),
                const UrlLauncherTextWidget(text: 'Vcloud', url: vcloudIconsUrl)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCreditList extends StatelessWidget {
  const ImageCreditList();

  @override
  Widget build(BuildContext context) {
    final imageFileList = context.read<BgImageBloc>().state.imageFileList;
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      children: [
        for (final file in imageFileList)
          ImageCreditThumbnail(imageFile: File(file))
      ],
    ).paddingSymmetric(vertical: 5, horizontal: 2).expanded();
  }
}

class ImageCreditThumbnail extends StatelessWidget {
  final File imageFile;

  const ImageCreditThumbnail({
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image:
                DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover),
          ),
        ).paddingAll(3.5),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(),
        )
      ],
    );
  }
}

class ImageCreditLabel extends StatelessWidget {
  final ImageCreditModel model;
  const ImageCreditLabel({required this.model});

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
  final String url, label;

  ImageCreditModel({required this.url, required this.label});
}
