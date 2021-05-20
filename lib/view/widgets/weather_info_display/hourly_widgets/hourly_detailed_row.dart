import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final deg = String.fromCharCode($deg);

class HoulyDetailedRow extends StatelessWidget {
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

  const HoulyDetailedRow(
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
    final speedUnit = CurrentWeatherController.to.speedUnitString;
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
                    fontSize: 15,
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
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
