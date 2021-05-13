import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../detail_widgets.dart';

final deg = String.fromCharCode($deg);

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
            ParamLabelRow(),
          ],
        ),
      ),
    );
  }
}

class ParameterRow extends StatelessWidget {
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

  const ParameterRow(
      {required this.iconPath,
      required this.time,
      required this.feelsLike,
      required this.precipitationType,
      required this.precipUnit,
      required this.speedUnit,
      required this.condition,
      required this.temp,
      this.precipitationCode,
      this.precipitationAmount,
      this.precipitationProbability,
      this.windSpeed});
  @override
  Widget build(BuildContext context) {
    final speedUnit = SettingsController.to.speedUnitString;
    return Container(
      color: kBlackCustom,
      child: Column(
        children: [
          Row(
            children: [
              HourlyDetailSpacer(
                child: RoundedContainer(
                  width: 55,
                  color: Colors.blueGrey[300],
                  child: MyTextWidget(
                    text: time,
                    color: Colors.black,
                    fontSize: 12,
                  ).paddingSymmetric(horizontal: 5).center(),
                ).center(),
              ),
              ParamItem(text: '$temp$deg', color: Colors.amberAccent),
              ParamItem(text: '$feelsLike$deg', color: Colors.amberAccent),
              ParamItem(
                  text: '$windSpeed  $speedUnit',
                  color: Colors.blueAccent[100]!),
              ParamItem(
                  text: '$precipitationProbability% $precipitationType',
                  color: Colors.blue),
            ],
          ),
          const Divider(color: Colors.white, indent: 10, endIndent: 10),
        ],
      ),
    );
  }
}

class ParamItem extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;

  const ParamItem({required this.text, required this.color, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: MyTextWidget(
        text: text,
        color: color,
        fontSize: fontSize ?? 17,
      ),
    );
  }
}

class ParamLabelRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      radius: 5,
      height: 60,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HourlyDetailSpacer(
                child: MyTextWidget(
                  text: 'Time',
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const HourlyDetailSpacer(
                child: MyTextWidget(
                  text: 'Temp',
                  color: Colors.amber,
                  fontSize: 18,
                ),
              ),
              const HourlyDetailSpacer(
                child: MyTextWidget(
                  text: 'Feels Like',
                  color: Colors.amberAccent,
                  fontSize: 18,
                ),
              ),
              HourlyDetailSpacer(
                child: MyTextWidget(
                  text: 'Wind',
                  color: Colors.blueAccent[100],
                  fontSize: 18,
                ),
              ),
              const HourlyDetailSpacer(
                child: MyTextWidget(
                  text: 'Precip',
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 5),
          const Divider(
            color: Colors.white,
            indent: 10,
            endIndent: 10,
            height: 20,
          ),
        ],
      ),
    );
  }
}

class HourlyDetailSpacer extends StatelessWidget {
  final Widget child;

  const HourlyDetailSpacer({required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth / 6.7,
      child: child.center(),
    ).expanded();
  }
}
