import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'hourly_widgets/horizontal_scroll_widget.dart';

class WeeklyForecastRow extends GetView<DailyForecastController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ViewController.to.tabController.animateTo(2),
      child: HorizontalScrollWidget(
          header: const Next14DaysHeader(),
          layeredCard: false,
          list: controller.dayColumnList),
    );
  }
}

class Next14DaysHeader extends StatelessWidget {
  const Next14DaysHeader();
  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MyTextWidget(
            text: 'Next 14 Days',
            color: Colors.white60,
            fontSize: 16,
            spacing: 4,
          )
        ],
      ),
    );
  }
}