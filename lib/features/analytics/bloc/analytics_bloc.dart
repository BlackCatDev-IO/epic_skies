import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<BaseAnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({required Mixpanel mixpanel, required bool isStaging})
      : _mixPanel = mixpanel,
        _isStaging = isStaging,
        super(const AnalyticsState()) {
    on<NavigationEvent>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocationRequested>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocalLocationAcquired>(
      (event, _) {
        final location = event.locationModel.toMap();
        _logAnalyticsEvent(event.eventName, location);
      },
    );
    on<LocalLocationError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocationAddressFormatError>(
      (event, _) {
        _logAnalyticsEvent(event.eventName, event.locationModel.toMap());
      },
    );
    on<LocationDisabled>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocationNoPermission>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoRequested>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoAcquired>((event, _) {
      final data = {'condition': event.condition};
      _logAnalyticsEvent(event.eventName, data);
    });
    on<RemoteLocationRequested>((event, _) {
      final place = event.searchSuggestion.toMap()['description'];
      final data = {'place': place};
      _logAnalyticsEvent(event.eventName, data);
    });
    on<WeatherInfoError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<UnitSettingsUpdate>((event, _) {
      final unitSettings = event.unitSettings.toMap();
      _logAnalyticsEvent(event.eventName, unitSettings);
    });
    on<IapPurchaseAttempted>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseSuccess>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapRestorePurchaseSuccess>(
      (event, _) => _logAnalyticsEvent(event.eventName),
    );
    on<IapRestorePurchaseAttempted>(
      (event, _) => _logAnalyticsEvent(event.eventName),
    );
    on<IapTrialEnded>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseError>((event, _) {
      final data = {'error': event.error};
      _logAnalyticsEvent(event.eventName, data);
    });
    on<BgImageGallerySelected>((event, _) {
      final data = {'image': event.image};
      _logAnalyticsEvent(event.eventName, data);
    });
    on<BgDeviceImageSelected>((event, _) {
      _logAnalyticsEvent(event.eventName);
    });
    on<BgImageDynamicSelected>((event, _) {
      _logAnalyticsEvent(event.eventName);
    });
  }

  final Mixpanel _mixPanel;

  final _firebaseAnalytics = FirebaseAnalytics.instance;

  final bool _isStaging;

  void _logAnalyticsEvent(String message, [Map<String, dynamic>? info]) {
    if (kReleaseMode && !_isStaging) {
      if (info != null) {
        info.removeWhere((key, value) => value == null);
      }

      _firebaseAnalytics.logEvent(name: message, parameters: info);

      _mixPanel.track(message, properties: info);

      if (!message.contains('navigation')) {
        Posthog().capture(
          eventName: message,
          properties: info,
        );
      }
    }
  }

  /// logs all events while in debug mode
  @override
  void onEvent(BaseAnalyticsEvent event) {
    super.onEvent(event);
    AppDebug.log('$event', name: 'AnalyticsBloc');
  }
}
