import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/widgets/general/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class HourlyForecastPage extends StatefulWidget {
  static const id = 'hourly_forecast_page';

  @override
  _HourlyForecastPageState createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage>
    with AutomaticKeepAliveClientMixin {
  final weatherController = Get.find<WeatherRepository>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        Get.find<MasterController>().onRefresh();
      },
      child: Stack(children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 150),
            GetX<HourlyForecastController>(
              builder: (controller) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.hourRowList.length,
                  itemBuilder: (context, index) {
                    return controller.hourRowList[index];
                  },
                ).expanded();
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 5, vertical: 5),
        GetX<WeatherRepository>(builder: (controller) {
          return controller.isLoading.value
              ? MyCircularProgressIndicator()
              : Container();
        })
      ]),
    );
  }
}
