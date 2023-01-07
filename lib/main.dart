import 'dart:async';
import 'dart:io';

import 'package:epic_skies/global/global_bindings.dart';
import 'package:epic_skies/global/global_bloc_observer.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/utils/env/env.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';
import 'core/database/storage_controller.dart';
import 'core/network/sentry_path.dart';
import 'features/analytics/bloc/analytics_bloc.dart';
import 'features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'features/main_weather/bloc/weather_bloc.dart';
import 'global/app_routes.dart';
import 'global/app_theme.dart';
import 'services/notifications/firebase_notifications.dart';
import 'utils/ui_updater/ui_updater.dart';
import 'view/screens/tab_screens/home_tab_view.dart';
import 'view/screens/welcome_screen.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();

    Bloc.observer = GlobalBlocObserver();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
    await dotenv.load();

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]), // disable landscape
      Firebase.initializeApp(),
    ]);

/* -------------------------------------------------------------------------- */
/*                                NOTIFICATIONS                               */
/* -------------------------------------------------------------------------- */

    await initFirebaseNotifications();

/* -------------------------------------------------------------------------- */
/*                        INITIALIZING GETX CONTROLLERS                       */
/* -------------------------------------------------------------------------- */

    final storage = Get.put(StorageController(), permanent: true);
    await storage.initAllStorage();

    final weatherRepo = WeatherRepository(storage: storage);

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

    await GlobalBindings()
        .initGetxControllers(storage: storage, weatherBloc: weatherBloc);

    if (!storage.firstTimeUse() && storage.isTwoDotEightInstalled()) {
      UiUpdater.refreshUI(weatherBloc.state);
    }

/* -------------------------------------------------------------------------- */
/*                               ERROR REPORTING                              */
/* -------------------------------------------------------------------------- */

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : sentryPath;
      },
      appRunner: () => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: weatherBloc..add(LocalWeatherUpdated()),
            ),
            BlocProvider<AnalyticsBloc>.value(
              value: analytics,
            ),
            BlocProvider<CurrentWeatherCubit>(
              create: (context) =>
                  CurrentWeatherCubit(weatherState: weatherBloc.state),
            ),
          ],
          child: EpicSkies(weatherBloc: weatherBloc),
        ),
      ),
    );
  }, (error, stack) {
    AppDebug.log('error: $error stack: $stack', name: 'runZonedGuarded');
  });
}

class EpicSkies extends StatelessWidget {
  const EpicSkies({required this.weatherBloc});
  final WeatherBloc weatherBloc;

  @override
  Widget build(BuildContext context) {
    final firstTime = StorageController.to.firstTimeUse();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: defaultOpaqueBlack,
          initialRoute: firstTime ? WelcomeScreen.id : HomeTabView.id,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
