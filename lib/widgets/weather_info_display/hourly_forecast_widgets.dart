import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/widgets/general/my_scroll_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'temp_display_widget.dart';

class HourlyForecastRow extends GetView<HourlyForecastController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewController.to.tabController.animateTo(1);
      },
      child: MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedContainer(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MyTextWidget(
                    text: 'Next 24 Hours',
                    color: Colors.white54,
                    fontSize: 16,
                    spacing: 5,
                  )
                ],
              ),
            ),
            RoundedContainer(
              height: screenHeight * .22,
              child: MyScrollbar(
                builder: (context, scrollController) =>
                    GetBuilder<HourlyForecastController>(
                  builder: (_) => ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.hourColumns.length,
                    itemBuilder: (context, index) {
                      return controller.hourColumns[index] as Widget;
                    },
                  ),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 5),
      ),
    );
  }
}

class HourColumn extends StatelessWidget {
  final String temp;
  final String time;
  final String precipitation;
  final String iconPath;

  const HourColumn(
      {Key key, this.temp, this.time, this.precipitation, this.iconPath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // debugPrint('Hour Column build @ time: $time');
    final deg = String.fromCharCode($deg);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyTextWidget(
            text: time,
            fontSize: 16,
            color: Colors.blueGrey[400],
          ),
          Row(
            children: [
              MyTextWidget(
                text: temp,
                fontSize: 20,
                color: Colors.white70,
              ),
              MyTextWidget(
                text: deg,
                fontSize: 18,
                color: Colors.white70,
              ),
            ],
          ),
          Image(
            width: 40,
            image: AssetImage(
                iconPath ?? 'assets/icons/vclouds_icons/clear_day.png'),
          ),
          MyTextWidget(
            text: ' $precipitation%',
            fontSize: 16,
            color: Colors.white54,
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 10);
  }
}

class HourlyDetailedRow extends StatelessWidget {
  final String iconPath,
      time,
      temp,
      feelsLike,
      precipitationProbability,
      precipitationType,
      precipUnit,
      speedUnit,
      condition;

  final int precipitationCode;

  final num precipitationAmount, windSpeed;

  const HourlyDetailedRow({
    @required this.temp,
    @required this.feelsLike,
    @required this.precipitationProbability,
    @required this.iconPath,
    @required this.time,
    @required this.condition,
    @required this.precipitationType,
    @required this.precipitationAmount,
    @required this.precipitationCode,
    @required this.precipUnit,
    @required this.windSpeed,
    @required this.speedUnit,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    final displayCondition = condition.capitalizeFirst;
    final precipitation = precipitationProbability != '0';
    debugPrint(
        'Precipitation code: $precipitationCode bool: $precipitation Precipitation probability: $precipitationProbability');
    return MyCard(
      radius: 9,
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextWidget(text: '     $time' ?? 'fah Q', fontSize: 15)
                    .paddingSymmetric(vertical: 5),
                MyAssetImage(
                  height: 50,
                  path: iconPath,
                ),
                TempDisplayWidget(
                  temp: '    $temp',
                  deg: deg,
                  degFontSize: 20,
                  unitPadding: 1,
                  unitFontsize: 18,
                  tempFontsize: 20,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyTextWidget(text: displayCondition),
                MyTextWidget(text: 'Feels like: $feelsLike'),
                MyTextWidget(
                  text: 'Wind Speed: $windSpeed $speedUnit',
                  fontSize: 17,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTextWidget(
                  text: 'Precipitation',
                  fontSize: 15,
                ),
                MyTextWidget(text: '  $precipitationProbability%'),
                MyTextWidget(text: precipitation ? precipitationType : ''),
                MyTextWidget(
                  text: '$precipitationAmount $precipUnit',
                  fontSize: 17,
                ),
              ],
            ).paddingSymmetric(horizontal: 15),
          ],
        ),
      ),
    );
  }
}
