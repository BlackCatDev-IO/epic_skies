import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import '../../../services/ticker_controllers/tab_navigation_controller.dart';
import '../../dialogs/settings_dialogs.dart';
import '../../snackbars/snackbars.dart';
import '../../widgets/general/text_scale_factor_clamper.dart';
import 'gallery_image_screen.dart';

class BgImageSettingsScreen extends StatelessWidget {
  static const id = '/bg_settings_screen';

  @override
  Widget build(BuildContext context) => NotchDependentSafeArea(
        child: BlocListener<BgImageBloc, BgImageState>(
          listenWhen: (previous, current) =>
              previous.bgImagePath != current.bgImagePath,
          listener: (context, state) {
            final shouldNavigateToHome = !state.imageSettings.isDynamic;

            if (shouldNavigateToHome) {
              TabNavigationController.to.navigateToHome();

              Snackbars.bgImageUpdatedSnackbar(context);
            }
          },
          child: TextScaleFactorClamper(
            child: Scaffold(
              body: FixedImageContainer(
                imagePath: earthFromSpace,
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
                                BgImageSettingsUpdated(
                                  imageSetting: ImageSettings.dynamic,
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
        ),
      );
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
                BgImageSettingsUpdated(imageSetting: ImageSettings.dynamic),
              );

              Snackbars.bgImageUpdatedSnackbar(context);
            }
          },
        );
      },
    );
  }
}
