import 'package:black_cat_lib/extensions/widget_extensions.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/containers/snow_icon_outline.dart';
import 'package:epic_skies/view/widgets/general/apple_weather_logo.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/weather_info_display/current_weather/current_weather_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/weekly_forecast_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  static const id = 'current_weather_page';

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  static final homeWidgetList = <Widget>[
    const CurrentWeatherRow(),
    const SizedBox(height: 2),
    const _RemoteTimeWidget(),
    const HourlyForecastRow(),
    const WeeklyForecastRow(),
    const AppleWeatherCredit(
      padding: EdgeInsets.only(top: 10),
    ),
  ];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final locationBloc = context.read<LocationBloc>();

    return RefreshIndicator(
      onRefresh: () async => locationBloc.add(LocationUpdatePreviousRequest()),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: GetIt.I<AdaptiveLayout>().appBarPadding),
              const _AlertNotices(),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: homeWidgetList.length,
                itemBuilder: (context, index) {
                  return homeWidgetList[index];
                },
              ).expanded(),
            ],
          ).paddingSymmetric(horizontal: 2.5, vertical: 1),
          const LoadingIndicator(),
        ],
      ),
    );
  }
}

class _AlertNotices extends StatelessWidget {
  const _AlertNotices();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final alertModel = state.alertModel;
        final showWeatherAlert = alertModel.weatherAlertMessage.isNotEmpty;
        final showPrecipNotice = !alertModel.precipAlertType.isNoPrecip;

        if (!showWeatherAlert && !showPrecipNotice) {
          return const SizedBox();
        }

        const precipIconWidth = 15.0;

        final fullWidth = showWeatherAlert && showPrecipNotice;

        return Column(
          children: [
            if (showWeatherAlert)
              _AlertContainer(
                icon: const Icon(
                  Icons.warning_amber_outlined,
                ),
                precipNotice: alertModel.weatherAlertMessage,
                fullWidth: fullWidth,
              ),
            const SizedBox(height: 2),
            if (showPrecipNotice)
              _AlertContainer(
                icon: Stack(
                  children: [
                    if (alertModel.precipNoticeIconPath == snowflake)
                      const SnowIconOutline(
                        color: Color.fromARGB(114, 0, 0, 0),
                        width: precipIconWidth,
                        height: precipIconWidth,
                      ),
                    Image(
                      width: precipIconWidth,
                      height: precipIconWidth,
                      image: AssetImage(
                        alertModel.precipNoticeIconPath,
                      ),
                    ),
                  ],
                ),
                precipNotice: alertModel.precipNoticeMessage,
                fullWidth: fullWidth,
              ),
          ],
        );
      },
    ).paddingSymmetric(horizontal: 5, vertical: 5);
  }
}

class _AlertContainer extends StatelessWidget {
  const _AlertContainer({
    required this.icon,
    required this.precipNotice,
    required this.fullWidth,
  });

  final Widget icon;
  final String precipNotice;
  final bool fullWidth;

  static const alertBgColor = Color.fromARGB(223, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    return SnowIconOutline(
      color: alertBgColor,
      borderColor: const Color.fromARGB(28, 0, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              precipNotice,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
              ),
            ).paddingSymmetric(vertical: 7),
          ),
        ],
      ),
    );
  }
}

class _RemoteTimeWidget extends StatelessWidget {
  const _RemoteTimeWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.searchIsLocal
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SnowIconOutline(
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
                              '''Current time in ${remoteState.remoteLocationData.city}: ${state.currentTimeString}''',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
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
