// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/analytics/umami_service.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
part 'analytics_event.dart';
part 'analytics_state.dart';

enum AnalyticsEvent {
  weatherKitTimeout,
  bgImageDeviceSelected,
  bgImageDynamicSelected,
  bgImageGallerySelected,
}

class AnalyticsBloc extends Bloc<BaseAnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({required Mixpanel mixpanel, required bool isStaging})
      : _mixPanel = mixpanel,
        _isStaging = isStaging,
        super(const AnalyticsState()) {
/* ------------------------------- Navigation ------------------------------- */

    on<NavigationEvent>((event, _) => logAnalyticsEvent(event.eventName));

/* -------------------------------- Location -------------------------------- */

    on<LocalLocationAcquired>(
      (event, _) {
        final location = event.locationModel.toMap();
        logAnalyticsEvent(event.eventName, location);
      },
    );
    on<LocalLocationError>((event, _) => logAnalyticsEvent(event.eventName));
    on<LocationAddressFormatError>(
      (event, _) {
        logAnalyticsEvent(event.eventName, event.locationModel.toMap());
      },
    );
    on<LocationDisabled>((event, _) => logAnalyticsEvent(event.eventName));
    on<LocationNoPermission>((event, _) => logAnalyticsEvent(event.eventName));
    on<RemoteLocationRequested>((event, _) {
      final place = event.searchSuggestion.toMap()['description'];
      final data = {'place': place};
      logAnalyticsEvent(event.eventName, data);
    });

/* --------------------------------- Weather -------------------------------- */

    on<WeatherInfoAcquired>((event, _) {
      final data = {'condition': event.condition};
      logAnalyticsEvent(event.eventName, data);
    });
    on<WeatherAlertProvided>((event, _) {
      final data = {
        'alert': event.alertModel.toMap(),
        'weather': event.weather.forecastNextHour?.toMap(),
      };
      logAnalyticsEvent(event.eventName, data);
    });
    on<WeatherInfoError>((event, _) => logAnalyticsEvent(event.eventName));

/* ---------------------------- In App Purchases ---------------------------- */

    on<IapPurchaseAttempted>((event, _) => logAnalyticsEvent(event.eventName));
    on<IapPurchaseSuccess>((event, _) => logAnalyticsEvent(event.eventName));
    on<IapRestorePurchaseSuccess>(
      (event, _) => logAnalyticsEvent(event.eventName),
    );
    on<IapRestorePurchaseAttempted>(
      (event, _) => logAnalyticsEvent(event.eventName),
    );
    on<IapTrialEnded>((event, _) => logAnalyticsEvent(event.eventName));
    on<IapPurchaseError>((event, _) {
      final data = {'error': event.error};
      logAnalyticsEvent(event.eventName, data);
    });

/* -------------------------------- Settings -------------------------------- */

    on<UnitSettingsUpdate>((event, _) {
      final unitSettings = event.unitSettings.toMap();
      logAnalyticsEvent(event.eventName, unitSettings);
    });
  }

  final Mixpanel _mixPanel;

  final bool _isStaging;

  void logAnalyticsEvent(String message, [Map<String, dynamic>? info]) {
    try {
      if (kReleaseMode && !_isStaging) {
        if (info != null) {
          info.removeWhere((key, value) => value == null);
        }
        _mixPanel.track(message, properties: info);

        if (info?.containsKey('weather') ?? false) {
          info!.remove('weather');
        }
        getIt<UmamiService>().trackEvent(eventName: message, data: info ?? {});
      }
    } on Exception catch (e) {
      log('Failed to log event: $message\n$e');
      throw Exception('Failed to log event: $message\n$e');
    }
  }

  /// logs all events while in debug mode
  @override
  void onEvent(BaseAnalyticsEvent event) {
    super.onEvent(event);
    AppDebug.log('$event', name: 'AnalyticsBloc');
  }
}
