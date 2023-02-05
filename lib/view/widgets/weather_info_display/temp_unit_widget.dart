import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempUnitWidget extends StatelessWidget {
  const TempUnitWidget({
    super.key,
    required this.textStyle,
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
