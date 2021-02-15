import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import 'hourly_forecast_widgets.dart';

class DailyDetailWidget extends StatelessWidget {
  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String sunset;
  final String sunrise;
  final String tempMin;
  final String tempHigh;
  final String tempDay;
  final String tempNight;
  final String feelsLikeDay;
  final String feelsLikeNight;
  final String precipitationProbability;
  final String condition;
  final String precipitationType;
  final int precipitationCode;

  const DailyDetailWidget({
    @required this.iconPath,
    @required this.tempMin,
    @required this.tempHigh,
    @required this.tempDay,
    @required this.tempNight,
    @required this.feelsLikeDay,
    @required this.feelsLikeNight,
    @required this.precipitationProbability,
    @required this.condition,
    @required this.sunset,
    @required this.sunrise,
    @required this.day,
    @required this.precipitationType,
    @required this.precipitationCode,
    @required this.month,
    @required this.year,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    String displayCondition = condition.capitalizeFirst;
    bool precipitation = precipitationCode != 0;

    return MyCard(
      radius: 9,
      child: SizedBox(
        height: 300,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTextWidget(text: '$month $date, $year'),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                dayTempColumn(deg),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyTextWidget(text: displayCondition),
                    MyTextWidget(text: 'Feels like: $feelsLikeDay'),
                  ],
                ).expanded(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyTextWidget(
                      text: 'Precipitation',
                      fontSize: 15,
                    ),
                    MyTextWidget(
                      text: '$precipitationProbability %',
                    ),
                    MyTextWidget(
                      text: precipitation ? precipitationType : '',
                      fontSize: 17,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10).expanded(),
              ],
            ).expanded(),
          ],
        ),
      ),
    );
  }

  Widget dayTempColumn(String deg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyTextWidget(text: '  $day', fontSize: 25),
        MyAssetImage(
          height: 80,
          path: iconPath,
        ),
        TempDisplayWidget(
          temp: '  $tempDay',
          deg: deg,
          fontsize: 30,
        ).center(),
      ],
    ).expanded();
  }
}
