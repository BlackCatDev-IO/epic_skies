import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/settings/view/settings_header.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/misc/staging_updated_string.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/containers/containers.dart';
import 'package:epic_skies/view/widgets/general/apple_weather_logo.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/text_widgets/url_launcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  static const id = '/about_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EarthFromSpaceBGContainer(
        child: Column(
          children: [
            const SettingsHeader(title: 'About', backButtonShown: true),
            const Column(
              children: [
                HomeFromSettingsButton(),
                _AboutWidget(),
                _IconCreditWidget(),
                Spacer(),
                AppleWeatherCredit(),
              ],
            ).paddingSymmetric(horizontal: 5).expanded(),
          ],
        ),
      ),
    );
  }
}

class _AboutWidget extends StatelessWidget {
  const _AboutWidget();

  String _versionString(BuildContext context) {
    final appState = context.read<AppUpdateBloc>().state;
    final currentAppVersion = appState.currentAppVersion;
    final patchNumber = appState.patchVersion;

    var baseVersion = 'App Version: $currentAppVersion';

    if (patchNumber != null) {
      baseVersion = '$baseVersion+$patchNumber';
    }

    return baseVersion;
  }

  @override
  Widget build(BuildContext context) {
    final isStaging = getIt<SystemInfoRepository>().isStaging;
    return RoundedContainer(
      color: kBlackCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _versionString(context),
          ).paddingSymmetric(vertical: 10, horizontal: 15).center(),
          if (isStaging)
            Text(
              stagingBuildString,
              style: const TextStyle(color: Colors.white),
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
            child: Image(
              image: AssetImage(fewCloudsDay),
              height: 34.5,
            ),
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'All in app weather icons by ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                      ),
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
    ).paddingOnly(top: 5);
  }
}
