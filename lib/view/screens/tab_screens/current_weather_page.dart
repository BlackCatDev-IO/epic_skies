import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/precip_notice_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/weather_alert_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/containers/snow_icon_outline.dart';
import 'package:epic_skies/view/widgets/general/apple_weather_logo.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/text_widgets/url_launcher_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/current_weather/current_weather_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_forecast_column.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  static const id = 'current_weather_page';

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  static final homeWidgetList = <Widget>[
    const _AlertSection(),
    const CurrentWeatherRow(),
    const SizedBox(height: 2),
    const _RemoteTimeWidget(),
    const HourlyForecastRow(),
    const DailyForecastColumn(),
    const AppleWeatherCredit(
      padding: EdgeInsets.only(top: 10, bottom: 25),
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    getIt<AdaptiveLayout>()
        .setAppBarPadding(Scaffold.of(context).appBarMaxHeight!);
  }

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
              SizedBox(height: getIt<AdaptiveLayout>().appBarPadding),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 2),
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

class _AlertSection extends StatelessWidget {
  const _AlertSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final weatherAlert = state.alertModel.weatherAlert;
        final precipNotice = state.alertModel.precipNotice;
        final showWeatherAlert =
            weatherAlert != const WeatherAlertModel.noAlert();
        final showPrecipNotice =
            precipNotice != const PrecipNoticeModel.noPrecip();

        if (!showWeatherAlert && !showPrecipNotice) {
          return const SizedBox();
        }

        return Column(
          children: [
            if (showWeatherAlert)
              _AlertWidget(
                alertModel: state.alertModel,
                isWeatherAlert: true,
              ),
            const SizedBox(height: 2),
            if (showPrecipNotice)
              _AlertWidget(
                alertModel: state.alertModel,
              ),
          ],
        ).paddingSymmetric(horizontal: 5, vertical: 5);
      },
    );
  }
}

class _AlertWidget extends StatelessWidget {
  const _AlertWidget({
    required this.alertModel,
    this.isWeatherAlert = false,
  });

  final AlertModel alertModel;
  final bool isWeatherAlert;

  static const _alertBgColor = Color.fromARGB(223, 255, 255, 255);

  Widget _getIcon() {
    if (isWeatherAlert) {
      return const Icon(
        Icons.warning_amber_outlined,
      );
    }

    final precipNotice = alertModel.precipNotice;
    const precipIconWidth = 15.0;

    return Stack(
      children: [
        if (precipNotice.precipNoticeIconPath == snowflake)
          const SnowIconOutline(
            color: Color.fromARGB(114, 0, 0, 0),
            width: precipIconWidth,
            height: precipIconWidth,
          ),
        Image(
          width: precipIconWidth,
          height: precipIconWidth,
          image: AssetImage(
            precipNotice.precipNoticeIconPath,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showWeatherAlert =
        alertModel.weatherAlert != const WeatherAlertModel.noAlert();
    final showPrecipNotice =
        alertModel.precipNotice != const PrecipNoticeModel.noPrecip();
    final fullWidth = showWeatherAlert && showPrecipNotice;

    return SnowIconOutline(
      color: _alertBgColor,
      borderColor: const Color.fromARGB(28, 0, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisSize: fullWidth || isWeatherAlert
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              _getIcon(),
              const SizedBox(width: 20),
              Flexible(
                child: Padding(
                  padding: isWeatherAlert
                      ? const EdgeInsets.only(top: 7)
                      : const EdgeInsets.symmetric(vertical: 7),
                  child: Text(
                    isWeatherAlert
                        ? alertModel.weatherAlert.weatherAlertMessage
                        : alertModel.precipNotice.precipNoticeMessage,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isWeatherAlert)
            Row(
              children: [
                const SizedBox(width: 45),
                UrlLauncherTextWidget(
                  url: alertModel.weatherAlert.detailsUrl,
                  text: alertModel.weatherAlert.alertSource,
                  fontWeight: FontWeight.bold,
                  showUnderline: false,
                ),
              ],
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
