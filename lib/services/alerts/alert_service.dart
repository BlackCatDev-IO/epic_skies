import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/extensions/string_extensions.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/precip_notice_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/weather_alert_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

mixin AlertService {
  AlertModel getAlertModelFromWeather({
    required WeatherState weatherState,
  }) {
    final weather = weatherState.weather!;
    final minutes = weather.forecastNextHour?.minutes;

    final weatherAlert = _weatherAlertModel(weatherState);

    var precipModel = const PrecipNoticeModel.noPrecip();

    if (minutes == null) {
      return AlertModel(
        precipNotice: precipModel,
        weatherAlert: weatherAlert,
      );
    }

    const precipChanceThreshold = 0.3;
    final minutePrecipChances =
        minutes.map((minute) => minute.precipitationChance).toList();

    final forecastMinutes = minutePrecipChances
        .where((chance) => chance > precipChanceThreshold)
        .length;

    final firstPrecipIndex = minutePrecipChances
        .indexWhere((chance) => chance >= precipChanceThreshold);

    if (forecastMinutes == 0) {
      return AlertModel(
        precipNotice: precipModel,
        weatherAlert: weatherAlert,
      );
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

    final precipMessage = _precipNoticeMessage(
      condition: condition,
      forecastMinutes: forecastMinutes,
      firstPrecipIndex: firstPrecipIndex,
      precipType: precipType,
    );

    if (condition.toLowerCase() != 'clear' &&
        !condition.toLowerCase().contains('cloud')) {
      precipModel = PrecipNoticeModel(
        precipAlertType: precipType,
        precipNoticeMessage: precipMessage,
        precipNoticeIconPath: IconController.getPrecipIconPath(
          precipType: condition,
        ),
      );
    }

    return AlertModel(
      weatherAlert: weatherAlert,
      precipNotice: precipModel,
    );
  }

  WeatherAlertModel _weatherAlertModel(
    WeatherState weatherState,
  ) {
    final weather = weatherState.weather!;
    final timezoneOffset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );
    final alertCollection = weather.weatherAlerts;

    if (alertCollection?.alerts.isEmpty ?? true) {
      return const WeatherAlertModel.noAlert();
    }

    const alertTypesToIgnore = [
      'Special Weather Statement',
      'Hydrologic Outlook',
      'Frost Advisory',
    ];

    if (alertTypesToIgnore.contains(alertCollection?.alerts[0].description)) {
      return const WeatherAlertModel.noAlert();
    }

    final baseAlert = weather.weatherAlerts!.alerts[0];

    var startTimeString = '';
    var endTimeString = '';

    if (baseAlert.eventOnsetTime != null) {
      final onsetTime = baseAlert.eventOnsetTime!.add(timezoneOffset);

      final nowUtcOffset = weatherState.refTimes.now ?? DateTime.now().toUtc();

      if (onsetTime.isAfter(nowUtcOffset)) {
        startTimeString =
            'Expected by ${DateTimeFormatter.formatAlertTime(onsetTime)}';
      }
    }

    if (baseAlert.eventEndTime != null) {
      final endTime = baseAlert.eventEndTime!.add(timezoneOffset);
      final prefix = startTimeString.isNotEmpty ? 'Ending ' : 'Expected until ';
      endTimeString = '$prefix${DateTimeFormatter.formatAlertTime(endTime)}';
    }

    final source = baseAlert.source;
    final areaName = baseAlert.areaName ?? '';
    final alertMessage = startTimeString.isNotEmpty
        ? '''
${baseAlert.description}
$startTimeString
$endTimeString'''
        : '''
${baseAlert.description}
$endTimeString''';

    return WeatherAlertModel(
      weatherAlertMessage: alertMessage,
      alertSource: source,
      alertAreaName: areaName,
      detailsUrl: baseAlert.detailsUrl ?? '',
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

  String _precipNoticeMessage({
    required String condition,
    required int forecastMinutes,
    required int firstPrecipIndex,
    required PrecipNoticeType precipType,
  }) {
    final formattedCondition = WeatherCodeConverter.convertWeatherKitCodes(
      condition,
    );
    final roundToNexHour = forecastMinutes >= 50 && forecastMinutes <= 70;

    final forecastDurationText = roundToNexHour
        ? 'hour'
        : forecastMinutes == 1
            ? '$forecastMinutes minute'
            : '$forecastMinutes minutes';

    final precipStartDuration = firstPrecipIndex == 1 ? 'minute' : 'minutes';
    return precipType.isCurrentPrecip
        ? '''
$formattedCondition forcasted for the next $forecastDurationText'''
        : '''
$formattedCondition beginning in $firstPrecipIndex $precipStartDuration''';
  }
}
