import 'package:black_cat_lib/widgets/misc_custom_widgets.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/ui_updater/ui_updater.dart';
import 'package:epic_skies/view/dialogs/error_dialogs.dart';
import 'package:epic_skies/view/dialogs/update_dialogs.dart';
import 'package:epic_skies/view/screens/settings_screens/settings_main_page.dart';
import 'package:epic_skies/view/screens/tab_screens/current_weather_page.dart';
import 'package:epic_skies/view/screens/tab_screens/daily_forecast_page.dart';
import 'package:epic_skies/view/screens/tab_screens/hourly_forecast_page.dart';
import 'package:epic_skies/view/screens/tab_screens/saved_locations_screen.dart';
import 'package:epic_skies/view/widgets/general/my_app_bar.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  static const id = '/home_tab_view';

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _tabs = <Widget>[
    const CurrentWeatherPage(),
    HourlyForecastPage(),
    const DailyForecastPage(),
    SavedLocationScreen(),
  ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 4);

    final tabNav = TabNavigationController(tabController: tabController);

    GetIt.instance.registerSingleton<TabNavigationController>(tabNav);

    final imageState = context.read<BgImageBloc>().state;

    if (!imageState.imageSettings.isDeviceGallery) {
      context
          .read<ColorCubit>()
          .updateTextAndContainerColors(path: imageState.bgImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// This `MultiBlocListener` is responsible for listening to emitted states
    /// from `LocationBloc` and `WeatherBloc`. In order to de-couple Location
    /// and Weather blocs, a user refresh first triggers a location request and
    /// only then does the `WeatherBloc` attempt a refresh with the coordinates
    /// passed in from a successful `LocationBloc` location request. A `loading`
    /// status from `LocationBloc` triggers a `loading` status to `AppBloc` which
    /// is responsible for the main app wide `LoadingIndicator` and a `success`
    /// status from `WeatherBloc` or `error` status from either one will disable
    /// the `LoadingIndicator`
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          /// Preventing unwanted callbacks on state changes such as search
          /// history re-ordering
          listenWhen: (previous, current) =>
              !(previous.status.isSuccess && current.status.isSuccess),
          listener: (context, state) {
            if (state.status.isLoading) {
              context.read<AppBloc>().add(AppNotifyLoading());
            }

            if (state.status.isSuccess) {
              final lat = state.searchIsLocal
                  ? state.coordinates!.lat
                  : state.remoteLocationData.remoteLat;

              final long = state.searchIsLocal
                  ? state.coordinates!.long
                  : state.remoteLocationData.remoteLong;

              context.read<WeatherBloc>().add(
                    WeatherUpdate(
                      lat: lat,
                      long: long,
                      searchIsLocal: state.searchIsLocal,
                    ),
                  );
            }

            if (state.status.isError) {
              ErrorDialogs.showDialog(context, state.errorModel!);
              context.read<AppBloc>().add(AppNotifyNotLoading());
            }
          },
        ),
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            AppDebug.log(
              'Updated Weather State: $state',
              name: 'WeatherBlocListener',
            );

            /// This is what triggers the app wide rebuild when user refreshes the
            /// weather data or updates UnitSettings
            if (state.status.isSuccess || state.status.isUnitSettingsUpdate) {
              UiUpdater.refreshUI(context);
            }

            if (state.status.isError) {
              ErrorDialogs.showDialog(context, state.errorModel!);
              context.read<AppBloc>().add(AppNotifyNotLoading());
            }
          },
        ),
        BlocListener<BgImageBloc, BgImageState>(
          listenWhen: (previous, current) =>
              previous.bgImagePath != current.bgImagePath,
          listener: (context, state) {
            if (!state.imageSettings.isDeviceGallery) {
              context
                  .read<ColorCubit>()
                  .updateTextAndContainerColors(path: state.bgImagePath);
            }
          },
        ),
        BlocListener<AppUpdateBloc, AppUpdateState>(
          listener: (context, state) {
            if (state.status.isUpdated) {
              UpdateDialog.showChangeLogDialog(
                context,
                changeLog: state.updatedChanges,
                appVersion: state.currentAppVersion,
              );
            }
          },
        )
      ],
      child: WillPopScope(
        onWillPop: () async => GetIt.instance<TabNavigationController>()
            .overrideAndroidBackButton(context),
        child: NotchDependentSafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            drawer: const SettingsMainPage(),
            appBar: const EpicSkiesAppBar(),
            body: WeatherImageContainer(
              child: TabBarView(
                controller: tabController,
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

  @override
  bool get wantKeepAlive => true;
}
