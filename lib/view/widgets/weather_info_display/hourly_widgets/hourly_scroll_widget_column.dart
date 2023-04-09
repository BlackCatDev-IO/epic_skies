import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/suntimes/suntime_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/temp_widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HourlyScrollWidgetColumn extends StatelessWidget {
  const HourlyScrollWidgetColumn({
    required this.model,
    super.key,
  });
  final HourlyVerticalWidgetModel model;

  static const fontSize = 17.0;

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
                  fontSize: fontSize,
                  color: Colors.blueAccent[100],
                ),
                TempWidget(temp: model.temp),
                Image(
                  image: AssetImage(
                    model.iconPath,
                  ),
                  width: 40,
                ),
                MyTextWidget(
                  text: ' ${model.precipitation}%',
                  fontSize: fontSize,
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
