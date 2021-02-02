import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import 'hourly_forecast_widgets.dart';

class DailyDetailWidget extends StatelessWidget {
  final String iconPath;
  final String day;
  // final String sunset;
  // final String sunrise;
  final String tempMin;
  final String tempHigh;
  final String tempDay;
  final String tempNight;
  final String feelsLikeDay;
  final String feelsLikeNight;
  final String precipitation;
  final String condition;

  const DailyDetailWidget(
      {@required this.iconPath,
      @required this.tempMin,
      @required this.tempHigh,
      @required this.tempDay,
      @required this.tempNight,
      @required this.feelsLikeDay,
      @required this.feelsLikeNight,
      @required this.precipitation,
      @required this.condition,
      // @required this.sunset,
      // @required this.sunrise,
      @required this.day});

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    String displayCondition = condition.capitalizeFirst;

    return MyCard(
      radius: 9,
      child: SizedBox(
        height: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextWidget(text: day, fontSize: 25),
                MyAssetImage(
                  height: 80,
                  path: iconPath,
                ),
                TempDisplayWidget(
                  temp: ' $tempDay',
                  deg: deg,
                  fontsize: 40,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyTextWidget(text: displayCondition),
                MyTextWidget(text: 'Feels like: $feelsLikeDay'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTextWidget(
                  text: 'Precipitation',
                  fontSize: 15,
                ),
                MyTextWidget(
                    text: precipitation != null ? '$precipitation %' : 'fah Q'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
