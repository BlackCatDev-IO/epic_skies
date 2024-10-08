import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneUtil {
  ReferenceTimesModel getReferenceTimesModel({
    required WeatherState weatherState,
    DateTime? nowFromApi, // For testing
  }) {
    assert(
      weatherState.weather != null || weatherState.weatherModel != null,
      'Weather or WeatherModel must not be null',
    );

    final timezoneOffset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    final now = nowFromApi ?? DateTime.now().toUtc().add(timezoneOffset);

    final (suntimes, isDay) = _getSuntimesAndIsDay(
      weatherState: weatherState,
      now: now,
    );

    return ReferenceTimesModel(
      now: now,
      timezone: weatherState.refTimes.timezone,
      timezoneOffsetInMs: timezoneOffset.inMilliseconds,
      refererenceSuntimes: suntimes,
      isDay: isDay,
    );
  }

  (Duration, String) offsetAndTimezone({
    required Coordinates coordinates,
  }) {
    try {
      tz.initializeTimeZones();
      final timezone = _updatedOutdatedTimezoneNames(
        tzmap.latLngToTimezoneString(coordinates.lat, coordinates.long),
      );

      final location = tz.getLocation(timezone);
      final nowUtc =
          location.timeZone(DateTime.now().toUtc().millisecondsSinceEpoch);

      final timezoneOffset = Duration(milliseconds: nowUtc.offset);

      AppDebug.log('Timezone offset: $timezoneOffset', name: 'TimeZoneUtil');
      return (timezoneOffset, timezone);
    } on Exception catch (e) {
      AppDebug.log('Error setting timezone offset: $e', isError: true);
      rethrow;
    }
  }

  List<SunTimesModel> _initSunTimeList({required WeatherState weatherState}) {
    if (weatherState.useBackupApi) {
      return weatherState.weatherModel!.days
          .map(
            (dailyData) => SunTimesModel.fromVisualCrossing(
              weatherState: weatherState,
              data: dailyData,
            ),
          )
          .toList();
    }

    final days = weatherState.weather!.forecastDaily.days;

    return days
        .map(
          (day) =>
              _getSunTimesModelForDay(weatherState, days.indexOf(day), day),
        )
        .toList();
  }

  SunTimesModel _getSunTimesModelForDay(
    WeatherState weatherState,
    int index,
    DayWeatherConditions day,
  ) {
    final timezoneOffset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    final sunriseTime = day.sunrise?.add(timezoneOffset) ??
        _getNextNonNullSunriseTime(
          weatherState.weather!.forecastDaily.days,
          index,
          timezoneOffset,
        );
    final sunsetTime = day.sunset?.add(timezoneOffset) ??
        _getNextNonNullSunsetTime(
          weatherState.weather!.forecastDaily.days,
          index,
          timezoneOffset,
        );

    return SunTimesModel(
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
    );
  }

  DateTime? _getNextNonNullSunriseTime(
    List<DayWeatherConditions> days,
    int startIndex,
    Duration timezoneOffset,
  ) {
    final daysWithNonNullSunrise =
        days.skipWhile((day) => day.sunrise == null).skip(1).toList();

    if (daysWithNonNullSunrise.isEmpty) return null;

    final mostRecentDayWithNonNullSunrise = daysWithNonNullSunrise.first;

    final diffInDays =
        startIndex - days.indexOf(mostRecentDayWithNonNullSunrise);

    return mostRecentDayWithNonNullSunrise.sunrise!
        .add(Duration(days: diffInDays))
        .add(timezoneOffset);
  }

  DateTime? _getNextNonNullSunsetTime(
    List<DayWeatherConditions> days,
    int startIndex,
    Duration timezoneOffset,
  ) {
    final daysWithNonNullSunset =
        days.skipWhile((day) => day.sunset == null).skip(1).toList();
    if (daysWithNonNullSunset.isEmpty) return null;

    final mostRecentDayWithNonNullSunset = daysWithNonNullSunset.first;
    final diffInDays =
        startIndex - days.indexOf(mostRecentDayWithNonNullSunset);

    return mostRecentDayWithNonNullSunset.sunset!
        .add(Duration(days: diffInDays))
        .add(timezoneOffset);
  }

  (List<SunTimesModel>, bool) _getSuntimesAndIsDay({
    required WeatherState weatherState,
    required DateTime now,
  }) {
    final suntimesList = _initSunTimeList(
      weatherState: weatherState,
    );

    final offset = Duration(
      milliseconds: weatherState.refTimes.timezoneOffsetInMs,
    );

    late DateTime referenceTime;

    if (!weatherState.useBackupApi) {
      referenceTime = weatherState.weather!.currentWeather.asOf.add(offset);
    } else {
      referenceTime = DateTime.fromMillisecondsSinceEpoch(
        weatherState.weatherModel!.currentCondition.datetimeEpoch * 1000,
      ).add(offset);
    }

    final sameDaySuntime = suntimesList.firstWhere(
      (suntime) => suntime.sunriseTime?.day == referenceTime.day,
      orElse: () => suntimesList.first,
    );

    if (sameDaySuntime.sunriseTime == null ||
        sameDaySuntime.sunsetTime == null) {
      return (suntimesList, true);
    }

    final isDay = now.isAfter(sameDaySuntime.sunriseTime!) &&
        now.isBefore(sameDaySuntime.sunsetTime!);

    return (suntimesList, isDay);
  }

  /// Checks for timezone names that have been updated in the IANA timezone
  /// database but not accounted for in the timezone package
  String _updatedOutdatedTimezoneNames(String timezone) {
    return switch (timezone) {
      'Europe/Kiev' => 'Europe/Kyiv',
      _ => timezone,
    };
  }
}
