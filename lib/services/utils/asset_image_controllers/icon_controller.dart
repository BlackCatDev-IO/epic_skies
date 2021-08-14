import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:flutter/foundation.dart';

class IconController {
  static bool isDay = true;

  static String getIconImagePath(
      {required String condition, required bool hourly,  int? index, DateTime? time}) {
    final iconCondition = condition.toLowerCase();

    if (hourly) {
      isDay = TimeZoneController.to.getForecastDayOrNight(forecastTime: time!, index: index!);
    } else {
      isDay = true; // large daily detail widget icon defaults to day version
    }

    switch (iconCondition) {
      case 'thunderstorm':
        return _getThunderstormIconPath(iconCondition);
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        return _getRainIconPath(iconCondition);
      case 'snow':
      case 'flurries':
      case 'light snow':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
        return _getSnowIconPath(iconCondition);
      case 'clear':
      case 'mostly clear':
        return _getClearIconPath(iconCondition);
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return _getCloudIconPath(iconCondition);
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return _getWindIconPath(iconCondition);

      default:
        debugPrint('getIconPath function failing on condition: $condition ');

        return isDay ? clearDayIcon : clearNightIcon;
    }
  }

  static String _getClearIconPath(String condition) =>
      isDay ? clearDayIcon : clearNightIcon;

  static String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return isDay ? fewCloudsDay : fewCloudsNight;
      default:
        debugPrint('_getCloudImagePath function failing on main: $condition ');

        return isDay ? fewCloudsDay : nightCloudy;
    }
  }

  static String _getRainIconPath(String condition) {
    switch (condition) {
      case 'heavy rain':
        return rainHeavyIcon;
      case 'light rain':
      case 'rain':
      case 'drizzle':
        return rainLightIcon;
      default:
        debugPrint(
            '_getRainImagePath function failing on condition: $condition ');
        return rainLightIcon;
    }
  }

  static String _getWindIconPath(String condition) {
    switch (condition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return rainLightIcon;
      default:
        return rainLightIcon;
    }
  }

  static String _getSnowIconPath(String condition) {
    if (!CurrentWeatherController.to.falseSnow) {
      switch (condition) {
        case 'light snow':
        case 'snow':
          return isDay ? daySnowIcon : nightSnowIcon;
        case 'heavy snow':
        case 'heavy shower snow':
        case 'shower snow':
          return heavySnowIcon;
        case 'flurries':
        case 'light freezing rain':
        case 'heavy freezing rain':
        case 'ice pellets':
        case 'heavy ice pellets':
        case 'light ice pellets':
        case 'freezing drizzle':
        case 'freezing rain':
          return sleetIcon;
        default:
          debugPrint(
              '_getSnowImagePath function failing on condition: $condition ');

          return isDay ? daySnowIcon : nightSnowIcon;
      }
    } else {
      return _getCloudIconPath(condition);
    }
  }

  static String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDay ? thunderstormDayIcon : thunderstormHeavyIcon;

      default:
        return thunderstormHeavyIcon;
    }
  }
}
