import 'package:dio/dio.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/analytics/umami_service.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
part 'analytics_event.dart';
part 'analytics_state.dart';

enum AnalyticsEvent {
  appUpdated,
  weatherKitTimeout,
  bgImageDeviceSelected,
  bgImageDynamicSelected,
  bgImageGallerySelected,
  updateDialogShown,
  adFreePurchaseAttempted,
  adFreePurchaseSuccess,
  adFreeRestorePurchaseAttempted,
  adFreeRestorePurchaseSuccess,
  adFreePurchaseError,
  adFreeTrialEnded,
  error,
}

class AnalyticsBloc extends Bloc<BaseAnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({required Mixpanel mixpanel, required bool isStaging})
      : _mixPanel = mixpanel,
        _isStaging = isStaging,
        super(const AnalyticsState()) {
/* -------------------------------- Location -------------------------------- */

    on<LocalLocationAcquired>(
      (event, _) {
        final location = event.locationModel.toMap();
        logAnalyticsEvent(event.eventName, info: location);
      },
    );
    on<LocalLocationError>((event, _) => logAnalyticsEvent(event.eventName));
    on<LocationAddressFormatError>(
      (event, _) {
        logAnalyticsEvent(event.eventName, info: event.locationModel.toMap());
      },
    );
    on<LocationDisabled>((event, _) => logAnalyticsEvent(event.eventName));
    on<LocationNoPermission>((event, _) => logAnalyticsEvent(event.eventName));
    on<RemoteLocationRequested>((event, _) {
      final place = event.searchSuggestion.toMap()['description'];
      final data = {'place': place};
      logAnalyticsEvent(event.eventName, info: data);
    });

/* --------------------------------- Weather -------------------------------- */

    on<WeatherInfoAcquired>((event, _) {
      final data = {'condition': event.condition};
      logAnalyticsEvent(event.eventName, info: data);
    });
    on<WeatherAlertProvided>((event, _) {
      final data = {
        'alert': event.alertModel.toMap(),
        'weather': event.weather.forecastNextHour?.toMap(),
      };
      logAnalyticsEvent(event.eventName, info: data);
    });
    on<WeatherInfoError>((event, _) => logAnalyticsEvent(event.eventName));

/* -------------------------------- Settings -------------------------------- */

    on<UnitSettingsUpdate>((event, _) {
      final unitSettings = event.unitSettings.toMap();
      logAnalyticsEvent(event.eventName, info: unitSettings);
    });
  }

  final Mixpanel _mixPanel;

  final bool _isStaging;

  /// List of personal testing devices that should not log analytics events
  final _omittedDevicesIds = <String>[
    '76536393-9ACC-4CFF-8CF6-9DA9B1FC511C', // iPhone 12 Mini
    '7781D76C-3010-49F0-992D-468FEAE44866', // iPhone 14 Pro Max
    '4364d626d1e42014', // Moto 5G
    '445476224b6184a7', // Samsung S22
  ];

  void logAnalyticsEvent(
    String message, {
    Map<String, dynamic>? info,
    bool isPageView = false,
  }) {
    try {
      if (_omittedDevicesIds.contains(getIt<SystemInfoRepository>().deviceId)) {
        return;
      }

      if (kReleaseMode && !_isStaging) {
        if (info != null) {
          info.removeWhere((key, value) => value == null);
        }
        _mixPanel.track(message, properties: info);

        if (info?.containsKey('weather') ?? false) {
          info!.remove('weather');
        }

        if (isPageView) {
          getIt<UmamiService>().trackRoute(route: message);
        } else {
          getIt<UmamiService>()
              .trackEvent(eventName: message, data: info ?? {});
        }
      }
    } catch (e) {
      AppDebug.logSentryError(
        e is DioException ? e.error ?? e.response : e,
        name: 'AnalyticsService',
      );
    }
  }

  /// logs all events while in debug mode
  @override
  void onEvent(BaseAnalyticsEvent event) {
    super.onEvent(event);
    AppDebug.log('$event', name: 'AnalyticsBloc');
  }
}
