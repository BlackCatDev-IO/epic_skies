import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/weather_forecast/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            header: const Next24HrsHeader(),
            layeredCard: false,
          );
        },
      ),
    );
  }
}
