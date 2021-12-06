import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'horizontal_scroll_widget.dart';

class HourlyForecastRow extends GetView<HourlyForecastController> {
  const HourlyForecastRow();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => TabNavigationController.to.tabController.animateTo(1),
      child: GetBuilder<HourlyForecastController>(
        builder: (_) {
          return HorizontalScrollWidget(
            list: controller
                .hourlyForecastHorizontalScrollWidgetMap['next_24_hrs']!,
            header: const _Next24HrsHeader(),
            layeredCard: false,
          );
        },
      ),
    );
  }
}

class _Next24HrsHeader extends StatelessWidget {
  const _Next24HrsHeader();

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
            text: 'Next 24 Hours',
            color: Colors.white54,
            fontSize: 11.sp,
            spacing: 5,
          )
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}

class HourlyHeader extends StatelessWidget {
  const HourlyHeader();

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
            text: 'Hourly',
            color: Colors.white54,
            fontSize: 11.sp,
            spacing: 5,
          )
        ],
      ).paddingSymmetric(vertical: 2),
    );
  }
}
