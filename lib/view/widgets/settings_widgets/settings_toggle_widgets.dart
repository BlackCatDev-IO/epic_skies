// ignore_for_file: public_member_api_docs

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/constants/custom_colors.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/bloc/unit_settings_bloc.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempUnitsToggle extends StatelessWidget {
  const TempUnitsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettings>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            Snackbars.tempUnitsUpdateSnackbar(
              context,
              tempUnitsMetric: !state.tempUnitsMetric,
            );
            context.read<UnitSettingsBloc>().add(TempUnitUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: '${degreeSymbol}F',
                borderColor: state.tempUnitsMetric
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'C',
                borderColor: !state.tempUnitsMetric
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class TimeSettingToggle extends StatelessWidget {
  const TimeSettingToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettings>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.timeUnitsUpdateSnackbar(
              context,
              timeIn24hrs: !state.timeIn24Hrs,
            );
            context.read<UnitSettingsBloc>().add(TimeIn24HoursUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: '12 hrs',
                borderColor: state.timeIn24Hrs
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: '24 hrs',
                borderColor: !state.timeIn24Hrs
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class PrecipitationUnitSettingToggle extends StatelessWidget {
  const PrecipitationUnitSettingToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettings>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.precipitationUnitsUpdateSnackbar(
              context,
              precipInMm: !state.precipInMm,
            );
            context.read<UnitSettingsBloc>().add(PrecipInMmUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: 'in',
                borderColor: state.precipInMm
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'mm',
                borderColor: !state.precipInMm
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class WindSpeedUnitSettingToggle extends StatelessWidget {
  const WindSpeedUnitSettingToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettings>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.windSpeedUnitsUpdateSnackbar(
              context,
              speedInKph: !state.speedInKph,
            );
            context.read<UnitSettingsBloc>().add(SpeedInKphUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: 'mph',
                borderColor: state.speedInKph
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'kph',
                borderColor: !state.speedInKph
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.borderColor,
    required this.label,
    required this.isLeftButton,
  });

  final Color? borderColor;
  final String label;
  final bool isLeftButton;

  static const radius = 30.0;

  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      height: 5,
      width: 17,
      topRight: isLeftButton ? 0 : radius,
      topLeft: isLeftButton ? radius : 0,
      bottomLeft: isLeftButton ? radius : 0,
      bottomRight: isLeftButton ? 0 : radius,
      borderWidth: 0.7,
      borderColor: borderColor,
      child: MyTextWidget(
        text: label,
        fontSize: 10,
        color: Colors.white,
      ).center(),
    );
  }
}
