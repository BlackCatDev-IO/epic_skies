import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_toggle_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../services/settings/unit_settings/bloc/unit_settings_bloc.dart';
import '../../widgets/general/text_scale_factor_clamper.dart';

class UnitsScreen extends StatelessWidget {
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
    return BlocListener<UnitSettingsBloc, UnitSettingsState>(
      listener: (context, state) {
        context
            .read<WeatherBloc>()
            .add(WeatherUnitSettingsUpdate(unitSettings: state.unitSettings));
      },
      child: TextScaleFactorClamper(
        child: NotchDependentSafeArea(
          child: Scaffold(
            body: FixedImageContainer(
              imagePath: earthFromSpace,
              child: Column(
                children: [
                  const SettingsHeader(
                    title: 'Unit Settings',
                    backButtonShown: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeFromSettingsButton(),
                      SettingsToggleRow(
                        label: 'Temp Units',
                        child: TempUnitsToggle(),
                      ),
                      sizedBox5High,
                      SettingsToggleRow(
                        label: 'Precipitation',
                        child: PrecipitationUnitSettingToggle(),
                      ),
                      sizedBox5High,
                      SettingsToggleRow(
                        label: 'Wind Speed',
                        child: WindSpeedUnitSettingToggle(),
                      ),
                      sizedBox5High,
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
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsToggleRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      height: 7.5.h,
      child: Row(
        children: [
          sizedBox5Wide,
          Container(
            child: MyTextWidget(text: label, fontSize: 11.sp)
                .paddingOnly(left: 10),
          ),
          sizedBox10High,
          child,
          sizedBox10Wide,
        ],
      ),
    );
  }
}
