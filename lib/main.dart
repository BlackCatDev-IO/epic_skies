import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/core/database/firebase_image_repository.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:epic_skies/global/app_routes.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/global/global_bloc_observer.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/connectivity/connectivity_listener.dart';
import 'package:epic_skies/services/lifecyle/lifecyle_manager.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = GlobalBlocObserver();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    GetIt.instance.registerSingleton<AdaptiveLayout>(
      AdaptiveLayout()..setAdaptiveHeights(),
    );

    ConnectivityListener.initConnectivityListener();

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }

    final storage = StorageController();

    await Future.wait([
      MobileAds.instance.initialize(),
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]), // disable landscape
      Firebase.initializeApp(),
      storage.initStorageDirectory()
    ]);

    final mixpanel = await Mixpanel.init(
      Env.MIX_PANEL_TOKEN,
      trackAutomaticEvents: true,
    );

    final analytics = AnalyticsBloc(mixpanel: mixpanel);

    GetIt.instance
        .registerSingleton<AnalyticsBloc>(AnalyticsBloc(mixpanel: mixpanel));

    final bgImageBloc = BgImageBloc();
    if (bgImageBloc.state.imageList.isEmpty) {
      bgImageBloc.add(
        BgImageFetchOnFirstInstall(
          imageRepo: FirebaseImageRepository(),
        ),
      );
      await bgImageBloc
          .stream.first; // waiting for the image list to be populated
    }

    final apiCaller = ApiCaller();

/* ----------------------------- Error Reporting ---------------------------- */

    await SentryFlutter.init(
      (options) {
        options
          ..dsn = kDebugMode ? '' : Env.SENTRY_PATH
          ..debug = kDebugMode;
      },
      appRunner: () => runApp(
        LifeCycleManager(
          child: RepositoryProvider(
            create: (context) => LocationRepository(apiCaller: apiCaller),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<AppBloc>(
                  create: (context) => AppBloc(),
                ),
                BlocProvider<WeatherBloc>(
                  lazy: false,
                  create: (context) => WeatherBloc(
                    weatherRepository: WeatherRepository(
                      apiCaller: apiCaller,
                    ),
                  ),
                ),
                BlocProvider<BgImageBloc>.value(
                  value: bgImageBloc,
                ),
                BlocProvider<AnalyticsBloc>.value(
                  value: analytics,
                ),
                BlocProvider<CurrentWeatherCubit>(
                  create: (context) => CurrentWeatherCubit(),
                ),
                BlocProvider<HourlyForecastCubit>(
                  create: (context) => HourlyForecastCubit(),
                ),
                BlocProvider<DailyForecastCubit>(
                  create: (context) => DailyForecastCubit(),
                ),
                BlocProvider<AdBloc>(
                  create: (context) => AdBloc(storage: storage),
                ),
                BlocProvider<LocationBloc>(
                  create: (context) => LocationBloc(
                    locationRepository: context.read<LocationRepository>(),
                  )..add(LocationUpdateLocal()),
                ),
                BlocProvider<ColorCubit>(
                  create: (context) => ColorCubit(),
                ),
                BlocProvider<LocalWeatherButtonCubit>(
                  create: (context) => LocalWeatherButtonCubit(),
                ),
                BlocProvider<AppUpdateBloc>(
                  create: (context) => AppUpdateBloc(),
                ),
              ],
              child: const EpicSkies(),
            ),
          ),
        ),
      ),
    );
  }, (error, stack) {
    AppDebug.log('error: $error stack: $stack', name: 'runZonedGuarded');
  });
}

class EpicSkies extends StatefulWidget {
  const EpicSkies({
    super.key,
  });

  @override
  State<EpicSkies> createState() => _EpicSkiesState();
}

class _EpicSkiesState extends State<EpicSkies> {
  /// Prevents jank when bg images updates
  Future<void> _cacheAllBackgroundImages() async {
    final imageUrlList = context.read<BgImageBloc>().state.imageList;

    await Future.wait(
      imageUrlList.map(
        (image) async {
          return precacheImage(
            CachedNetworkImageProvider(image.imageUrl),
            context,
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cacheAllBackgroundImages();
  }

  @override
  Widget build(BuildContext context) {
    final appUpdateState = context.read<AppUpdateBloc>().state;
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      theme: defaultOpaqueBlack,
      initialRoute: appUpdateState.status.isFirstInstall
          ? WelcomeScreen.id
          : HomeTabView.id,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
