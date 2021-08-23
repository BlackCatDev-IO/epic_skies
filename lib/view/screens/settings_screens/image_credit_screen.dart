import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/general/text/url_launcher_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:sizer/sizer.dart';

class ImageCreditScreen extends StatelessWidget {
  static const id = '/image_credit_page';
  const ImageCreditScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpace,
        child: Column(
          children: [
            const SettingsHeader(title: 'Image Credits', backButtonShown: true),
            ListView(
              children: const [
                HomeFromSettingsButton(),
                IconCreditWidget(),
              ],
            ).paddingSymmetric(horizontal: 5).expanded(),
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
                        fontSize: 13.sp)
                    .paddingSymmetric(vertical: 10),
                const UrlLauncherTextWidget(text: 'Vcloud', url: vcloudIconsUrl)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCreditWidget extends StatelessWidget {
  const ImageCreditWidget();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
