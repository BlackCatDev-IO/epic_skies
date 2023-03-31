import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nil/nil.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  static const id = 'current_weather_page';

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  static const homeWidgetList = <Widget>[
    // CurrentWeatherRow(),
    // SizedBox(height: 2),
    // RemoteTimeWidget(),
    // HourlyForecastRow(),
    // WeeklyForecastRow(),
  ];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final locationBloc = context.read<LocationBloc>();
    return PullToRefreshPage(
      onRefresh: () async => locationBloc.add(LocationUpdatePreviousRequest()),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: GetIt.instance<AdaptiveLayout>().appBarPadding,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: homeWidgetList.length,
                itemBuilder: (context, index) {
                  return homeWidgetList[index];
                },
              ).expanded()
            ],
          ).paddingSymmetric(horizontal: 2.5, vertical: 1),
          const LoadingIndicator()
        ],
      ),
    );
  }
}

class RemoteTimeWidget extends StatelessWidget {
  const RemoteTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.searchIsLocal
            ? nil
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedContainer(
                    color: Colors.white70,
                    child:
                        BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
                      buildWhen: (previous, current) =>
                          current.currentTimeString !=
                          previous.currentTimeString,
                      builder: (context, state) {
                        return BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, remoteState) {
                            return Text(
                              'Current time in ${remoteState.remoteLocationData.city}: ${state.currentTimeString}',
                            );
                          },
                        ).paddingSymmetric(horizontal: 10, vertical: 2.5);
                      },
                    ).center(),
                  ).paddingOnly(top: 5, bottom: 2.5),
                ],
              );
      },
    );
  }
}
