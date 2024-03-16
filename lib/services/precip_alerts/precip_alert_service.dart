import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/precip_alerts/precip_alert_model.dart';

class PrecipAlertService {
  const PrecipAlertService();

  PrecipAlertModel precipModel(Weather? weather) {
    final minutes = weather?.forecastNextHour?.minutes;

    if (minutes == null) {
      return PrecipAlertModel(precipAlertType: PrecipAlertType.noPrecip);
    }
    final minutePrecipChances =
        minutes.map((minute) => minute.precipitationChance).toList();

    final forecastMinutes =
        minutePrecipChances.where((chance) => chance > 0.4).length;

    final firstPrecipIndex =
        minutePrecipChances.indexWhere((chance) => chance > 0.4);

    if (forecastMinutes == 0) {
      return PrecipAlertModel(precipAlertType: PrecipAlertType.noPrecip);
    }

    final summary = weather!.forecastNextHour!.summary;

    var condition = summary[0].condition;

    if (condition == 'clear' && summary.length >= 2) {
      condition = summary[1].condition;
    }

    condition = _adjustConditionForSnow(weather, condition);

    final precipType = firstPrecipIndex == 0
        ? PrecipAlertType.currentPrecip
        : PrecipAlertType.forecastedPrecip;

    final alert = _buildAlertMessage(
      condition: condition,
      forecastMinutes: forecastMinutes,
      firstPrecipIndex: firstPrecipIndex,
      precipType: precipType,
    );

    return PrecipAlertModel(
      precipAlertType: precipType,
      precipAlertIconPath: IconController.getPrecipIconPath(
        precipType: condition,
      ),
      precipAlertMessage: alert,
    );
  }

  String _adjustConditionForSnow(Weather weather, String condition) {
    if (condition.capitalizeFirst == 'Snow' &&
        _isAverageTempAboveZero(weather)) {
      final restOfDayForecast = weather.forecastDaily.days[0].restOfDayForecast;
      return restOfDayForecast?.conditionCode ??
          'flurries'; // Use restOfDayForecast if available
    }

    return condition;
  }

  bool _isAverageTempAboveZero(Weather weather) {
    final totalTempsInCelcius =
        weather.forecastHourly.hours.map((hour) => hour.temperature).toList();
    final average = totalTempsInCelcius.reduce((a, b) => a + b) /
        totalTempsInCelcius.length;

    return average > 0;
  }

  String _buildAlertMessage({
    required String condition,
    required int forecastMinutes,
    required int firstPrecipIndex,
    required PrecipAlertType precipType,
  }) {
    final precipStartDuration = firstPrecipIndex == 1 ? 'minute' : 'minutes';
    return precipType.isCurrentPrecip
        ? '''
${condition.capitalizeFirst} expected for the next $forecastMinutes minutes'''
        : '''
${condition.capitalizeFirst} beginning in $firstPrecipIndex $precipStartDuration''';
  }
}
