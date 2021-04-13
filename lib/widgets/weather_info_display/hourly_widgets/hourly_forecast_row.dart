import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hourly_scroll_widget.dart';

class HourlyForecastRow extends GetView<HourlyForecastController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewController.to.tabController.animateTo(1);
      },
      child: HourlyScrollWidget(
          list: controller.twentyFourHourColumnList,
          title: 'Next 24 Hours',
          layeredCard: false),
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
