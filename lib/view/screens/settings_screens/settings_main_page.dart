import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/dialogs/ad_dialogs.dart';
import 'package:epic_skies/view/dialogs/error_dialogs.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  static const id = '/settings_main_page';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: TextScaleFactorClamper(
        child: EarthFromSpaceBGContainer(
          child: BlocListener<AdBloc, AdState>(
            listener: (context, state) {
              if (state.status.isError) {
                ErrorDialogs.showDialog(
                  context,
                  Errors.noPurchasesFoundModel,
                );
              }
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    const SettingsHeader(
                      title: 'Settings',
                      backButtonShown: false,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const HomeFromSettingsButton(),
                            SettingsTile(
                              title: 'Unit Settings',
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(UnitsScreen.id),
                              icon: Icons.thermostat,
                            ),
                            SettingsTile(
                              title: 'Background Image Settings',
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(BgImageSettingsScreen.id),
                              icon: Icons.add_a_photo,
                            ),
                            SettingsTile(
                              title: 'Contact',
                              onPressed: () async {
                                final email = Email(
                                  subject: 'Epic Skies Feedback',
                                  recipients: [myEmail],
                                );
                                await FlutterEmailSender.send(email);
                              },
                              icon: Icons.email,
                            ),
                            SettingsTile(
                              title: 'About',
                              onPressed: () =>
                                  Navigator.of(context).pushNamed(AboutPage.id),
                              icon: Icons.info,
                            ),
                            BlocBuilder<AdBloc, AdState>(
                              builder: (context, state) {
                                if (state.status.isAdFreePurchased) {
                                  return const SizedBox.shrink();
                                }

                                return SettingsTile(
                                  title: 'Remove Ads',
                                  onPressed: () =>
                                      AdDialogs.confirmBeforeAdFreePurchase(
                                    context,
                                  ),
                                  icon: Icons.sell,
                                );
                              },
                            ),
                            SettingsTile(
                              title: 'Restore purchase',
                              onPressed: () {
                                final adBloc = context.read<AdBloc>();

                                if (adBloc.state.status.isAdFreePurchased) {
                                  AdDialogs.confirmBeforeAdFreePurchase(
                                    context,
                                  );
                                  return;
                                }

                                adBloc.add(AdFreeRestorePurchase());
                              },
                              icon: Icons.restore,
                            ),
                          ],
                        ).expanded(),
                      ],
                    ).paddingSymmetric(horizontal: 5).expanded(),
                  ],
                ),
                BlocBuilder<AdBloc, AdState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) => state.status.isLoading
                      ? const Loader()
                      : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
