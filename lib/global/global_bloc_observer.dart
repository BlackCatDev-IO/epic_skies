// ignore_for_file: strict_raw_type

import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GlobalBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    switch (bloc.runtimeType) {
      case WeatherBloc:
        _reportWeatherBlocAnalytics(transition);
        break;
    }
    AppDebug.logBlocTransition(transition, '${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppDebug.logSentryError(
      'Error: ${bloc.runtimeType} $error $stackTrace',
      name: 'onOnError',
      stack: stackTrace,
      hint: Hint.withMap({'bloc type:': '${bloc.runtimeType}'}),
    );
  
  }

  @override
  void onClose(BlocBase bloc) {
    AppDebug.log('Bloc closed: $bloc');
    super.onClose(bloc);
  }

  void _reportWeatherBlocAnalytics(Transition transition) {
    final analytics = GetIt.instance<AnalyticsBloc>();

    final weatherState = transition.nextState as WeatherState;
    switch (weatherState.status) {
      case WeatherStatus.initial:
        break;
      case WeatherStatus.unitSettingsUpdate:
        analytics
            .add(UnitSettingsUpdate(unitSettings: weatherState.unitSettings));
        break;
      case WeatherStatus.loading:
        analytics.add(WeatherInfoRequested());
        break;
      case WeatherStatus.success:
        analytics.add(
          WeatherInfoAcquired(
            condition: weatherState.weatherModel!.currentCondition.conditions,
          ),
        );
        break;
      case WeatherStatus.error:
        analytics.add(WeatherInfoError());
        break;
    }
  }
}
