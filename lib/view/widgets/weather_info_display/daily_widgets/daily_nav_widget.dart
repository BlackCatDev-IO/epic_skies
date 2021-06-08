import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyNavigationWidget extends GetView<DailyForecastController> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.black54,
      child: Column(
        children: [
          // sizedBox10High,
          Row(
            children: controller.week1NavButtonList,
          ),
          sizedBox15High,
          Row(
            children: controller.week2NavButtonList,
          ),
          // sizedBox10High,
        ],
      ),
    );
  }
}

class DailyNavButton extends StatelessWidget {
  // final Function scrollToIndex;

  final String month, date, time;

  final int index;

  const DailyNavButton({
    required this.date,
    required this.month,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyForecastController>(
      builder: (controller) => RoundedContainer(
        borderColor: controller.selectedDayList[index]
            ? Colors.blue[100]
            : Colors.transparent,
        child: GestureDetector(
          onTap: () {
            ViewController.to.scrollToIndex(index);
            controller.updateSelectedDayStatus(index);
          },
          child: Column(
            children: [
              sizedBox10High,
              MyTextWidget(
                text: time,
                color: Colors.blueAccent[100],
                fontSize: 17,
              ),
              const SizedBox(height: 2),
              MyTextWidget(
                text: '$month $date',
                fontSize: 13,
                fontWeight: FontWeight.w200,
                color: Colors.yellow[50],
              ),
              sizedBox10High,
            ],
          ),
        ),
      ).expanded(),
    );
  }
}
