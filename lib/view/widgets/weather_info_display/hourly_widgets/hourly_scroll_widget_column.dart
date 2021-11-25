import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/models/widget_models/hourly_vertical_widget_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HourlyScrollWidgetColumn extends StatelessWidget {
  final HourlyVerticalWidgetModel model;

  const HourlyScrollWidgetColumn({required this.model});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => TabNavigationController.to.jumpToTab(index: 1),
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyTextWidget(
            text: model.time,
            fontSize: 10.5.sp,
            color: Colors.blueAccent[100],
          ),
          TempWidget(temp: model.temp),
          Image(
            width: 4.h,
            image: AssetImage(model.iconPath),
          ),
          MyTextWidget(
            text: ' ${model.precipitation}%',
            fontSize: 10.sp,
            color: Colors.white54,
          ),
        ],
      ).paddingSymmetric(horizontal: 9),
    );
  }
}
