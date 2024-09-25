import 'package:dio/dio.dart';
import 'package:epic_skies/features/analytics/umami_service.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/remote_logging_service.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

enum AnalyticsEvent {
  adFreePurchaseAttempted,
  adFreePurchaseSuccess,
  adFreeRestorePurchaseAttempted,
  adFreeRestorePurchaseSuccess,
  adFreePurchaseError,
  adFreeTrialEnded,
  appUpdated,
  localLocationAcquired,
  locationDisabled,
  locationNoPermission,
  locationError,
  locationAddressFormatError,
  remoteLocationRequested,
  weatherKitTimeout,
  bgImageDeviceSelected,
  bgImageDynamicSelected,
  bgImageGallerySelected,
  updateDialogShown,
  unitSettingsUpdated,
  weatherInfoAcquired,
  weatherAlertProvided,
  weatherInfoError,
  error,
}

class AnalyticsService {
  AnalyticsService({
    required Mixpanel mixpanel,
    required bool isStaging,
    required UmamiService umami,
  })  : _mixPanel = mixpanel,
        _isStaging = isStaging,
        _umami = umami;

  final Mixpanel _mixPanel;

  final bool _isStaging;

  final UmamiService _umami;

  /// List of personal testing devices that should not log analytics events
  final _omittedDevicesIds = <String>[
    '76536393-9ACC-4CFF-8CF6-9DA9B1FC511C', // iPhone 12 Mini
    '7781D76C-3010-49F0-992D-468FEAE44866', // iPhone 14 Pro Max
    '4364d626d1e42014', // Moto 5G
    '445476224b6184a7', // Samsung S22
  ];

  void trackEvent(
    String message, {
    Map<String, dynamic>? info,
    bool isPageView = false,
  }) {
    try {
      final systemInfo = getIt<SystemInfoRepository>();

      if (systemInfo.androidModel == 'moto g stylus 5G - 2023') {
        getIt<RemoteLoggingService>().log(
          '''
deviceID: ${systemInfo.deviceId} sn: ${systemInfo.androidInfo?.serialNumber}''',
        );
        return;
      }

      if (_omittedDevicesIds.contains(systemInfo.deviceId)) {
        return;
      }

      if (!kReleaseMode || _isStaging) return;

      if (info != null) {
        info.removeWhere((key, value) => value == null);
      }

      AppDebug.log(
        'Event: $message, Info: $info',
        name: 'Analytics',
      );

      _mixPanel.track(message, properties: info);

      if (info?.containsKey('weather') ?? false) {
        info!.remove('weather');
      }

      if (isPageView) {
        _umami.trackRoute(route: message);
      } else {
        _umami.trackEvent(eventName: message, data: info ?? {});
      }
    } catch (e) {
      AppDebug.logSentryError(
        e is DioException ? e.error ?? e.response : e,
        name: 'AnalyticsService',
      );
    }
  }
}
