import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/global/local_constants.dart';
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
        sizedBox20High,
        Row(
          children: [
            sizedBox10Wide,
            TimeWidget(time: time),
            sizedBox10Wide,
            TempColumn(
                temp: temp,
                feelsLike: '$feelsLike$deg',
                precip: '$precipitationProbability% $precipitationType'),
            sizedBox20Wide,
            MyAssetImage(path: iconPath, height: 47, width: 47),
            sizedBox10Wide,
            ConditionAndWindWidget(
                condition: condition,
                windSpeed: '$windSpeed  $speedUnit',
                color: Colors.blueAccent[100]!),
            PrecipitationWidget(
                precipitationProbability: precipitationProbability,
                precipitationType: precipitationType,
                precipitationAmount: precipitationAmount,
                precipUnit: precipUnit),
            const SizedBox(width: 10),
          ],
        ),
        sizedBox15High,
        const Divider(
          height: 1,
          color: Colors.white70,
        ),
      ],
    );
  }
}

class PrecipitationWidget extends StatelessWidget {
  const PrecipitationWidget({
    required this.precipitationProbability,
    required this.precipitationType,
    required this.precipitationAmount,
    required this.precipUnit,
  });

  final num? precipitationProbability;
  final String precipitationType;
  final num? precipitationAmount;
  final String precipUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: '$precipitationProbability% $precipitationType',
          fontSize: 16,
        ).paddingOnly(left: 10),
        if (precipitationAmount == 0)
          const SizedBox()
        else
          MyTextWidget(
            text: '$precipitationAmount$precipUnit',
            fontSize: 15,
            color: HexColor('ffc288'),
          ),
      ],
    );
  }
}

class TempAndIconWidget extends StatelessWidget {
  const TempAndIconWidget({
    required this.temp,
    required this.iconPath,
  });

  final int temp;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyTextWidget(text: '$temp$deg', fontSize: 18),
          const Spacer(),
          MyAssetImage(path: iconPath, height: 47, width: 47),
        ],
      ),
    );
  }
}

class TempColumn extends StatelessWidget {
  final int temp;
  final String feelsLike, precip;
  const TempColumn(
      {required this.temp, required this.feelsLike, required this.precip});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: '$temp$deg', fontSize: 18),
        sizedBox10High,
        FeelsLikeWidget(temp: feelsLike, precip: precip),
      ],
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
    return RoundedContainer(
      width: 55,
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: time,
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ).center(),
    ).paddingOnly(right: 20);
  }
}

class ConditionAndWindWidget extends StatelessWidget {
  final String condition, windSpeed;
  final Color color;

  const ConditionAndWindWidget({
    required this.condition,
    required this.windSpeed,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextWidget(
            text: condition,
            color: Colors.blue[300],
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
          sizedBox10High,
          MyTextWidget(
            text: windSpeed,
            fontSize: 15,
            fontWeight: FontWeight.w300,
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
            style: TextStyle(
              fontSize: 15,
              color: HexColor('ffc288'),
              fontWeight: FontWeight.w300,
            ),
            text: 'Feels Like ',
            children: [
              TextSpan(
                text: temp,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              )
            ],
          ),
        ),
      ],
    );
  }
}
