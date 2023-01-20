import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntimes/suntime_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/ticker_controllers/tab_navigation_controller.dart';

class HourlyScrollWidgetColumn extends StatelessWidget {
  final HourlyVerticalWidgetModel model;

  const HourlyScrollWidgetColumn({required this.model});
  @override
  Widget build(BuildContext context) {
    return model.suntimeString == null
        ? GestureDetector(
            onTap: () =>
                GetIt.instance<TabNavigationController>().jumpToTab(index: 1),
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
          )
        : SuntimeWidget(
            time: model.suntimeString!,
            isSunrise: model.isSunrise!,
          );
  }
}
