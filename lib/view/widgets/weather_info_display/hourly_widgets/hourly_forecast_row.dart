
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
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
          header: const Next24HrsHeader(),
          layeredCard: false),
    );
  }
}
