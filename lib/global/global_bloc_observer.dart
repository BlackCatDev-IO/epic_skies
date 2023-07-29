import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final getIt = GetIt.instance;

class GlobalBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);

    switch (bloc.runtimeType) {
      case WeatherBloc:
        _reportWeatherBlocAnalytics(transition);
        break;
      case AdBloc:
        _reportAdBlocAnalytics(transition);
        break;
      case LocationBloc:
        _reportLocationBlocAnalytics(transition);
        break;
    }
    AppDebug.logBlocTransition(transition, '${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (error is AddressFormatException) {
      final locationBloc = bloc as LocationBloc;
      final locationModel = locationBloc.state.data;
      getIt<AnalyticsBloc>()
          .add(LocationAddressFormatError(locationModel: locationModel));
    }

    AppDebug.logSentryError(
      'Bloc onError: ${bloc.runtimeType} $error $stackTrace',
      name: 'onError',
      stack: stackTrace,
      hint: Hint.withMap({'bloc type:': '${bloc.runtimeType}'}),
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    AppDebug.log('Bloc closed: $bloc');
    super.onClose(bloc);
  }

  void _reportWeatherBlocAnalytics(Transition<dynamic, dynamic> transition) {
    final analytics = GetIt.instance<AnalyticsBloc>();

    final weatherState = transition.nextState as WeatherState;
    switch (weatherState.status) {
      case WeatherStatus.initial:
        break;
      case WeatherStatus.unitSettingsUpdate:
        analytics
            .add(UnitSettingsUpdate(unitSettings: weatherState.unitSettings));
        break;
      case WeatherStatus.loading:
        analytics.add(WeatherInfoRequested());
        break;
      case WeatherStatus.success:
        analytics.add(
          WeatherInfoAcquired(
            condition: weatherState.weatherModel!.currentCondition.conditions,
          ),
        );
        break;
      case WeatherStatus.error:
        analytics.add(WeatherInfoError());
        break;
    }
  }

  void _reportAdBlocAnalytics(Transition<dynamic, dynamic> transition) {
    final analytics = getIt<AnalyticsBloc>();
    final event = transition.event;
    final adState = transition.nextState as AdState;

    if (event is AdFreePurchaseRequest && adState.status.isLoading) {
      analytics.add(IapPurchaseAttempted());
    }

    if (event is AdFreeRestorePurchase && adState.status.isLoading) {
      analytics.add(IapRestorePurchaseAttempted());
    }

    switch (adState.status) {
      case AdFreeStatus.initial:
      case AdFreeStatus.loading:
        break;
      case AdFreeStatus.adFreeRestored:
        analytics.add(IapRestorePurchaseSuccess());
        break;
      case AdFreeStatus.error:
        analytics.add(IapPurchaseError(adState.errorMessage));
        break;
      case AdFreeStatus.showAds:
        break;
      case AdFreeStatus.adFreePurchased:
        analytics.add(IapPurchaseSuccess());
        break;
      case AdFreeStatus.trialPeriod:
        break;
      case AdFreeStatus.trialEnded:
        analytics.add(IapTrialEnded());
        break;
    }
  }

  void _reportLocationBlocAnalytics(Transition<dynamic, dynamic> transition) {
    final analytics = getIt<AnalyticsBloc>();

    final event = transition.event as LocationEvent;
    final locationState = transition.nextState as LocationState;

    if (event is LocationUpdateLocal) {
      switch (locationState.status) {
        case LocationStatus.initial:
          break;
        case LocationStatus.loading:
          analytics.add(LocationRequested());
          break;
        case LocationStatus.locationDisabled:
          analytics.add(LocationDisabled());
        case LocationStatus.noLocationPermission:
          analytics.add(LocationNoPermission());
          break;
        case LocationStatus.error:
          analytics.add(LocalLocationError());
          break;
        case LocationStatus.success:
          analytics.add(
            LocalLocationAcquired(
              locationModel: locationState.data,
            ),
          );
          break;
      }
    }
  }
}
