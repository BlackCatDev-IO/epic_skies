import 'dart:developer';

import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/precip_alerts/precip_alert_model.dart';

class PrecipAlertService {
  const PrecipAlertService();

  PrecipAlertModel precipModel(WeatherState weatherState) {
    final weather = weatherState.weather;
    final noAlert = PrecipAlertModel(
      precipAlertType: PrecipAlertType.noPrecip,
    );

    if (weather == null) {
      return noAlert;
    }

    final minutes = weather.forecastNextHour?.minutes;

    if (minutes == null) {
      return noAlert;
    }

    var forecastMinutes = 0;

    for (final minute in minutes) {
      log(minute.precipitationChance.toString());
      if (minute.precipitationChance > 0.4) {
        forecastMinutes++;
      }
    }

    final summaryList = weather.forecastNextHour?.summary;

    var condition = summaryList?[0].condition ?? '';

    if (condition == 'clear' && summaryList!.length >= 2) {
      condition = summaryList[1].condition;
    }

    if (forecastMinutes == 0 || condition.isEmpty || condition == 'clear') {
      return noAlert;
    }

    final alert = '''
${condition.capitalizeFirst} expected for the next $forecastMinutes minutes''';

    return PrecipAlertModel(
      precipAlertType: PrecipAlertType.currentPrecip,
      precipAlertIconPath: IconController.getPrecipIconPath(
        precipType: condition,
      ),
      precipAlertMessage: alert,
    );
  }
}
