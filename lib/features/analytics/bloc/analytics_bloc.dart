import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<BaseAnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({required Mixpanel mixpanel})
      : _mixPanel = mixpanel,
        super(const AnalyticsState()) {
    on<GeneralLogEvent>((event, _) => _logAnalyticsEvent(event.eventPrefix));
    on<LocationRequested>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocalLocationAcquired>(
      (event, _) {
        final location = event.locationModel.toJson();
        _logAnalyticsEvent(event.eventName, location);
      },
    );
    on<LocalLocationError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocationAddressFormatError>(
      (event, _) {
        _logAnalyticsEvent(event.eventName, event.locationModel.toJson());
      },
    );
    on<LocationDisabled>((event, _) => _logAnalyticsEvent(event.eventName));
    on<LocationNoPermission>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoRequested>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoAcquired>((event, _) {
      final data = {'condition': event.condition};
      _logAnalyticsEvent(event.eventName, data);
    });
    on<WeatherInfoError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<UnitSettingsUpdate>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseAttempted>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseSuccess>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseError>((event, _) {
      final data = {'error': event.error};
      _logAnalyticsEvent(event.eventName, data);
    });
  }

  final Mixpanel _mixPanel;

  void _logAnalyticsEvent(String message, [Map<String, dynamic>? info]) {
    if (kReleaseMode) {
      _mixPanel.track(message, properties: info);
    }
  }

  /// logs all events while in debug mode
  @override
  void onEvent(BaseAnalyticsEvent event) {
    super.onEvent(event);
    AppDebug.log('$event', name: 'AnalyticsBloc');
  }
}
