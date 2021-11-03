import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/weather_forecast/hourly_forecast_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
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
              SizedBox(height: StorageController.to.appBarPadding().h),
              const RemoteLocationLabel(),
              GetBuilder<ColorController>(
                builder: (colorController) => RoundedContainer(
                  radius: 8,
                  color: colorController.theme.soloCardColor,
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
