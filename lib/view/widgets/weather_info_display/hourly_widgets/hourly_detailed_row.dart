import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:hexcolor/hexcolor.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        sizedBox10High,
        Row(
          children: [
            TimeWidget(time: time),
            TempAndIconWidget(temp: temp, iconPath: iconPath),
            sizedBox10Wide,
            ConditionAndWindWidget(
                topText: condition,
                bottomText: '$windSpeed  $speedUnit',
                color: Colors.blueAccent[100]!),
            sizedBox5Wide,
            FeelsLikeWidget(
                temp: '$feelsLike$deg',
                precip: '$precipitationProbability% $precipitationType'),
            const SizedBox(width: 20),
          ],
        ),
        sizedBox5High,
        const Divider(color: Colors.white70),
      ],
    );
  }
}

class TempAndIconWidget extends StatelessWidget {
  const TempAndIconWidget({
    Key? key,
    required this.temp,
    required this.iconPath,
  }) : super(key: key);

  final int temp;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyTextWidget(text: '$temp$deg', fontSize: 21),
          const Spacer(),
          MyAssetImage(path: iconPath, height: 47, width: 47),
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: RoundedContainer(
        width: 55,
        color: Colors.blueGrey[300],
        child: MyTextWidget(
          text: time,
          color: Colors.black,
          fontSize: 15,
        ).center(),
      ).paddingOnly(right: 20),
    );
  }
}

class ConditionAndWindWidget extends StatelessWidget {
  final String? topText, bottomText;
  final Color color;
  final double? fontSize;

  const ConditionAndWindWidget({
    this.topText,
    this.bottomText,
    required this.color,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Column(
        children: [
          MyTextWidget(
            text: topText!,
            color: Colors.blue[300],
            fontSize: 19,
            textAlign: TextAlign.center,
          ),
          sizedBox10High,
          MyTextWidget(
            text: bottomText!,
            fontSize: fontSize ?? 17,
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

class FeelsLikeWidget extends StatelessWidget {
  final String temp, precip;

  const FeelsLikeWidget({required this.temp, required this.precip});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: kGoogleFontOpenSansCondensed.copyWith(
                fontSize: 19, color: HexColor('ffc288')),
            text: 'Feels Like ',
            children: [
              TextSpan(
                text: temp,
                style: kGoogleFontOpenSansCondensed.copyWith(
                    fontSize: 18, color: Colors.white70),
              )
            ],
          ),
        ),
        sizedBox10High,
        MyTextWidget(text: precip, fontSize: 17)
      ],
    );
  }
}
