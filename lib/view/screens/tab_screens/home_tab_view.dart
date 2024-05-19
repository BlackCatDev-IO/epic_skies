import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/remote_logging_service.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/ui_updater/ui_updater.dart';
import 'package:epic_skies/view/dialogs/ad_dialogs.dart';
import 'package:epic_skies/view/dialogs/error_dialogs.dart';
import 'package:epic_skies/view/dialogs/update_dialogs.dart';
import 'package:epic_skies/view/screens/settings_screens/settings_main_page.dart';
import 'package:epic_skies/view/screens/tab_screens/current_weather_page.dart';
import 'package:epic_skies/view/screens/tab_screens/daily_forecast_page.dart';
import 'package:epic_skies/view/screens/tab_screens/hourly_forecast_page.dart';
import 'package:epic_skies/view/screens/tab_screens/saved_locations_screen.dart';
import 'package:epic_skies/view/widgets/general/epic_skies_app_bar.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({super.key});

  static const id = '/home_tab_view';

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  final List<ImageProvider> precachedImages = [];

  late final WeatherBloc _weatherBloc;

  final _tabs = <Widget>[
    const CurrentWeatherPage(),
    const HourlyForecastPage(),
    const DailyForecastPage(),
    const SavedLocationScreen(),
  ];

  Future<void> __initAllBackgroundImages() async {
    final bgImageList = context.read<BgImageBloc>().state.bgImageList;

    for (final bgImage in bgImageList) {
      precachedImages.add(CachedNetworkImageProvider(bgImage.imageUrl));
    }
  }

  Future<void> _cacheAllBackgroundImages() async {
    final precacheList =
        precachedImages.map((e) => precacheImage(e, context)).toList();

    await Future.wait(precacheList);
  }

  @override
  void initState() {
    super.initState();
    _weatherBloc = context.read<WeatherBloc>();
    __initAllBackgroundImages();

    context.read<AppUpdateBloc>().add(
          AppInitInfoOnAppStart(
            minorVersionLowThreshold: 1,
            minorVersionHighThreshold: 5,
          ),
        );

    tabController = TabController(vsync: this, length: 4);
    final tabNav = TabNavigationController(tabController: tabController);
    if (!getIt.isRegistered<TabNavigationController>()) {
      getIt.registerSingleton<TabNavigationController>(tabNav);
    }

    final imageState = context.read<BgImageBloc>().state;

    if (!imageState.imageSettings.isDeviceGallery &&
        imageState.bgImagePath.isNotEmpty) {
      context.read<ColorCubit>().updateThemeColors(
            path: imageState.bgImagePath,
            isBackupApi: context.read<WeatherBloc>().state.useBackupApi,
          );
    }

    /// Inits the listener after the first build so the BlocListener<AdBloc>
    /// can show relevant dialogs to inform user of ad free status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdBloc>().add(AdInitPurchaseListener());
    });

    final locationState = context.read<LocationBloc>().state;

    switch (locationState.status) {
      case LocationStatus.loading:
        break;
      case LocationStatus.success:

        /// if location has done loading by the time we get here, the
        /// BlocListener will not fire the weather refresh
        _weatherBloc.add(
          WeatherUpdate(
            locationState: locationState,
          ),
        );
      default:

        /// App is in a loading state on start if the location permission is not
        /// granted the loading needs because no search is initiated
        context.read<AppBloc>().add(AppNotifyLoading());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cacheAllBackgroundImages();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// This `MultiBlocListener` is responsible for listening to emitted states
    /// from `LocationBloc` and `WeatherBloc`. In order to de-couple Location
    /// and Weather blocs, a user refresh first triggers a location request and
    /// only then does the `WeatherBloc` attempt a refresh with the coordinates
    /// passed in from a successful `LocationBloc` location request. A `loading`
    /// status from `LocationBloc` triggers a `loading` status to `AppBloc`
    /// which is responsible for the main app wide `LoadingIndicator` and a
    /// `success` status from `WeatherBloc` or `error` status from either one
    /// will disable the `LoadingIndicator`
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
              _weatherBloc.add(
                WeatherUpdate(
                  locationState: state,
                ),
              );
            }

            if (state.status.isError ||
                state.status.isNoLocationPermission ||
                state.status.isLocationDisabled) {
              if (state.status.isError) {
                ErrorDialogs.showDialog(context, state.errorModel!);
              }
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

            /// This is what triggers the app wide rebuild when user refreshes
            /// the weather data or updates UnitSettings
            if (state.status.isSuccess || state.status.isUnitSettingsUpdate) {
              UiUpdater.refreshUI(context);
            }

            final recordWeatherAlertLog = state.status.isSuccess &&
                state.alertModel != const AlertModel.none() &&
                !state.useBackupApi;

            if (recordWeatherAlertLog) {
              getIt<RemoteLoggingService>().recordWeatherAlert(
                weather: state.weather!,
                alert: state.alertModel,
              );
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
              context.read<ColorCubit>().updateThemeColors(
                    path: state.bgImagePath,
                    isBackupApi: context.read<WeatherBloc>().state.useBackupApi,
                  );
            }
          },
        ),
        BlocListener<AppUpdateBloc, AppUpdateState>(
          listener: (context, state) {
            if (state.status.isUpdatedShowUpdateDialog) {
              context.read<BgImageBloc>().add(BgImageFetchOnFirstInstall());
              UpdateDialog.showChangeLogDialog(
                context,
                changeLog: state.updatedChanges,
                appVersion: state.currentAppVersion,
              );
            }
            if (state.status.isUpdatedNoDialog) {
              context.read<BgImageBloc>().add(BgImageFetchOnFirstInstall());
            }
          },
        ),
        BlocListener<AdBloc, AdState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AdFreeStatus.trialPeriod:
                AdDialogs.explainAdPolicy(context);
              case AdFreeStatus.trialEnded:
                AdDialogs.trialEnded(context);
              case AdFreeStatus.adFreePurchased:
                AdDialogs.purchaseSuccessConfirmation(context);
              case AdFreeStatus.adFreeRestored:
                AdDialogs.restorePurchaseConfirmation(context);
              case AdFreeStatus.error:
                if (state.errorMessage == Errors.noPurchaseFouund) {
                  ErrorDialogs.showDialog(
                    context,
                    Errors.noPurchasesFoundModel,
                  );
                  break;
                }
                AdDialogs.adPurchaseError(context, state.errorMessage);
              case AdFreeStatus.showAds:
              case AdFreeStatus.initial:
              case AdFreeStatus.loading:
                return;
            }
          },
        ),
      ],
      child: PopScope(
        canPop:
            getIt<TabNavigationController>().overrideAndroidBackButton(context),
        child: UpgradeAlert(
          dialogStyle: Platform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
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
