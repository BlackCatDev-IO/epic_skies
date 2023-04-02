import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempUnitWidget extends StatelessWidget {
  const TempUnitWidget({
    required this.textStyle,
    super.key,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) =>
          previous.unitSettings.tempUnitsMetric !=
          current.unitSettings.tempUnitsMetric,
      builder: (context, state) {
        final unit = state.unitSettings.tempUnitsMetric ? 'C' : 'F';
        return Text(
          unit,
          style: textStyle,
        );
      },
    );
  }
}

class SpeedUnitWidget extends StatelessWidget {
  const SpeedUnitWidget({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) =>
          previous.unitSettings.speedInKph != current.unitSettings.speedInKph,
      builder: (context, state) {
        final unit = state.unitSettings.speedInKph ? 'kph' : 'mph';
        return Text(
          unit,
          style: textStyle,
        );
      },
    );
  }
}

class PrecipUnitWidget extends StatelessWidget {
  const PrecipUnitWidget({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) =>
          previous.unitSettings.precipInMm != current.unitSettings.precipInMm,
      builder: (context, state) {
        final unit = state.unitSettings.precipInMm ? 'mm' : 'in';
        return Text(
          unit,
          style: textStyle,
        );
      },
    );
  }
}
