import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/hourly_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        MasterController.to.onRefresh();
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: ViewController.to.appBarPadding),
              RoundedContainer(
                color: ViewController.to.soloCardColor,
                child: GetBuilder<HourlyForecastController>(
                  builder: (controller) => ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.hourRowList.length,
                    itemBuilder: (context, index) {
                      return controller.hourRowList[index] as Widget;
                    },
                  ),
                ),
              ).expanded()
            ],
          ).paddingSymmetric(horizontal: 5),
          Obx(
            () => WeatherRepository.to.isLoading.value
                ? const MyCircularProgressIndicator()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
