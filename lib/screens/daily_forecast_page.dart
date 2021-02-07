import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:epic_skies/widgets/general/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

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
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        Get.find<MasterController>().onRefresh();
      },
      child: Stack(
        children: [
          Column(
            children: [
              GetX<ForecastController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.dayDetailedWidgetList.length,
                    itemBuilder: (context, index) {
                      return controller.dayDetailedWidgetList[index];
                    },
                  ).expanded();
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 5, vertical: 5),
          GetX<WeatherController>(builder: (controller) {
            return controller.isLoading.value
                ? const MyCircularProgressIndicator()
                : Container();
          })
        ],
      ),
    );
  }
}
