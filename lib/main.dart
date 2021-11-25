import 'dart:io';

import 'package:epic_skies/global/global_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';

import 'core/database/storage_controller.dart';
import 'core/network/sentry_path.dart';
import 'global/app_routes.dart';
import 'global/app_theme.dart';
import 'services/notifications/firebase_notifications.dart';
import 'view/screens/settings_screens/drawer_animator.dart';
import 'view/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

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

  await GlobalBindings().dependencies();

/* -------------------------------------------------------------------------- */
/*                               ERROR REPORTING                              */
/* -------------------------------------------------------------------------- */

  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode ? '' : sentryPath;
    },
    appRunner: () => runApp(EpicSkies()),
  );
}

class EpicSkies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool firstTime = StorageController.to.firstTimeUse();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Epic Skies',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          theme: defaultOpaqueBlack,
          // initialRoute: WelcomeScreen.id,
          initialRoute: firstTime ? WelcomeScreen.id : DrawerAnimator.id,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
