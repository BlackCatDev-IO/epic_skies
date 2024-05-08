import 'package:epic_skies/core/network/epic_skies_api/epic_skies_api_client.dart';
import 'package:epic_skies/environment_config.dart';
import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/analytics/umami_service.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/logging_service.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:get_it/get_it.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

final getIt = GetIt.instance;

Future<void> registerServices(SystemInfoRepository systemInfo) async {
  final mixpanel = await Mixpanel.init(
    Env.MIX_PANEL_TOKEN,
    trackAutomaticEvents: true,
  );

  final analytics = AnalyticsBloc(
    mixpanel: mixpanel,
    isStaging: systemInfo.isStaging,
  );

  getIt
    ..registerSingleton<SystemInfoRepository>(systemInfo)
    ..registerSingleton<AdaptiveLayout>(AdaptiveLayout())
    ..registerSingleton<AnalyticsBloc>(analytics)
    ..registerSingleton<UmamiService>(UmamiService(systemInfo: systemInfo))
    ..registerSingleton<EpicSkiesApiClient>(
      EpicSkiesApiClient(appVersion: systemInfo.currentAppVersion),
    )
    ..registerSingleton<LoggingService>(LoggingService());
}
