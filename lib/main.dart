import 'package:black_cat_lib/constants.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'global/app_theme.dart';
import 'misc/test_page.dart';

import 'services/notifications/firebase_notifications.dart';
import 'view/screens/custom_search_delegate.dart';
import 'view/screens/settings_screens/bg_settings_screen.dart';
import 'view/screens/settings_screens/drawer_animator.dart';
import 'view/screens/settings_screens/gallery_image_screen.dart';
import 'view/screens/settings_screens/units_screen.dart';
import 'view/screens/tab_screens/current_weather_page.dart';
import 'view/screens/tab_screens/daily_forecast_page.dart';
import 'view/screens/tab_screens/home_tab_view.dart';
import 'view/screens/tab_screens/hourly_forecast_page.dart';
import 'view/screens/tab_screens/saved_locations_screen.dart';
import 'view/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light));

  await Future.wait([
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]), // disable landscape
    Firebase.initializeApp(),
  ]);

/* -------------------------------------------------------------------------- */
/*                                NOTIFICATIONS                               */
/* -------------------------------------------------------------------------- */

  await initFirebaseNotifications();

/* -------------------------------------------------------------------------- */
/*                        INITIALIZING GETX CONTROLLERS                       */
/* -------------------------------------------------------------------------- */

  Get.put(MasterController());
  await MasterController.to.initControllers();

  debugPrint('width: $screenWidth height: $screenHeight');

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://b108bdc58b82491fa6b946fd2f913b5c@o577447.ingest.sentry.io/5732203';
  //   },
  //   appRunner: () => runApp(
  //     EpicSkies(),
  //   ),
  // );
  runApp(EpicSkies());
}

class EpicSkies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firstTime = MasterController.to.firstTimeUse;

    return GetMaterialApp(
      title: 'Epic Skies',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,

      theme: defaultOpaqueBlack,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(600, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
        ],
      ),
      // initialRoute: WelcomeScreen.id,
      initialRoute: firstTime ? WelcomeScreen.id : CustomAnimatedDrawer.id,
      getPages: [
        GetPage(
            name: CustomAnimatedDrawer.id,
            page: () => const CustomAnimatedDrawer()),
        GetPage(name: HomeTabView.id, page: () => HomeTabView()),
        GetPage(name: CurrentWeatherPage.id, page: () => CurrentWeatherPage()),
        GetPage(name: HourlyForecastPage.id, page: () => HourlyForecastPage()),
        GetPage(name: DailyForecastPage.id, page: () => DailyForecastPage()),
        GetPage(
            name: SavedLocationScreen.id, page: () => SavedLocationScreen()),
        GetPage(name: TestPage.id, page: () => TestPage()),
        GetPage(name: WelcomeScreen.id, page: () => WelcomeScreen()),
        GetPage(name: UnitsScreen.id, page: () => UnitsScreen()),
        GetPage(
            name: BgImageSettingsScreen.id,
            page: () => BgImageSettingsScreen()),
        GetPage(
            name: WeatherImageGallery.id, page: () => WeatherImageGallery()),
        GetPage(
          name: CustomSearchDelegate.id,
          page: () => const CustomSearchDelegate(),
        ),
      ],
    );
  }
}
