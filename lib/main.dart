// import 'package:background_fetch/background_fetch.dart';
import 'package:epic_skies/screens/home_page.dart';
import 'package:epic_skies/screens/home_tab_controller.dart';
import 'package:epic_skies/screens/welcome_screen.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'global/app_theme.dart';
import 'misc/test_page.dart';
import 'screens/daily_forecast_page.dart';
import 'screens/hourly_forecast_page.dart';
// import 'screens/login_page.dart';
// import 'screens/registration_page.dart';
import 'screens/location_screen.dart';
import 'screens/sample_login.dart';
// import 'screens/sign_in_wrapper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// void backgroundFetchHeadlessTask(String taskId) async {
//   print('[BackgroundFetch] Headless event received.');
//   BackgroundFetch.finish(taskId);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

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

  final masterController = Get.put(MasterController());
  await masterController.onInit();
  masterController.startupSearch();

/* -------------------------------------------------------------------------- */
/*                                  DATABASE                                  */
/* -------------------------------------------------------------------------- */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // static final _myTabbedPageKey =  GlobalKey<HomeTabControllerState>();

  @override
  Widget build(BuildContext context) {
    final firstTime = Get.find<MasterController>().firstTimeUse.value;
    return GetMaterialApp(
      title: 'Epic Skies',
      debugShowCheckedModeBanner: false,
      theme: defaultOpaqueBlack,
      // initialRoute: HomeTabController.id,
      initialRoute: firstTime ? WelcomeScreen.id : HomeTabController.id,
      getPages: [
        GetPage(name: HomeTabController.id, page: () => HomeTabController()),
        GetPage(name: HomePage.id, page: () => HomePage()),
        GetPage(name: HourlyForecastPage.id, page: () => HourlyForecastPage()),
        GetPage(name: DailyForecastPage.id, page: () => DailyForecastPage()),
        GetPage(
            name: SavedLocationScreen.id, page: () => SavedLocationScreen()),
        // GetPage(name: LoginPage.id, page: () => LoginPage()),
        GetPage(name: SignInDemo.id, page: () => SignInDemo()),
        // GetPage(name: SignInWrapperPage.id, page: () => SignInWrapperPage()),
        // GetPage(name: RegistrationPage.id, page: () => RegistrationPage()),
        GetPage(name: TestPage.id, page: () => TestPage()),
        GetPage(name: WelcomeScreen.id, page: () => WelcomeScreen()),
        // GetPage(name: SearchPage.id, page: () => SearchPage()),
        // GetPage(
      ],
    );
  }
}
