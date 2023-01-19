import 'dart:async';
import 'dart:io';

import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/global/global_bindings.dart';
import 'package:epic_skies/global/global_bloc_observer.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/env/env.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';
import 'core/database/file_controller.dart';
import 'core/database/storage_controller.dart';
import 'core/network/api_caller.dart';
import 'core/network/sentry_path.dart';
import 'features/analytics/bloc/analytics_bloc.dart';
import 'features/banner_ads/bloc/ad_bloc.dart';
import 'features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'features/location/bloc/location_bloc.dart';
import 'features/main_weather/bloc/weather_bloc.dart';
import 'global/app_bloc/app_bloc.dart';
import 'global/app_routes.dart';
import 'global/app_theme.dart';
import 'services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = GlobalBlocObserver();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final adaptiveLayout = AdaptiveLayout(hasNotch: IphoneHasNotch.hasNotch);

    await adaptiveLayout.setAdaptiveHeights();

    GetIt.instance.registerSingleton<AdaptiveLayout>(
      adaptiveLayout,
    );

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }

    await Future.wait([
      MobileAds.instance.initialize(),
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]), // disable landscape
      Env.loadEnv(),
      Firebase.initializeApp(),
    ]);

    // await initFirebaseNotifications();

    final storage = StorageController();
    await storage.initAllStorage();

    final mixpanel = await Mixpanel.init(
      Env.mixPanelToken,
      trackAutomaticEvents: true,
    );

    final analytics = AnalyticsBloc(mixpanel: mixpanel);

    GetIt.instance.registerSingleton<AnalyticsBloc>(analytics);

    await GlobalBindings().initGetxControllers(storage: storage);

    final fileController = FileController(storage: storage);

    final fileMap = await fileController.restoreImageFiles();

    final apiCaller = ApiCaller();

/* ----------------------------- Error Reporting ---------------------------- */

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : sentryPath;
        options.debug = kDebugMode;
      },
      appRunner: () => runApp(
        RepositoryProvider(
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
                    storage: storage,
                    apiCaller: apiCaller,
                  ),
                ),
              ),
              BlocProvider<BgImageBloc>(
                lazy: false,
                create: (context) {
                  return BgImageBloc(
                    storage: storage,
                    fileMap: fileMap,
                  );
                },
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
            ],
            child: EpicSkies(isNewInstall: storage.firstTimeUse()),
          ),
        ),
      ),
    );
  }, (error, stack) {
    AppDebug.log('error: $error stack: $stack', name: 'runZonedGuarded');
  });
}

class EpicSkies extends StatelessWidget {
  const EpicSkies({required this.isNewInstall});

  final bool isNewInstall;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: defaultOpaqueBlack,
          initialRoute: isNewInstall ? WelcomeScreen.id : HomeTabView.id,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
