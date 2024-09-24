import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/bloc/unit_settings_bloc.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/containers/containers.dart';
import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_toggle_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  static const id = '/units_screen';
  @override
  Widget build(BuildContext context) {
    final currentUnitSettings = context.read<WeatherBloc>().state.unitSettings;
    return BlocProvider<UnitSettingsBloc>(
      create: (context) => UnitSettingsBloc(unitSettings: currentUnitSettings),
      child: const _UnitScreenView(),
    );
  }
}

class _UnitScreenView extends StatelessWidget {
  const _UnitScreenView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UnitSettingsBloc, UnitSettings>(
      listener: (context, unitSettings) {
        context.read<WeatherBloc>().add(
              WeatherUnitSettingsUpdate(
                unitSettings: unitSettings,
              ),
            );
      },
      child: TextScaleFactorClamper(
        child: Scaffold(
          body: EarthFromSpaceBGContainer(
            child: Column(
              children: [
                const SettingsHeader(
                  title: 'Unit Settings',
                  backButtonShown: true,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeFromSettingsButton(),
                    SettingsToggleRow(
                      label: 'Temp Units',
                      child: TempUnitsToggle(),
                    ),
                    SizedBox(height: 5),
                    SettingsToggleRow(
                      label: 'Precipitation',
                      child: PrecipitationUnitSettingToggle(),
                    ),
                    SizedBox(height: 5),
                    SettingsToggleRow(
                      label: 'Wind Speed',
                      child: WindSpeedUnitSettingToggle(),
                    ),
                    SizedBox(height: 5),
                    SettingsToggleRow(
                      label: 'Time Format',
                      child: TimeSettingToggle(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    required this.label,
    required this.child,
    super.key,
  });
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      height: 70,
      child: Row(
        children: [
          const SizedBox(width: 5),
          Container(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
              ),
            ).paddingOnly(left: 10),
          ),
          const SizedBox(height: 10),
          child,
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
