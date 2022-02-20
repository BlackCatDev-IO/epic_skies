import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../services/view_controllers/adaptive_layout_controller.dart';

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
      onRefresh: () async => WeatherRepository.to.refreshWeatherData(),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: AdaptiveLayoutController.to.appBarPadding.h),
              const RemoteLocationLabel(),
              _HourlyWidgetList()
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

class _HourlyWidgetList extends StatelessWidget {
  _HourlyWidgetList({Key? key}) : super(key: key);

  final _controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) => RoundedContainer(
        radius: 8,
        color: colorController.theme.soloCardColor,
        child: RawScrollbar(
          controller: _controllerOne,
          thumbColor: Colors.white60,
          thickness: 3.0,
          isAlwaysShown: true,
          child: GetBuilder<HourlyForecastController>(
            builder: (controller) {
              return ListView.builder(
                controller: _controllerOne,
                padding: EdgeInsets.zero,
                itemCount: controller.houryForecastModelList.length,
                itemBuilder: (context, index) {
                  final model = controller.houryForecastModelList[index];
                  return Column(
                    children: [
                      HoulyForecastRow(model: model),
                      const Divider(
                        height: 1,
                        color: Colors.white70,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ).expanded(),
    );
  }
}
