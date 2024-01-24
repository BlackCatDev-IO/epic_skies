import 'package:black_cat_lib/extensions/widget_extensions.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/view/widgets/containers/rounded_container.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/weather_info_display/current_weather/current_weather_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/weekly_forecast_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
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
  static final homeWidgetList = <Widget>[
    const CurrentWeatherRow(),
    const SizedBox(height: 2),
    const _RemoteTimeWidget(),
    const HourlyForecastRow(),
    const WeeklyForecastRow(),
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

  (String iconPath, String notice) _precipNotice(WeatherState weatherState) {
    var forecastMinutes = 0;

    final condition = weatherState.weather?.currentWeather.conditionCode ?? '';

    forecastMinutes = 0;

    if (weatherState.useBackupApi) {
      return ('', '');
    }

    final minutes = weatherState.weather!.forecastNextHour?.minutes;

    if (minutes == null) {
      return ('', '');
    }

    for (final minute in minutes) {
      if (minute.precipitationChance > 0.5) {
        forecastMinutes++;
      } else {
        break;
      }
    }

    if (forecastMinutes == 0) {
      return ('', '');
    }

    final iconPath = IconController.getPrecipIconPath(precipType: condition);

    return (
      iconPath,
      '$condition expected for the next $forecastMinutes minutes'
    );
  }

  String _showWeatherAlert(WeatherState weatherState) {
    final hasWeatherKitData =
        weatherState.status.isSuccess && !weatherState.useBackupApi;

    if (!hasWeatherKitData) {
      return '';
    }

    final alertCollection = weatherState.weather?.weatherAlerts;

    if (alertCollection?.alerts.isEmpty ?? true) {
      return '';
    }

    if (alertCollection?.alerts[0].description == 'Hydrologic Outlook') {
      return '';
    }

    final baseAlert = weatherState.weather!.weatherAlerts!.alerts[0];
    final untilTime = DateTimeFormatter.formatAlertTime(
      baseAlert.eventEndTime?.toUtc() ?? DateTime.now(),
    );
    final description = baseAlert.description;

    return '$description in effect until $untilTime';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final (iconPath, precipNotice) = _precipNotice(state);
        final weatherAlert = _showWeatherAlert(state);

        if (weatherAlert.isEmpty && precipNotice.isEmpty) {
          return const SizedBox();
        }

        return Column(
          children: [
            if (weatherAlert.isNotEmpty)
              _AlertContainer(
                icon: const Icon(
                  Icons.warning_amber_outlined,
                ),
                precipNotice: weatherAlert,
              ),
            const SizedBox(height: 2),
            if (precipNotice.isNotEmpty)
              _AlertContainer(
                icon: Image(
                  width: 15,
                  height: 15,
                  image: AssetImage(iconPath),
                ),
                precipNotice: precipNotice,
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
  });

  final Widget icon;
  final String precipNotice;

  static const alertBgColor = Color.fromARGB(223, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      color: alertBgColor,
      borderColor: const Color.fromARGB(28, 0, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 15),
          Flexible(
            child: Text(
              precipNotice,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(top: 10, bottom: 10),
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
