import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempDisplayWidget extends StatelessWidget {
  const TempDisplayWidget({
    required this.temp,
    required this.deg,
    required this.tempFontsize,
    required this.unitFontsize,
    required this.unitPadding,
    required this.degFontSize,
  });

  final String temp, deg;
  final double? tempFontsize, unitFontsize, unitPadding, degFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: temp, fontSize: tempFontsize),
        const SizedBox(width: 1),
        MyTextWidget(
          text: deg,
          fontSize: degFontSize,
        ),
        const SizedBox(width: 1),
        GetBuilder<CurrentWeatherController>(
          builder: (controller) => MyTextWidget(
            text: controller.tempUnitString,
            fontSize: unitFontsize,
          ),
        ).paddingOnly(
          bottom: unitPadding!,
        ),
      ],
    );
  }
}
