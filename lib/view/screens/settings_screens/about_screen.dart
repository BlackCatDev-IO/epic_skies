import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/text_widgets/url_launcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  static const id = '/about_page';

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: NotchDependentSafeArea(
        child: Scaffold(
          body: EarthFromSpaceBGContainer(
            child: Column(
              children: [
                const SettingsHeader(title: 'About', backButtonShown: true),
                ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    HomeFromSettingsButton(),
                    _IconCreditWidget(),
                    _AboutWidget(),
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

class _AboutWidget extends StatelessWidget {
  const _AboutWidget();

  @override
  Widget build(BuildContext context) {
    final currentAppVersion =
        context.read<AppUpdateBloc>().state.currentAppVersion;
    return RoundedContainer(
      color: kBlackCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextWidget(
            text: 'App Version: $currentAppVersion',
          ).paddingSymmetric(vertical: 10, horizontal: 15).center(),
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
      height: 60,
      color: kBlackCustom,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: MyAssetImage(path: fewCloudsDay, height: 34.5),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTextWidget(
                  text: 'All in app weather icons by ',
                  fontSize: 18,
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
    ).paddingOnly(bottom: 5);
  }
}
