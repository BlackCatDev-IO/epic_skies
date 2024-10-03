import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/analytics/analytics_service.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _analytics = getIt<AnalyticsService>();

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
      case AdBloc:
        _reportAdBlocAnalytics(transition as Transition<AdEvent, AdState>);
      case LocationBloc:
        _reportLocationBlocAnalytics(transition);
      case BgImageBloc:
        _reportBgImageBlocAnalytics(transition);
      case AppUpdateBloc:
        _reportAppUpdateBlocAnalytics(
          transition as Transition<AppUpdateEvent, AppUpdateState>,
        );
    }
    AppDebug.logBlocTransition(transition, '${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppDebug.logCubitChange(change, '${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (error is AddressFormatException) {
      final locationBloc = bloc as LocationBloc;
      final locationModel = locationBloc.state.localData.toMap();
      _analytics.trackEvent(
        AnalyticsEvent.locationAddressFormatError.name,
        info: locationModel,
      );
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    AppDebug.log('Bloc closed: $bloc');
    super.onClose(bloc);
  }

  void _reportWeatherBlocAnalytics(Transition<dynamic, dynamic> transition) {
    final weatherState = transition.nextState as WeatherState;
    switch (weatherState.status) {
      case WeatherStatus.initial:
        break;
      case WeatherStatus.unitSettingsUpdate:
        _analytics.trackEvent(
          AnalyticsEvent.unitSettingsUpdated.name,
          info: weatherState.unitSettings.toMap(),
        );

      case WeatherStatus.success:
        if (!weatherState.useBackupApi) {
          _analytics.trackEvent(
            AnalyticsEvent.weatherInfoAcquired.name,
            info: {
              'condition': weatherState.weather!.currentWeather.conditionCode,
            },
          );

          _checkForWeatherAlerts(weatherState);
        } else {
          _analytics.trackEvent(
            AnalyticsEvent.weatherInfoAcquired.name,
            info: {
              'condition':
                  weatherState.weatherModel!.currentCondition.conditions,
            },
          );
        }
      case WeatherStatus.error:
        _analytics.trackEvent(
          AnalyticsEvent.weatherInfoError.name,
          info: {
            'error':
                weatherState.errorModel?.message ?? 'No error message provided',
          },
        );

      default:
        break;
    }
  }

  void _reportAdBlocAnalytics(Transition<AdEvent, AdState> transition) {
    final event = transition.event;
    final currentState = transition.currentState;
    final nextState = transition.nextState;

    if (event is AdFreePurchaseRequest && nextState.status.isLoading) {
      _analytics.trackEvent(AnalyticsEvent.adFreePurchaseAttempted.name);
    }

    if (event is AdFreeRestorePurchase && nextState.status.isLoading) {
      _analytics.trackEvent(
        AnalyticsEvent.adFreeRestorePurchaseAttempted.name,
      );
    }

    if (currentState.status.isLoading && nextState.status.isAdFreePurchased) {
      _analytics.trackEvent(AnalyticsEvent.adFreePurchaseSuccess.name);
    }

    switch (nextState.status) {
      case AdFreeStatus.initial:
      case AdFreeStatus.loading:
        break;
      case AdFreeStatus.adFreeRestored:
        _analytics.trackEvent(
          AnalyticsEvent.adFreeRestorePurchaseSuccess.name,
        );
      case AdFreeStatus.error:
        _analytics.trackEvent(
          AnalyticsEvent.adFreePurchaseError.name,
          info: {'error': nextState.errorMessage},
        );
      case AdFreeStatus.showAds:
      case AdFreeStatus.trialPeriod:
      case AdFreeStatus.trialEnded:
        _analytics.trackEvent(
          AnalyticsEvent.adFreeTrialEnded.name,
        );
      default:
    }
  }

  void _reportLocationBlocAnalytics(
    Transition<dynamic, dynamic> transition,
  ) {
    final event = transition.event;
    final locationState = transition.nextState as LocationState;

    if (event is LocationUpdateLocal) {
      switch (locationState.status) {
        case LocationStatus.initial:
          break;

        case LocationStatus.locationDisabled:
          _analytics.trackEvent(AnalyticsEvent.locationDisabled.name);
        case LocationStatus.noLocationPermission:
          _analytics.trackEvent(AnalyticsEvent.locationNoPermission.name);

        case LocationStatus.error:
          _analytics.trackEvent(
            AnalyticsEvent.locationError.name,
            info: {
              'error': locationState.errorModel?.message ?? 'Unknown Error',
            },
          );

        case LocationStatus.success:
          _analytics.trackEvent(
            AnalyticsEvent.localLocationAcquired.name,
            info: locationState.localData.toMap(),
          );

        default:
          return;
      }
    }

    if (event is LocationUpdateRemote && locationState.status.isLoading) {
      final place = event.searchSuggestion.toMap()['description'];
      final data = {'place': place};
      _analytics.trackEvent(
        AnalyticsEvent.remoteLocationRequested.name,
        info: data,
      );
    }
  }

  void _reportBgImageBlocAnalytics(
    Transition<dynamic, dynamic> transition,
  ) {
    final event = transition.event;
    final currentState = transition.currentState as BgImageState;
    final nextState = transition.nextState as BgImageState;

    if (event is BgImageSelectFromAppGallery &&
        nextState.imageSettings.isAppGallery) {
      _analytics.trackEvent(
        AnalyticsEvent.bgImageGallerySelected.name,
        info: {'image': nextState.bgImagePath},
      );
    }
    if (event is BgImageSelectFromDeviceGallery &&
        nextState.imageSettings.isDeviceGallery) {
      _analytics.trackEvent(
        AnalyticsEvent.bgImageDeviceSelected.name,
      );
    }

    if (!currentState.imageSettings.isDynamic &&
        nextState.imageSettings.isDynamic) {
      _analytics.trackEvent(
        AnalyticsEvent.bgImageDynamicSelected.name,
      );
    }
  }

  void _reportAppUpdateBlocAnalytics(
    Transition<AppUpdateEvent, AppUpdateState> transition,
  ) {
    final nextState = transition.nextState;
    final appUpdated = nextState.status.isUpdatedShowUpdateDialog ||
        nextState.status.isUpdatedNoDialog;

    if (appUpdated) {
      _analytics.trackEvent(AnalyticsEvent.appUpdated.name);

      if (nextState.status.isUpdatedShowUpdateDialog) {
        _analytics.trackEvent(
          AnalyticsEvent.updateDialogShown.name,
          info: {'message': nextState.updatedChanges},
        );
      }
    }
  }

  void _checkForWeatherAlerts(WeatherState weatherState) {
    final alertModel = weatherState.alertModel;

    if (alertModel.precipNotice.precipAlertType.isNoPrecip &&
        alertModel.weatherAlert.weatherAlertMessage.isEmpty) {
      return;
    }

    _analytics.trackEvent(
      AnalyticsEvent.weatherAlertProvided.name,
      info: {
        'alert': weatherState.alertModel.toMap(),
        'weather': weatherState.weather!.forecastNextHour?.toMap(),
      },
    );
  }
}
