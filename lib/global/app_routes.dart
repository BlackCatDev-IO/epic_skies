import 'package:dio/dio.dart';
import 'package:epic_skies/services/analytics/analytics_service.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/screens/search_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/image_credit_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/settings_main_page.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final routes = {
    WelcomeScreen.id: (context) => const WelcomeScreen(),
    HomeTabView.id: (context) => const HomeTabView(),
    UnitsScreen.id: (context) => const UnitsScreen(),
    BgImageSettingsScreen.id: (context) => const BgImageSettingsScreen(),
    WeatherImageGallery.id: (context) => WeatherImageGallery(),
    SearchScreen.id: (context) => const SearchScreen(),
    AboutPage.id: (context) => const AboutPage(),
    ImageCreditScreen.id: (context) => const ImageCreditScreen(),
    SettingsMainPage.id: (context) => const SettingsMainPage(),
  };
}

class AppRouteObserver extends NavigatorObserver {
  final analytics = getIt<AnalyticsService>();
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) return;

    try {
      final routeName = route.settings.name!.replaceAll('/', '');
      analytics.trackEvent('push_$routeName', isPageView: true);
    } catch (e) {
      _logRouteObserverError(e);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) return;

    try {
      final routeName = route.settings.name!.replaceAll('/', '');
      analytics.trackEvent(routeName, isPageView: true);
    } catch (e) {
      _logRouteObserverError(e);
    }
  }

  void _logRouteObserverError(dynamic e) {
    AppDebug.logSentryError(
      e is DioException ? e.error ?? e.response : e,
      name: 'AppRouteObserver',
    );
  }
}
