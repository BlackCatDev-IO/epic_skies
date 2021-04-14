import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
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
    final double height = list == null ? 400 : 600;

    return MyCard(
      radius: 10,
      child: RoundedContainer(
        color: Colors.black38,
        height: height,
        borderColor: Colors.black,
        child: Column(
          children: [
            RoundedContainer(
              color: Colors.blueGrey[300],
              child: MyTextWidget(
                text: '$day $month $date, $year',
                color: Colors.black,
                fontSize: 17,
              ).paddingSymmetric(horizontal: 10),
            ).paddingSymmetric(vertical: 10).center(),
            headerRow(deg, displayCondition),
            DetailRow(category: 'Feels Like: ', value: feelsLikeDay.toString()),
            DetailRow(category: 'Wind Speed: ', value: '$windSpeed $speedUnit'),
            DetailRow(
                category: 'Precipitation: $precipitationType',
                value: '$precipitationProbability%'),
            DetailRow(category: 'Sunrise: ', value: sunrise),
            DetailRow(category: 'Sunset: ', value: sunset),
            const Spacer(),
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

  Widget headerRow(String deg, String displayCondition) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(text: displayCondition),
            MyAssetImage(
              height: 70,
              path: iconPath,
            ),
            TempDisplayWidget(
              temp: '  $tempDay',
              deg: deg,
              degFontSize: 30,
              tempFontsize: 30,
              unitFontsize: 20,
              unitPadding: 10,
            ),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 10),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String category, value;

  const DetailRow({this.category, this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      // color: Colors.black45,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(text: category, fontSize: 17),
            MyTextWidget(text: value, fontSize: 17),
          ],
        ).paddingSymmetric(horizontal: 15),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}
