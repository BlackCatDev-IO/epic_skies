import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../services/app_updates/update_controller.dart';
import '../../widgets/general/text_scale_factor_clamper.dart';
import '../../widgets/text_widgets/url_launcher_widget.dart';

class AboutPage extends StatelessWidget {
  static const id = '/about_page';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: NotchDependentSafeArea(
        child: Scaffold(
          body: FixedImageContainer(
            imagePath: earthFromSpace,
            child: Column(
              children: [
                const SettingsHeader(title: 'About', backButtonShown: true),
                ListView(
                  children: const [
                    HomeFromSettingsButton(),
                    _IconCreditWidget(),
                    AboutWidget(),
                  ],
                ).paddingSymmetric(horizontal: 5).expanded(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  const AboutWidget();

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextWidget(
            text: UpdateController.to.aboutScreenDisplay(),
          ).paddingSymmetric(vertical: 10, horizontal: 15),
        ],
      ),
    );
  }
}

class _IconCreditWidget extends StatelessWidget {
  const _IconCreditWidget();

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
    ).paddingOnly(bottom: 5);
  }
}
