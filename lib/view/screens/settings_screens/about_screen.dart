import 'package:black_cat_lib/black_cat_lib.dart';

import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_credit_screen.dart';

class AboutPage extends StatelessWidget {
  static const id = '/about_page';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpace,
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
          const MyTextWidget(text: '''
App Version: 0.1.7

Changelog: 

0.1.7 

- replaced location and permissions package

0.1.6

- (Hopefully) fixed location issues on certain android devices where phone gets stuck on loading screen the first time Epic Skies runs on a new device

- Tapping on any day of the Home Screen daily forecast widget now jumps to corresponding day on Daily Tab (Thanks Michelle!)

- Hourly icons now reflect daytime or night time

- App defaults to local search if last search before closing was a remote location
          ''').paddingSymmetric(vertical: 10, horizontal: 15),
        ],
      ),
    );
  }
}
