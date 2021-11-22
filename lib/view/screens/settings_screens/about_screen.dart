import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/notch_dependent_safe_area.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_credit_screen.dart';

class AboutPage extends StatelessWidget {
  static const id = '/about_page';
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotchDependentSafeArea(
      child: Scaffold(
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
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  const AboutWidget();

  @override
  Widget build(BuildContext context) {
    final appVersion = StorageController.to.lastInstalledAppVersion();
    return RoundedContainer(
      color: kBlackCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextWidget(
            text: '''
App Version: $appVersion

Changelog: 

0.2.0

- (Hopefully) finally fixed endless loading issue on certain phones on first install

0.1.9

- First time loading screen shows indicator of acquiring location

- Back button on Android navigates to home tab instead of out of the app

- Show Dialog on first time running updated app version

- Fix formatting for long multi word city names

- Fix address formatting for UK addresses

- General bug fixes

0.1.8

- Added sunset and sunrise time indicator widgets to hourly forecasts 

- Fixed improper formatting on navigation buttons on Daily page

- Added remote location label for hourly and daily pages

- Added total precipitation to widgets on daily page

- Added icon credit to Vcloud on this page

0.1.7 

- replaced location and permissions package

0.1.6

- (Hopefully) fixed location issues on certain android devices where phone gets stuck on loading screen the first time Epic Skies runs on a new device

- Tapping on any day of the Home Screen daily forecast widget now jumps to corresponding day on Daily Tab (Thanks Michelle!)

- Hourly icons now reflect daytime or night time

- App defaults to local search if last search before closing was a remote location
          ''',
          ).paddingSymmetric(vertical: 10, horizontal: 15),
        ],
      ),
    );
  }
}
