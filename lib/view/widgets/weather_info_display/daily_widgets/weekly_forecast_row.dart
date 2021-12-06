import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/controllers/daily_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../hourly_widgets/horizontal_scroll_widget.dart';
import 'daily_scroll_widget_column.dart';

class WeeklyForecastRow extends GetView<DailyForecastController> {
  const WeeklyForecastRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyForecastController>(
      builder: (_) {
        return HorizontalScrollWidget(
          header: const _Next14DaysHeader(),
          layeredCard: false,
          list: List<Widget>.generate(
            controller.dayColumnModelList.length,
            (int index) => DailyScrollWidgetColumn(
              model: controller.dayColumnModelList[index],
            ),
            growable: false,
          ),
        );
      },
    );
  }
}

class _Next14DaysHeader extends StatelessWidget {
  const _Next14DaysHeader();
  @override
  Widget build(BuildContext context) {
    return PartialRoundedContainer(
      topLeft: 10,
      topRight: 10,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
            text: 'Next 14 Days',
            color: Colors.white60,
            fontSize: 11.sp,
            spacing: 4,
          )
        ],
      ),
    );
  }
}
