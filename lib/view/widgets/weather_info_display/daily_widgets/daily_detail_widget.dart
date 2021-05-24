import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import '../detail_widgets.dart';
import '../hourly_widgets/hourly_scroll_widget.dart';

class DailyDetailWidget extends GetView<ViewController> {
  final int tempDay, feelsLikeDay, precipitationCode;

  final int? highTemp, lowTemp;

  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String sunset;
  final String sunrise;
  final String condition;
  final String tempUnit;
  final String speedUnit;
  final String precipitationType;

  final num precipitationAmount, windSpeed, precipitationProbability;

  final List? list;

  const DailyDetailWidget({
    required this.iconPath,
    required this.tempDay,
    required this.feelsLikeDay,
    required this.precipitationProbability,
    required this.condition,
    required this.sunset,
    required this.sunrise,
    required this.day,
    required this.precipitationType,
    required this.precipitationCode,
    required this.month,
    required this.year,
    required this.date,
    required this.tempUnit,
    required this.precipitationAmount,
    required this.speedUnit,
    required this.windSpeed,
    required this.list,
    this.highTemp,
    this.lowTemp,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    final displayCondition = condition.capitalizeFirst!;
    final precipitation = precipitationCode != 0;
    // fullDetail is for a different build for periods after the next 108 available hourly temps
    final fullDetail = list != null;

    return MyCard(
      radius: 10,
      child: RoundedContainer(
        color: controller.soloCardColor,
        height: fullDetail ? 700 : 375,
        borderColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedContainer(
              color: Colors.blueGrey[300],
              child: MyTextWidget(
                text: '$day $month $date, $year',
                color: Colors.black,
                fontSize: 17,
              ).paddingSymmetric(horizontal: 10),
            ).paddingSymmetric(vertical: 10).center(),
            DetailWidgetHeaderRow(
              deg: deg,
              condition: displayCondition,
              height: 70,
              iconPath: iconPath,
              temp: tempDay,
              tempFontSize: 30,
            ),
            DetailRow(category: 'Feels Like: ', value: feelsLikeDay.toString()),
            DetailRow(category: 'Wind Speed: ', value: '$windSpeed $speedUnit'),
            DetailRow(
                category: 'Precipitation: $precipitationType',
                value: '$precipitationProbability%'),
            DetailRow(category: 'Sunrise: ', value: sunrise),
            DetailRow(category: 'Sunset: ', value: sunset),
            if (fullDetail) detailColumn(deg) else const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget detailColumn(String deg) {
    return Column(
      children: [
        DetailRow(category: 'High Temp: ', value: '$highTemp$deg $tempUnit'),
        DetailRow(category: 'Low Temp: ', value: '$lowTemp$deg $tempUnit'),
        HourlyScrollWidget(
                list: list!, layeredCard: true, header: const HourlyHeader())
            .paddingSymmetric(horizontal: 2.5, vertical: 10)
      ],
    );
  }
}
