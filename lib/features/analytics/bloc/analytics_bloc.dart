import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
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
      (event, _) => _logAnalyticsEvent(event.eventName),
    );
    on<LocalLocationError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoRequested>((event, _) => _logAnalyticsEvent(event.eventName));
    on<WeatherInfoAcquired>((event, _) {
      final map = {'condition': event.condition};
      _logAnalyticsEvent(event.eventName, map);
    });
    on<WeatherInfoError>((event, _) => _logAnalyticsEvent(event.eventName));
    on<UnitSettingsUpdate>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseAttempted>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseSuccess>((event, _) => _logAnalyticsEvent(event.eventName));
    on<IapPurchaseError>((event, _) => _logAnalyticsEvent(event.eventName));
  }

  final Mixpanel _mixPanel;

  void _logAnalyticsEvent(String message, [Map<String, dynamic>? info]) {
    _mixPanel.track(message, properties: info);
  }

  /// logs all events while in debug mode
  @override
  void onEvent(BaseAnalyticsEvent event) {
    super.onEvent(event);
    AppDebug.log('$event', name: 'AnalyticsBloc');
  }
}
