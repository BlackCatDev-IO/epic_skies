import 'dart:io';

import 'package:epic_skies/global/global_bindings.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';

import 'core/database/storage_controller.dart';
import 'core/network/sentry_path.dart';
import 'global/app_routes.dart';
import 'global/app_theme.dart';
import 'services/notifications/firebase_notifications.dart';
import 'view/screens/tab_screens/home_tab_view.dart';
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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          theme: defaultOpaqueBlack,
          onInit: () => AdaptiveLayoutController.to.setAdaptiveHeights(
            context: context,
            hasNotch: IphoneHasNotch.hasNotch,
          ),
          initialRoute: StorageController.to.firstTimeUse()
              ? WelcomeScreen.id
              : HomeTabView.id,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
