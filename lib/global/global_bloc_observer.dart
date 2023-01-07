import 'package:epic_skies/features/analytics/bloc/analytics_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class GlobalBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    if (bloc is WeatherBloc) {
      _reportWeatherBlocAnalytics(transition);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppDebug.log('Error: ${bloc.runtimeType} $error $stackTrace');
  }

  void _reportWeatherBlocAnalytics(Transition transition) {
    final analytics = GetIt.instance<AnalyticsBloc>();

    AppDebug.logBlocTransition(transition, 'WeatherBloc');

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
            condition: weatherState.weatherModel!.currentCondition!.condition,
          ),
        );
        break;
      case WeatherStatus.error:
        analytics.add(WeatherInfoError());
        break;
    }
  }
}
