import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../features/banner_ads/bloc/ad_bloc.dart';
import '../../../features/main_weather/bloc/weather_bloc.dart';
import '../../../services/view_controllers/adaptive_layout_controller.dart';
import '../../widgets/ad_widgets/native_ad_list_tile.dart';
import '../../widgets/general/loading_indicator.dart';

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
      onRefresh: () async =>
          context.read<WeatherBloc>().add(RefreshWeatherData()),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: AdaptiveLayoutController.to.appBarPadding.h),
              const RemoteLocationLabel(),
              _HourlyWidgetList()
            ],
          ).paddingSymmetric(horizontal: 5),
          const LoadingIndicator()
        ],
      ),
    );
  }
}

class _HourlyWidgetList extends StatelessWidget {
  _HourlyWidgetList({Key? key}) : super(key: key);

  final _controllerOne = ScrollController();

  List<Widget> _hourlyWidgetList(
    List<HourlyForecastModel> hourlyModelList,
    bool showAds,
  ) {
    final List<Widget> hourlyWidgetList = hourlyModelList
        // ignore: unnecessary_cast
        .map((model) => HoulyForecastRow(model: model) as Widget)
        .toList();

    if (!showAds) {
      return hourlyWidgetList;
    }

    for (int i = 0; i < hourlyModelList.length; i++) {
      if (i % 5 == 0 && i != 0) {
        hourlyWidgetList.insert(i, NativeAdListTile());
      }
    }
    return hourlyWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 8,
      child: RawScrollbar(
        controller: _controllerOne,
        thumbColor: Colors.white60,
        thickness: 3.0,
        thumbVisibility: true,
        child: BlocBuilder<AdBloc, AdState>(
          builder: (context, state) {
            final showAds = state is ShowAds;
            return GetBuilder<HourlyForecastController>(
              builder: (hourlyController) {
                final widgetList = _hourlyWidgetList(
                  hourlyController.houryForecastModelList,
                  showAds,
                );
                return ListView.builder(
                  controller: _controllerOne,
                  padding: EdgeInsets.zero,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        widgetList[index],
                        const Divider(
                          height: 1,
                          color: Colors.white10,
                        )
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ).expanded();
  }
}
