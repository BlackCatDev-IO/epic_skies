import 'package:black_cat_lib/widgets/misc_custom_widgets.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/general/my_app_bar.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/main_weather/bloc/weather_bloc.dart';
import '../../../utils/logging/app_debug_log.dart';
import '../../../utils/ui_updater/ui_updater.dart';
import '../settings_screens/settings_main_page.dart';
import 'current_weather_page.dart';
import 'daily_forecast_page.dart';
import 'hourly_forecast_page.dart';
import 'saved_locations_screen.dart';

class HomeTabView extends StatelessWidget {
  static const id = '/home_tab_view';

  final _tabs = <Widget>[
    CurrentWeatherPage(),
    HourlyForecastPage(),
    DailyForecastPage(),
    SavedLocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        AppDebug.log(
          'Updated Weather State: $state',
          name: 'WeatherBlocListener',
        );

        /// This is what triggers the app wide rebuild when user refreshes the
        /// weather data or updates UnitSettings
        if (state.status.isSucess || state.status.isUnitSettingsUpdate) {
          context
              .read<CurrentWeatherCubit>()
              .refreshCurrentWeatherData(weatherState: state);
          UiUpdater.refreshUI(state);
        }
      },
      child: WillPopScope(
        onWillPop: () async =>
            TabNavigationController.to.overrideAndroidBackButton(context),
        child: NotchDependentSafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            drawer: SettingsMainPage(),
            appBar: const EpicSkiesAppBar(),
            body: WeatherImageContainer(
              child: TabBarView(
                controller: TabNavigationController.to.tabController,
                dragStartBehavior: DragStartBehavior.down,
                physics: const AlwaysScrollableScrollPhysics(),
                children: _tabs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
