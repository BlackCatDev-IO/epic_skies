import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_preview/device_preview.dart';
import 'package:epic_skies/core/network/api_service.dart';
import 'package:epic_skies/core/network/weather_kit/weather_kit_client.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/locale/locale_repository.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:epic_skies/global/app_routes.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/global/global_bloc_observer.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/lifecyle/lifecyle_manager.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

Future<void> _initStorageDirectory() async {
  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: directory);
}

/// env code generation can't parse PEM key in format of
/// ------Begin Private Key--- etc...so its generated as a json string this just
///  removes the tags
String _removeP8Tags(String pemKey) {
  final startIndex = pemKey.indexOf('{p8:');
  final endIndex = pemKey.lastIndexOf('}');

  return pemKey.substring(startIndex + 4, endIndex).trim();
}

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = GlobalBlocObserver();

  final apiService = ApiService();
  final locationRepository = LocationRepository(apiService: apiService);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final localeRepository = LocaleRepository();
  final systemInfo = SystemInfoRepository();

  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    ),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]), // disable landscape
    _initStorageDirectory(),
    localeRepository.init(),
    systemInfo.initDeviceInfo(),
  ]);

  await registerServices(systemInfo);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppDebug.log(
      'FlutterError.onError',
      error: details.exception,
      isError: true,
    );
    getIt<AnalyticsBloc>().logAnalyticsEvent(
      AnalyticsEvent.error.name,
      info: {
        'error': '${details.exception}',
      },
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppDebug.log(
      '$error',
      error: error,
      stack: stack,
      isError: true,
    );
    getIt<AnalyticsBloc>().logAnalyticsEvent(
      AnalyticsEvent.error.name,
      info: {
        'error': '$error',
      },
    );
    return true;
  };

  final locationBloc = LocationBloc(
    locationRepository: locationRepository,
    localeRepository: LocaleRepository(),
  )..add(LocationUpdateLocal());

  final bgImageBloc = BgImageBloc();

  if (bgImageBloc.state.status.isInitial || bgImageBloc.state.status.isError) {
    bgImageBloc.add(BgImageFetchOnFirstInstall());

    await bgImageBloc.stream.firstWhere((state) => !state.status.isLoading);
  }

  if (!kReleaseMode) {
    await Upgrader.clearSavedSettings();
  }

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = kDebugMode ? '' : Env.SENTRY_PATH
        ..debug = kDebugMode;
    },
    appRunner: () async {
      runApp(
        DevicePreview(
          enabled: false,
          builder: (context) => LifeCycleManager(
            child: RepositoryProvider(
              create: (context) => LocationRepository(apiService: apiService),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<AppBloc>(
                    create: (context) => AppBloc()..add(AppNotifyLoading()),
                  ),
                  BlocProvider<LocationBloc>.value(
                    value: locationBloc,
                  ),
                  BlocProvider<WeatherBloc>(
                    lazy: false,
                    create: (context) => WeatherBloc(
                      weatherRepository: WeatherRepository(
                        service: apiService,
                        weatherKitClient: WeatherKitClient(
                          serviceId: Env.WEATHER_SERVICE_ID,
                          keyId: Env.WEATHER_KIT_KEY_ID,
                          teamId: Env.APPLE_TEAM_ID,
                          p8: _removeP8Tags(Env.WEATHER_KIT_P8),
                        ),
                      ),
                    ),
                  ),
                  BlocProvider<BgImageBloc>.value(
                    value: bgImageBloc,
                  ),
                  BlocProvider<AnalyticsBloc>.value(
                    value: getIt<AnalyticsBloc>(),
                  ),
                  BlocProvider<CurrentWeatherCubit>(
                    create: (context) => CurrentWeatherCubit(),
                  ),
                  BlocProvider<HourlyForecastCubit>(
                    create: (context) => HourlyForecastCubit(),
                  ),
                  BlocProvider<DailyForecastCubit>(
                    create: (context) => DailyForecastCubit(),
                  ),
                  BlocProvider<AdBloc>(
                    lazy: false,
                    create: (context) => AdBloc(),
                  ),
                  BlocProvider<ColorCubit>(
                    create: (_) => ColorCubit(),
                  ),
                  BlocProvider<LocalWeatherButtonCubit>(
                    create: (context) => LocalWeatherButtonCubit(),
                  ),
                  BlocProvider<AppUpdateBloc>(create: (_) => AppUpdateBloc()),
                ],
                child: const EpicSkies(),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class EpicSkies extends StatefulWidget {
  const EpicSkies({
    super.key,
  });

  @override
  State<EpicSkies> createState() => _EpicSkiesState();
}

class _EpicSkiesState extends State<EpicSkies> {
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

    return MaterialApp(
      navigatorObservers: [
        AppRouteObserver(),
      ],
      builder: (context, child) {
        final responsiveWrapper = ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
        return DevicePreview.appBuilder(context, responsiveWrapper);
      },
      theme: epicSkiesTheme,
      initialRoute:
          (locationStatus.isSuccess || !appUpdateState.status.isFirstInstall)
              ? HomeTabView.id
              : WelcomeScreen.id,
      locale: DevicePreview.locale(context),
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
