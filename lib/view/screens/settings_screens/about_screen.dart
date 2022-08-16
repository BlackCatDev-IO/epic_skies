import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_updates/update_controller.dart';
import '../../widgets/general/text_scale_factor_clamper.dart';
import 'image_credit_screen.dart';

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
                  children: [
                    const HomeFromSettingsButton(),
                    const IconCreditWidget().paddingOnly(bottom: 5),
                    const AboutWidget(),
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
