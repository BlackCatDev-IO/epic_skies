import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../temp_display_widget.dart';

class HourlyDetailedRow extends StatelessWidget {
  final String iconPath,
      time,
      feelsLike,
      precipitationProbability,
      precipitationType,
      precipUnit,
      speedUnit,
      condition;

  final int temp, precipitationCode;

  final num precipitationAmount, windSpeed;

  const HourlyDetailedRow({
    @required this.temp,
    @required this.feelsLike,
    @required this.precipitationProbability,
    @required this.iconPath,
    @required this.time,
    @required this.condition,
    @required this.precipitationType,
    @required this.precipitationAmount,
    @required this.precipitationCode,
    @required this.precipUnit,
    @required this.windSpeed,
    @required this.speedUnit,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    final displayCondition = condition.capitalizeFirst;
    final precipitation = precipitationProbability != '0';

    return GetBuilder<ColorController>(
      builder: (controller) => MyCard(
        color: controller.soloCardColor,
        radius: 9,
        child: SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextWidget(text: '     $time' ?? 'fah Q', fontSize: 15)
                      .paddingSymmetric(vertical: 5),
                  MyAssetImage(
                    height: 50,
                    path: iconPath,
                  ),
                  TempDisplayWidget(
                    temp: '    $temp',
                    deg: deg,
                    degFontSize: 20,
                    unitPadding: 1,
                    unitFontsize: 18,
                    tempFontsize: 20,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyTextWidget(text: displayCondition),
                  MyTextWidget(text: 'Feels like: $feelsLike'),
                  MyTextWidget(
                    text: 'Wind Speed: $windSpeed $speedUnit',
                    fontSize: 17,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTextWidget(
                    text: 'Precipitation',
                    fontSize: 15,
                  ),
                  MyTextWidget(text: '  $precipitationProbability%'),
                  MyTextWidget(text: precipitation ? precipitationType : ''),
                  MyTextWidget(
                    text: '$precipitationAmount $precipUnit',
                    fontSize: 17,
                  ),
                ],
              ).paddingSymmetric(horizontal: 15),
            ],
          ),
        ),
      ),
    );
  }
}
