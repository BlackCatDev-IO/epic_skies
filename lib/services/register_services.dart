import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/env/env.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/analytics/analytics_service.dart';
import 'package:epic_skies/services/analytics/umami_service.dart';
import 'package:epic_skies/services/remote_logging_service.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:get_it/get_it.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

final getIt = GetIt.instance;

Future<void> registerServices(SystemInfoRepository systemInfo) async {
  final mixpanel = await Mixpanel.init(
    Env.mixpanelToken,
    trackAutomaticEvents: true,
  );

  final analytics = AnalyticsService(
    mixpanel: mixpanel,
    isStaging: systemInfo.isStaging,
    umami: UmamiService(systemInfo: systemInfo),
  );

  getIt
    ..registerSingleton<SystemInfoRepository>(systemInfo)
    ..registerSingleton<AdaptiveLayout>(AdaptiveLayout())
    ..registerSingleton<AnalyticsService>(analytics)
    ..registerSingleton<EpicSkiesApiClient>(
      EpicSkiesApiClient(appVersion: systemInfo.currentAppVersion),
    )
    ..registerSingleton<RemoteLoggingService>(RemoteLoggingService());
}
