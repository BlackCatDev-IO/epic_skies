import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

mixin AlertService {
  AlertModel getAlertModelFromWeather(Weather weather) {
    final minutes = weather.forecastNextHour?.minutes;

    if (minutes == null) {
      return const AlertModel(precipAlertType: PrecipNoticeType.noPrecip);
    }
    final minutePrecipChances =
        minutes.map((minute) => minute.precipitationChance).toList();

    final forecastMinutes =
        minutePrecipChances.where((chance) => chance > 0.4).length;

    final firstPrecipIndex =
        minutePrecipChances.indexWhere((chance) => chance > 0.4);

    if (forecastMinutes == 0) {
      return const AlertModel(precipAlertType: PrecipNoticeType.noPrecip);
    }

    final summary = weather.forecastNextHour!.summary;

    var condition = summary[0].condition;

    if (condition == 'clear' && summary.length >= 2) {
      condition = summary[1].condition;
    }

    condition = _adjustConditionForSnow(weather, condition);

    final precipType = firstPrecipIndex == 0
        ? PrecipNoticeType.currentPrecip
        : PrecipNoticeType.forecastedPrecip;

    final alert = _precipNoticeMessage(
      condition: condition,
      forecastMinutes: forecastMinutes,
      firstPrecipIndex: firstPrecipIndex,
      precipType: precipType,
    );

    return AlertModel(
      precipAlertType: precipType,
      precipNoticeIconPath: IconController.getPrecipIconPath(
        precipType: condition,
      ),
      precipNoticeMessage: alert,
      weatherAlertMessage: _weatherAlertMessage(weather),
    );
  }

  String _weatherAlertMessage(Weather weather) {
    final alertCollection = weather.weatherAlerts;

    if (alertCollection?.alerts.isEmpty ?? true) {
      return '';
    }

    if (alertCollection?.alerts[0].description == 'Hydrologic Outlook') {
      return '';
    }

    final baseAlert = weather.weatherAlerts!.alerts[0];

    final untilTime = DateTimeFormatter.formatAlertTime(
      baseAlert.eventEndTime?.toUtc() ?? DateTime.now(),
    );
    final description = baseAlert.description;

    return '$description in effect until $untilTime';
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

  String _precipNoticeMessage({
    required String condition,
    required int forecastMinutes,
    required int firstPrecipIndex,
    required PrecipNoticeType precipType,
  }) {
    final precipStartDuration = firstPrecipIndex == 1 ? 'minute' : 'minutes';
    return precipType.isCurrentPrecip
        ? '''
${condition.capitalizeFirst} expected for the next $forecastMinutes minutes'''
        : '''
${condition.capitalizeFirst} beginning in $firstPrecipIndex $precipStartDuration''';
  }
}
