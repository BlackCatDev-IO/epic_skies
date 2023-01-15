import 'dart:async';
import 'dart:io';

import 'package:epic_skies/global/global_bindings.dart';
import 'package:epic_skies/global/global_bloc_observer.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
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
import 'core/database/storage_controller.dart';
import 'core/network/api_caller.dart';
import 'core/network/sentry_path.dart';
import 'features/analytics/bloc/analytics_bloc.dart';
import 'features/banner_ads/bloc/ad_bloc.dart';
import 'features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'features/location/remote_location/bloc/location_bloc.dart';
import 'features/main_weather/bloc/weather_bloc.dart';
import 'global/app_bloc/app_bloc.dart';
import 'global/app_routes.dart';
import 'global/app_theme.dart';
import 'services/notifications/firebase_notifications.dart';
import 'utils/ui_updater/ui_updater.dart';

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

    final adaptiveLayout = AdaptiveLayout(hasNotch: IphoneHasNotch.hasNotch)
      ..setAdaptiveHeights();

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

    await initFirebaseNotifications();

    final storage = StorageController();
    await storage.initAllStorage();

    final apiCaller = ApiCaller();

    final weatherRepo =
        WeatherRepository(storage: storage, apiCaller: apiCaller);

    final mixpanel = await Mixpanel.init(
      Env.mixPanelToken,
      trackAutomaticEvents: true,
    );

    final analytics = AnalyticsBloc(mixpanel: mixpanel);

    final weatherBloc = WeatherBloc(
      weatherModel: storage.restoreWeatherData(),
      weatherRepository: weatherRepo,
      unitSettings: storage.savedUnitSettings(),
    );

    GetIt.instance.registerSingleton<AnalyticsBloc>(analytics);

    await GlobalBindings().initGetxControllers(storage: storage);

    if (!storage.firstTimeUse() && storage.isTwoDotEightInstalled()) {
      UiUpdater.refreshUI(weatherBloc.state);
    }

/* ----------------------------- Error Reporting ---------------------------- */

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : sentryPath;
        options.debug = kDebugMode;
      },
      appRunner: () => runApp(
        RepositoryProvider(
          create: (context) =>
              LocationRepository(storage: storage, apiCaller: apiCaller),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AppBloc>(
                create: (context) => AppBloc(),
              ),
              BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
              ),
              BlocProvider<AnalyticsBloc>.value(
                value: analytics,
              ),
              BlocProvider<CurrentWeatherCubit>(
                create: (context) =>
                    CurrentWeatherCubit(weatherState: weatherBloc.state),
              ),
              BlocProvider<AdBloc>(
                create: (context) => AdBloc(storage: storage),
              ),
              BlocProvider<LocationBloc>(
                create: (context) => LocationBloc(
                  searchHistory: storage.restoreSearchHistory(),
                  locationRepository: context.read<LocationRepository>(),
                  locationModel: storage.restoreLocalLocationData(),
                )..add(LocationUpdateLocal()),
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
