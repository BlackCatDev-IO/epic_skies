import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      case BgImageBloc:
        _reportBgImageBlocAnalytics(transition);
        break;
    }
    AppDebug.logBlocTransition(transition, '${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (error is AddressFormatException) {
      final locationBloc = bloc as LocationBloc;
      final locationModel = locationBloc.state.localData;
      getIt<AnalyticsBloc>()
          .add(LocationAddressFormatError(locationModel: locationModel));
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    AppDebug.log('Bloc closed: $bloc');
    super.onClose(bloc);
  }

  void _reportWeatherBlocAnalytics(Transition<dynamic, dynamic> transition) {
    final analytics = getIt<AnalyticsBloc>();

    final weatherState = transition.nextState as WeatherState;
    switch (weatherState.status) {
      case WeatherStatus.initial:
        break;
      case WeatherStatus.unitSettingsUpdate:
        analytics
            .add(UnitSettingsUpdate(unitSettings: weatherState.unitSettings));

      case WeatherStatus.success:
        if (weatherState.weather != null) {
          analytics.add(
            WeatherInfoAcquired(
              condition: weatherState.weather!.currentWeather.conditionCode,
            ),
          );

          _checkForWeatherAlerts(weatherState);
        } else {
          analytics.add(
            WeatherInfoAcquired(
              condition: weatherState.weatherModel!.currentCondition.conditions,
            ),
          );
        }
      case WeatherStatus.error:
        analytics.add(
          WeatherInfoError(
            errorMessage:
                weatherState.errorModel?.message ?? 'No error message provided',
          ),
        );
        break;
      default:
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

  void _reportLocationBlocAnalytics(
    Transition<dynamic, dynamic> transition,
  ) {
    final analytics = getIt<AnalyticsBloc>();

    final event = transition.event;
    final locationState = transition.nextState as LocationState;

    if (event is LocationUpdateLocal) {
      switch (locationState.status) {
        case LocationStatus.initial:
          break;

        case LocationStatus.locationDisabled:
          analytics.add(LocationDisabled());
        case LocationStatus.noLocationPermission:
          analytics.add(LocationNoPermission());
          break;
        case LocationStatus.error:
          analytics.add(
            LocalLocationError(
              error: locationState.errorModel?.message ?? 'Unknown Error',
            ),
          );
          break;
        case LocationStatus.success:
          analytics.add(
            LocalLocationAcquired(
              locationModel: locationState.localData,
            ),
          );
          break;
        default:
          return;
      }
    }

    if (event is LocationUpdateRemote && locationState.status.isLoading) {
      analytics.add(
        RemoteLocationRequested(searchSuggestion: event.searchSuggestion),
      );
    }
  }

  void _reportBgImageBlocAnalytics(
    Transition<dynamic, dynamic> transition,
  ) {
    final analytics = getIt<AnalyticsBloc>();

    final event = transition.event;
    final currentState = transition.currentState as BgImageState;
    final nextState = transition.nextState as BgImageState;

    if (event is BgImageSelectFromAppGallery &&
        nextState.imageSettings.isAppGallery) {
      analytics.logAnalyticsEvent(
        AnalyticsEvent.bgImageGallerySelected.name,
        {'image': nextState.bgImagePath},
      );
    }
    if (event is BgImageSelectFromDeviceGallery &&
        nextState.imageSettings.isDeviceGallery) {
      analytics.logAnalyticsEvent(
        AnalyticsEvent.bgImageDeviceSelected.name,
      );
    }

    if (!currentState.imageSettings.isDynamic &&
        nextState.imageSettings.isDynamic) {
      analytics.logAnalyticsEvent(
        AnalyticsEvent.bgImageDynamicSelected.name,
      );
    }
  }

  void _checkForWeatherAlerts(WeatherState weatherState) {
    final alertModel = weatherState.alertModel;

    if (alertModel.precipNotice.precipAlertType.isNoPrecip &&
        alertModel.weatherAlert.weatherAlertMessage.isEmpty) {
      return;
    }

    getIt<AnalyticsBloc>().add(
      WeatherAlertProvided(
        weather: weatherState.weather!,
        alertModel: weatherState.alertModel,
      ),
    );
  }
}
