// import 'package:background_fetch/background_fetch.dart';

import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'global/app_theme.dart';
import 'misc/test_page.dart';
import 'screens/settings_screens/bg_settings_screen.dart';
import 'screens/settings_screens/gallery_image_screen.dart';
import 'screens/settings_screens/units_screen.dart';
import 'screens/tab_screens/current_weather_page.dart';
import 'screens/tab_screens/daily_forecast_page.dart';
import 'screens/tab_screens/home_tab_view.dart';
import 'screens/tab_screens/hourly_forecast_page.dart';
import 'screens/tab_screens/saved_locations_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/settings_screens/settings_drawer.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// void backgroundFetchHeadlessTask(String taskId) async {
//   print('[BackgroundFetch] Headless event received.');
//   BackgroundFetch.finish(taskId);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light));

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); //

  await Firebase.initializeApp();

/* -------------------------------------------------------------------------- */
/*                                NOTIFICATIONS                               */
/* -------------------------------------------------------------------------- */

  // final NotificationAppLaunchDetails notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:
              (int id, String title, String body, String payload) async {});

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // selectNotificationSubject.add(payload);
  });

/* -------------------------------------------------------------------------- */
/*                               BACKGROUND TASKS                             */
/* -------------------------------------------------------------------------- */

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}

  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

/* -------------------------------------------------------------------------- */
/*                        INITIALIZING GETX CONTROLLERS                       */
/* -------------------------------------------------------------------------- */

  Get.put(MasterController());

  await MasterController.to.initControllers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firstTime = MasterController.to.firstTimeUse;

    return GetMaterialApp(
      title: 'Epic Skies',
      debugShowCheckedModeBanner: false,
      theme: defaultOpaqueBlack,
      // initialRoute: TestPage.id,
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
        GetPage(name: BgImageSettingsScreen.id, page: () => BgImageSettingsScreen()),
        GetPage(
            name: WeatherImageGallery.id, page: () => WeatherImageGallery()),
      ],
    );
  }
}
