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
  final String rain;
  final String snow;
  final String main;

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
      @required this.day,
      @required this.rain,
      @required this.snow,
      @required this.main});

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    String displayCondition = condition.capitalizeFirst;
    bool raining = int.parse(rain) > 0 && main == 'rain';
    bool snowing = int.parse(snow) > 0 && main == 'snow';

    return MyCard(
      radius: 9,
      child: SizedBox(
        height: 300,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    text: precipitation != null ? '$precipitation %' : 'fah Q'),
                raining ? MyTextWidget(text: '$rain in') : Container(),
                snowing ? MyTextWidget(text: '$snow in') : Container(),
              ],
            ).paddingSymmetric(horizontal: 10).expanded(),
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
