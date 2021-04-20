import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../detail_widgets.dart';
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

  final int? temp, precipitationCode;

  final num? precipitationAmount, windSpeed;

  const HourlyDetailedRow({
    required this.temp,
    required this.feelsLike,
    required this.precipitationProbability,
    required this.iconPath,
    required this.time,
    required this.condition,
    required this.precipitationType,
    required this.precipitationAmount,
    required this.precipitationCode,
    required this.precipUnit,
    required this.windSpeed,
    required this.speedUnit,
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
                  MyTextWidget(text: '     $time', fontSize: 15)
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
                  MyTextWidget(text: displayCondition!),
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

class HourlyDetailedRow2 extends StatelessWidget {
  final String iconPath,
      time,
      feelsLike,
      precipitationType,
      precipUnit,
      speedUnit,
      condition;

  final int temp;
  final int? precipitationCode;

  final num? precipitationAmount, precipitationProbability, windSpeed;

  const HourlyDetailedRow2({
    required this.temp,
    required this.feelsLike,
    required this.precipitationProbability,
    required this.iconPath,
    required this.time,
    required this.condition,
    required this.precipitationType,
    required this.precipitationAmount,
    required this.precipitationCode,
    required this.precipUnit,
    required this.windSpeed,
    required this.speedUnit,
  });
  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);

    return MyCard(
      radius: 10,
      child: RoundedContainer(
        color: Colors.black38,
        height: 225,
        borderColor: Colors.black,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedContainer(
                  color: Colors.blueGrey[300],
                  child: MyTextWidget(
                    text: time,
                    color: Colors.black,
                    fontSize: 17,
                  ).paddingSymmetric(horizontal: 10),
                ).paddingOnly(left: 15).center(),
                DetailWidgetHeaderRow(
                  deg: deg,
                  condition: condition,
                  temp: temp,
                  height: 40,
                  iconPath: iconPath,
                  tempFontSize: 25,
                ).paddingOnly(right: 30),
              ],
            ),
            const Divider(color: Colors.white, indent: 10, endIndent: 10),
            DetailRow(category: 'Feels Like: ', value: '$feelsLike$deg'),
            DetailRow(category: 'Wind Speed: ', value: '$windSpeed $speedUnit'),
            DetailRow(
                category: 'Precipitation: $precipitationType',
                value: '$precipitationProbability%'),
          ],
        ),
      ),
    );
  }
}
