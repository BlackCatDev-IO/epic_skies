import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'hourly_widgets/hourly_forecast_row.dart';
import 'hourly_widgets/hourly_scroll_widget.dart';
import 'temp_display_widget.dart';

class DailyDetailWidget extends StatelessWidget {
  final int tempDay, feelsLikeDay, precipitationCode;

  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String sunset;
  final String sunrise;
  final String tempMin;
  final String tempHigh;
  final String tempNight;
  final String feelsLikeNight;
  final String precipitationProbability;
  final String condition;
  final String tempUnit;
  final String speedUnit;
  final String precipitationType;

  final num precipitationAmount, windSpeed;

  final List list;

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
    @required this.tempUnit,
    @required this.precipitationAmount,
    @required this.speedUnit,
    @required this.windSpeed,
    @required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    final displayCondition = condition.capitalizeFirst;
    final precipitation = precipitationCode != 0;
    final double height = list == null ? 300 : 500;

    return MyCard(
      radius: 10,
      child: RoundedContainer(
        color: Colors.black38,
        height: height,
        borderColor: Colors.black,
        child: Column(
          children: [
            MyTextWidget(text: '$month $date, $year'),
            Row(
              children: [
                dayTempColumn(deg),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyTextWidget(text: displayCondition),
                    MyTextWidget(text: 'Feels like: $feelsLikeDay'),
                    MyTextWidget(
                      text: 'Wind speed: $windSpeed $speedUnit',
                      fontSize: 17,
                    ),
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
                      text: '$precipitationProbability%',
                    ),
                    MyTextWidget(
                      text: precipitation ? precipitationType : '',
                      fontSize: 17,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10).expanded(),
              ],
            ).expanded(),
            if (list != null)
              HourlyScrollWidget(title: 'Hourly', list: list, layeredCard: true)
                  .paddingSymmetric(horizontal: 2.5)
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget dayTempColumn(String deg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyTextWidget(text: '  $day', fontSize: 25),
        MyAssetImage(
          height: 80,
          path: iconPath,
        ),
        TempDisplayWidget(
          temp: '  $tempDay',
          deg: deg,
          degFontSize: 30,
          tempFontsize: 30,
          unitFontsize: 20,
          unitPadding: 10,
        ).center(),
      ],
    ).expanded();
  }
}
