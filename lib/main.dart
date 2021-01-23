// import 'package:background_fetch/background_fetch.dart';
import 'package:epic_skies/screens/home_page.dart';
import 'package:epic_skies/screens/home_tab_controller.dart';
import 'package:epic_skies/services/user_authentication/email_registration_controller.dart';
import 'package:epic_skies/services/user_authentication/google_registration_controller.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/location_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/widgets/weather_image_container.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'global/app_theme.dart';
import 'local_constants.dart';
import 'misc/test_page.dart';
import 'screens/hourly_forecast_page.dart';
import 'screens/login_page.dart';
import 'screens/registration_page.dart';
import 'screens/sample_login.dart';
import 'screens/sign_in_wrapper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// void backgroundFetchHeadlessTask(String taskId) async {
//   print('[BackgroundFetch] Headless event received.');
//   BackgroundFetch.finish(taskId);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await GetStorage.init(locationMapKey);
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
  final controller = Get.put(WeatherController(), permanent: true);
  Get.put(WeatherController(), permanent: true);

  Get.put(LocationController(), permanent: true);
  Get.put(ForecastController(), permanent: true);
  Get.put(ImageController(), permanent: true);
  Get.put(LocationController(), permanent: true);
  Get.put(LocationController(), permanent: true);

  // Get.lazyPut<GoogleSignInController>(() => GoogleSignInController(),
  //     fenix: true);
  // Get.lazyPut<EmailRegistrationController>(() => EmailRegistrationController(),
  //     fenix: true);

/* -------------------------------------------------------------------------- */
/*                                  DATABASE                                  */
/* -------------------------------------------------------------------------- */
  // final Map<String, dynamic> map = GetStorage().read(dataMapKey);
  // controller.dataMap = map.obs;

  await controller.getAllWeatherData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: defaultOpaqueBlack,
      initialRoute: HomeTabController.id,
      getPages: [
        GetPage(name: HomeTabController.id, page: () => HomeTabController()),
        GetPage(name: HomePage.id, page: () => HomePage()),
        GetPage(name: HourlyForecastPage.id, page: () => HourlyForecastPage()),
        // GetPage(name: LoginPage.id, page: () => LoginPage()),
        GetPage(name: SignInDemo.id, page: () => SignInDemo()),
        // GetPage(name: SignInWrapperPage.id, page: () => SignInWrapperPage()),
        // GetPage(name: RegistrationPage.id, page: () => RegistrationPage()),
        GetPage(name: TestPage.id, page: () => TestPage()),
        GetPage(
            name: LocationRefreshScreen.id,
            page: () => LocationRefreshScreen()),
        // GetPage(
        //     name: LocationRefreshScreen2.id,
        //     page: () => LocationRefreshScreen2()),
      ],
    );
  }
}

// class LocationRefreshScreen2 extends StatefulWidget {
//   static const id = 'location_refresh_screen';

//   @override
//   _LocationRefreshScreen2State createState() => _LocationRefreshScreen2State();
// }

// class _LocationRefreshScreen2State extends State<LocationRefreshScreen2> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   refreshLocation();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     refreshLocation();

//     return Scaffold(
//       body: Container(
//         child: CircularProgressIndicator(backgroundColor: Colors.greenAccent),
//       ),
//     );
//   }
// }

class LocationRefreshScreen extends GetView<WeatherController> {
  static const id = 'location_refresh_screen';

  Future<void> refreshLocation() async {
    // Get.find<WeatherController>().initCurrentWeatherValues();
    // Get.find<LocationController>().initLocationValues();
    // await Get.find<ForecastController>().buildForecastWidgets();

    await Get.find<WeatherController>().getAllWeatherData();

    Get.to(HomeTabController());
  }

  @override
  Widget build(BuildContext context) {
    refreshLocation();
    return const Scaffold(
      body: WeatherImageContainer(
        child: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.greenAccent),
        ),
      ),
    );
  }
}
