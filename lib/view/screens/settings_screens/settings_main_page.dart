import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/settings/view/settings_header.dart';
import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:epic_skies/services/email_service.dart';
import 'package:epic_skies/view/dialogs/ad_dialogs.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/general_widgets.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsMainPage extends StatelessWidget {
  const SettingsMainPage({super.key});

  static const id = '/settings_main_page';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: EarthFromSpaceBGContainer(
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
                          onPressed: () =>
                              Navigator.of(context).pushNamed(UnitsScreen.id),
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
                            final emailService = EmailService();
      
                            await emailService.sendEmail(context);
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
                            if (state.status.isAdFreePurchased ||
                                state.status.isAdFreeRestored) {
                              return const SizedBox.shrink();
                            }
      
                            return AbsorbPointer(
                              absorbing: state.status.isLoading,
                              child: SettingsTile(
                                title: 'Remove Ads',
                                onPressed: () =>
                                    AdDialogs.confirmBeforeAdFreePurchase(
                                  context,
                                ),
                                icon: Icons.sell,
                              ),
                            );
                          },
                        ),
                        SettingsTile(
                          title: 'Restore purchase',
                          onPressed: () {
                            context
                                .read<AdBloc>()
                                .add(AdFreeRestorePurchase());
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
            ),
          ],
        ),
      ),
    );
  }
}
