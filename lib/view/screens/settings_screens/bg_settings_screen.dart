import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/dialogs/settings_dialogs.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BgImageSettingsScreen extends StatelessWidget {
  const BgImageSettingsScreen({super.key});

  static const id = '/bg_settings_screen';

  @override
  Widget build(BuildContext context) {
    return BlocListener<BgImageBloc, BgImageState>(
      listenWhen: (previous, current) =>
          previous.bgImagePath != current.bgImagePath,
      listener: (context, state) {
        final shouldNavigateToHome = !state.imageSettings.isDynamic;

        if (shouldNavigateToHome) {
          GetIt.instance<TabNavigationController>().navigateToHome(context);

          Snackbars.bgImageUpdatedSnackbar(context);
        }
      },
      child: TextScaleFactorClamper(
        child: Scaffold(
          body: EarthFromSpaceBGContainer(
            child: Column(
              children: [
                const SettingsHeader(
                  title: 'Image Settings',
                  backButtonShown: true,
                ),
                Column(
                  children: [
                    const HomeFromSettingsButton(),
                    SettingsTile(
                      title: 'Dynamic (based on current weather)',
                      settingsSwitch: const _DynamicImageSwitch(),
                      onPressed: () {
                        final imageBloc = context.read<BgImageBloc>();
                        if (imageBloc.state.imageSettings.isDynamic) {
                          SettingsDialogs.explainDynamicSwitch(context);
                        } else {
                          imageBloc.add(
                            BgImageInitDynamicSetting(
                              weatherState: context.read<WeatherBloc>().state,
                            ),
                          );

                          Snackbars.bgImageUpdatedSnackbar(context);
                        }
                      },
                      icon: Icons.brightness_6,
                    ),
                    SettingsTile(
                      title: 'Select image from your device',
                      onPressed: () {
                        context
                            .read<BgImageBloc>()
                            .add(BgImageSelectFromDeviceGallery());
                      },
                      icon: Icons.add_a_photo,
                    ),
                    SettingsTile(
                      title: 'Select from Epic Skies image gallery',
                      onPressed: () => Navigator.of(context)
                          .pushNamed(WeatherImageGallery.id),
                      icon: Icons.photo,
                    ),
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

class _DynamicImageSwitch extends StatelessWidget {
  const _DynamicImageSwitch();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BgImageBloc, BgImageState>(
      builder: (context, state) {
        final dynamic = state.imageSettings.isDynamic;
        return Switch(
          value: dynamic,
          activeColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          activeTrackColor: Colors.greenAccent,
          onChanged: (_) {
            final imageBloc = context.read<BgImageBloc>();
            if (state.imageSettings.isDynamic) {
              SettingsDialogs.explainDynamicSwitch(context);
            } else {
              imageBloc.add(
                BgImageInitDynamicSetting(
                  weatherState: context.read<WeatherBloc>().state,
                ),
              );

              Snackbars.bgImageUpdatedSnackbar(context);
            }
          },
        );
      },
    );
  }
}
