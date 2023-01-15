import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../global/constants/my_colors.dart';
import '../../../services/settings/unit_settings/bloc/unit_settings_bloc.dart';
import '../../snackbars/snackbars.dart';

class TempUnitsToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            Snackbars.tempUnitsUpdateSnackbar(
              context,
              tempUnitsMetric: !state.unitSettings.tempUnitsMetric,
            );
            context.read<UnitSettingsBloc>().add(TempUnitUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: '${degreeSymbol}F',
                borderColor: state.unitSettings.tempUnitsMetric
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'C',
                borderColor: !state.unitSettings.tempUnitsMetric
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class TimeSettingToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.timeUnitsUpdateSnackbar(
              context,
              timeIn24hrs: !state.unitSettings.timeIn24Hrs,
            );
            context.read<UnitSettingsBloc>().add(TimeIn24HoursUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: '12 hrs',
                borderColor: state.unitSettings.timeIn24Hrs
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: '24 hrs',
                borderColor: !state.unitSettings.timeIn24Hrs
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class PrecipitationUnitSettingToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.precipitationUnitsUpdateSnackbar(
              context,
              precipInMm: !state.unitSettings.precipInMm,
            );
            context.read<UnitSettingsBloc>().add(PrecipInMmUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: 'in',
                borderColor: state.unitSettings.precipInMm
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'mm',
                borderColor: !state.unitSettings.precipInMm
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
            ],
          ),
        );
      },
    ).expanded();
  }
}

class WindSpeedUnitSettingToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitSettingsBloc, UnitSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Snackbars.windSpeedUnitsUpdateSnackbar(
              context,
              speedInKph: !state.unitSettings.speedInKph,
            );
            context.read<UnitSettingsBloc>().add(SpeedInKphUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SettingsButton(
                isLeftButton: true,
                label: 'mph',
                borderColor: state.unitSettings.speedInKph
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
              ),
              SettingsButton(
                isLeftButton: false,
                label: 'kph',
                borderColor: !state.unitSettings.speedInKph
                    ? MyColors.unSelectedBorderColor
                    : MyColors.selectedBorderColor,
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
      height: 5.h,
      width: 17.w,
      topRight: isLeftButton ? 0 : radius,
      topLeft: isLeftButton ? radius : 0,
      bottomLeft: isLeftButton ? radius : 0,
      bottomRight: isLeftButton ? 0 : radius,
      borderWidth: 0.7,
      borderColor: borderColor,
      child: MyTextWidget(
        text: label,
        fontSize: 10.sp,
        color: Colors.white,
      ).center(),
    );
  }
}
