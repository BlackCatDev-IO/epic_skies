import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/constants/custom_colors.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/bloc/unit_settings_bloc.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/view/snackbars/snackbars.dart';
import 'package:epic_skies/view/widgets/containers/partial_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempUnitsToggle extends StatelessWidget {
  const TempUnitsToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitSettingsBloc, UnitSettings>(
      listenWhen: (previous, current) =>
          previous.tempUnitsMetric != current.tempUnitsMetric,
      listener: (context, state) {
        final unit = state.tempUnitsMetric ? 'Celcius' : 'Fahrenheit';
        final text = 'Temperature units updated to $unit';

        Snackbars.showSnackBar(context, text: text);

        context
            .read<LocalWeatherButtonCubit>()
            .updateLocalWeatherButtonUnitSettings(
              tempUnitsMetric: state.tempUnitsMetric,
            );
      },
      buildWhen: (previous, current) =>
          previous.tempUnitsMetric != current.tempUnitsMetric,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<UnitSettingsBloc>().add(TempUnitUpdated()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SettingsButton(
                isLeftButton: true,
                label: '${degreeSymbol}F',
                borderColor: state.tempUnitsMetric
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              _SettingsButton(
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
    return BlocConsumer<UnitSettingsBloc, UnitSettings>(
      listenWhen: (previous, current) =>
          previous.timeIn24Hrs != current.timeIn24Hrs,
      listener: (context, state) {
        final unit = state.timeIn24Hrs ? '24 hrs' : '12 hrs';
        final text = 'Time units updated to $unit';

        Snackbars.showSnackBar(
          context,
          text: text,
        );
      },
      buildWhen: (previous, current) =>
          previous.timeIn24Hrs != current.timeIn24Hrs,
      builder: (context, state) {
        return GestureDetector(
          onTap: () =>
              context.read<UnitSettingsBloc>().add(TimeIn24HoursUpdated()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SettingsButton(
                isLeftButton: true,
                label: '12 hrs',
                borderColor: state.timeIn24Hrs
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              _SettingsButton(
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
    return BlocConsumer<UnitSettingsBloc, UnitSettings>(
      listenWhen: (previous, current) =>
          previous.precipInMm != current.precipInMm,
      listener: (context, state) {
        final unit = state.precipInMm ? 'Millimeters' : 'Inches';
        final text = 'Precipitation units updated to $unit';

        Snackbars.showSnackBar(
          context,
          text: text,
        );
      },
      buildWhen: (previous, current) =>
          previous.precipInMm != current.precipInMm,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<UnitSettingsBloc>().add(PrecipInMmUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SettingsButton(
                isLeftButton: true,
                label: 'in',
                borderColor: state.precipInMm
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              _SettingsButton(
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
    return BlocConsumer<UnitSettingsBloc, UnitSettings>(
      listenWhen: (previous, current) =>
          previous.speedInKph != current.speedInKph,
      listener: (context, state) {
        final unit = state.speedInKph ? 'KPH' : 'MPH';
        final text = 'Wind speed units updated to $unit';

        Snackbars.showSnackBar(
          context,
          text: text,
        );
      },
      buildWhen: (previous, current) =>
          previous.speedInKph != current.speedInKph,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<UnitSettingsBloc>().add(SpeedInKphUpdated());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SettingsButton(
                isLeftButton: true,
                label: 'mph',
                borderColor: state.speedInKph
                    ? CustomColors.unSelectedBorderColor
                    : CustomColors.selectedBorderColor,
              ),
              _SettingsButton(
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

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({
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
      height: 50,
      width: 75,
      topRight: isLeftButton ? 0 : radius,
      topLeft: isLeftButton ? radius : 0,
      bottomLeft: isLeftButton ? radius : 0,
      bottomRight: isLeftButton ? 0 : radius,
      borderWidth: 0.7,
      borderColor: borderColor,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ).center(),
    );
  }
}
