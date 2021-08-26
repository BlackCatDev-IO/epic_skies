import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HourlyForecastPage extends StatefulWidget {
  static const id = 'hourly_forecast_page';

  @override
  _HourlyForecastPageState createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage>
    with AutomaticKeepAliveClientMixin {
  final _controllerOne = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async => WeatherRepository.to.refreshWeatherData(),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: ViewController.to.appBarPadding.h),
              GetBuilder<ViewController>(
                builder: (viewController) => RoundedContainer(
                  radius: 8,
                  color: viewController.theme.soloCardColor,
                  child: GetBuilder<HourlyForecastController>(
                    builder: (controller) => RawScrollbar(
                      controller: _controllerOne,
                      thumbColor: Colors.white60,
                      thickness: 3.0,
                      isAlwaysShown: true,
                      child: ListView.builder(
                        controller: _controllerOne,
                        padding: EdgeInsets.zero,
                        itemCount: controller.hourRowList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              controller.hourRowList[index] as Widget,
                              const Divider(
                                height: 1,
                                color: Colors.white70,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ).expanded(),
              )
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
