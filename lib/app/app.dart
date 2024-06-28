import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/locale/cubit/locale_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/global/app_routes.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ImageProvider _startingBgImage;
  late ImageProvider earthFromSpaceAssetImage;

  final precacheList = <Future<void>>[];

  Future<void> _initBgImageProviders() async {
    earthFromSpaceAssetImage = const AssetImage(earthFromSpace);

    precacheList.add(
      precacheImage(earthFromSpaceAssetImage, context),
    );

    final bgImagePath = context.read<BgImageBloc>().state.bgImagePath;

    if (bgImagePath.isNotEmpty) {
      _startingBgImage = CachedNetworkImageProvider(bgImagePath);
      precacheList.add(precacheImage(_startingBgImage, context));
    }
  }

  Future<void> _cacheAllBackgroundImages() async {
    await Future.wait(precacheList);
    FlutterNativeSplash.remove();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initBgImageProviders();
    _cacheAllBackgroundImages();
  }

  @override
  Widget build(BuildContext context) {
    final appUpdateState = context.read<AppUpdateBloc>().state;
    final locationStatus = context.read<LocationBloc>().state.status;

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorObservers: [
            AppRouteObserver(),
          ],
          locale: state.userSetLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            final responsiveWrapper = ResponsiveWrapper.builder(
              child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
            );
            return responsiveWrapper;
          },
          theme: epicSkiesTheme,
          initialRoute: (locationStatus.isSuccess ||
                  !appUpdateState.status.isFirstInstall)
              ? HomeTabView.id
              : WelcomeScreen.id,
          routes: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
