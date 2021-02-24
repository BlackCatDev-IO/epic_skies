import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/services/weather/daily_forecast_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/widgets/general/day_label_row.dart';
import 'package:epic_skies/widgets/general/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DailyForecastPage extends StatefulWidget {
  static const id = 'daily_forecast_page';

  @override
  _DailyForecastPage createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final itemScrollController =
        Get.find<ViewController>().itemScrollController;
    final itemPositionsListener =
        Get.find<ViewController>().itemPositionsListener;
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        Get.find<MasterController>().onRefresh();
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 150),
              DayLabelRow(),
              GetX<DailyForecastController>(
                builder: (controller) {
                  return ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    padding: EdgeInsets.zero,
                    itemCount: controller.dayDetailedWidgetList.length,
                    itemBuilder: (context, index) {
                      return controller.dayDetailedWidgetList[index];
                    },
                  ).expanded();
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 5, vertical: 5),
          GetX<WeatherRepository>(builder: (controller) {
            return controller.isLoading.value
                ? const MyCircularProgressIndicator()
                : Container();
          })
        ],
      ),
    );
  }
}
