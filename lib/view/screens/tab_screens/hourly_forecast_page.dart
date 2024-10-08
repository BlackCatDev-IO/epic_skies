import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/view/hourly_detailed_row.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/ad_widgets/native_ad_list_tile.dart';
import 'package:epic_skies/view/widgets/containers/containers.dart';
import 'package:epic_skies/view/widgets/general/general_widgets.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourlyForecastPage extends StatefulWidget {
  const HourlyForecastPage({super.key});

  static const id = 'hourly_forecast_page';

  @override
  State<HourlyForecastPage> createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<LocationBloc>().add(LocationUpdatePreviousRequest()),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: getIt<AdaptiveLayout>().appBarPadding,
              ),
              const RemoteLocationLabel(),
              _HourlyWidgetList(),
            ],
          ),
          const LoadingIndicator(),
        ],
      ),
    );
  }
}

class _HourlyWidgetList extends StatelessWidget {
  _HourlyWidgetList();

  final _scrollController = ScrollController();

  List<Widget> _hourlyWidgetList(
    List<HourlyForecastModel> hourlyModelList,
    bool showAds,
  ) {
    final hourlyWidgetList = hourlyModelList
        // ignore: unnecessary_cast
        .map((model) => HoulyForecastRow(model: model) as Widget)
        .toList();

    if (!showAds) {
      return hourlyWidgetList;
    }

    for (var i = 0; i < hourlyModelList.length; i++) {
      if (i % 5 == 0 && i != 0) {
        hourlyWidgetList.insert(i, const NativeAdListTile());
      }
    }
    return hourlyWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 8,
      child: RawScrollbar(
        controller: _scrollController,
        thumbColor: Colors.white60,
        thickness: 3,
        thumbVisibility: true,
        child: Builder(
          builder: (context) {
            final showAds = context.watch<AdBloc>().state.status.isShowAds;
            final hourlyState = context.watch<HourlyForecastCubit>().state;

            return BlocSelector<WeatherBloc, WeatherState, UnitSettings>(
              selector: (state) => state.unitSettings,
              builder: (context, state) {
                final widgetList = _hourlyWidgetList(
                  hourlyState.next24Hours,
                  showAds,
                );
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        widgetList[index],
                        const Divider(
                          height: 1,
                          color: Colors.white10,
                        ),
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
