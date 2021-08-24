import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/controllers/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DailyNavigationWidget extends GetView<DailyForecastController> {
  const DailyNavigationWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (viewController) => RoundedContainer(
        color: viewController.theme.soloCardColor,
        child: Column(
          children: [
            Row(
              children: [
                for (final model in controller.week1NavButtonList)
                  DailyNavButton(model: model)
              ],
            ),
            Row(
              children: [
                for (final model in controller.week2NavButtonList)
                  DailyNavButton(model: model)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DailyNavButton extends StatelessWidget {
  final DailyNavButtonModel model;

  const DailyNavButton({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyForecastController>(
      builder: (controller) => RoundedContainer(
        borderColor: controller.selectedDayList[model.index]
            ? Colors.blue[100]
            : Colors.transparent,
        radius: 12,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ViewController.to.scrollToIndex(index: model.index);
            controller.updateSelectedDayStatus(model.index);
          },
          child: Column(
            children: [
              sizedBox5High,
              MyTextWidget(
                text: model.day,
                color: Colors.blueAccent[100],
                fontSize: 11.sp,
              ),
              MyTextWidget(
                text: DateTimeFormatter.abbreviateMonth(month: model.month),
                fontSize: 9.sp,
                fontWeight: FontWeight.w300,
                color: Colors.yellow[100],
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              MyTextWidget(
                text: model.date,
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                // color: Colors.yellow[50],
                textAlign: TextAlign.center,
              ),
              sizedBox5High,
            ],
          ),
        ),
      ).expanded(),
    );
  }
}
