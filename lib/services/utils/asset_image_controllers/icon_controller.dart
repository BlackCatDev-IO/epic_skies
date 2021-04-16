import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:flutter/foundation.dart';

//TODO: Implement logic to account for not showing snow icons when clima cell returns flurries in non freezing weather

class IconController {
  bool isDay = true;

  String getIconImagePath(
      {required String condition, DateTime? time, String? origin}) {
    final iconCondition = condition.toLowerCase();

    if (time != null && WeatherRepository.to.isLoading.value) {
      isDay = TimeZoneController.to.getForecastDayOrNight(time);
    } else {
      isDay = true;
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

  String _getClearIconPath(String condition) =>
      isDay ? clearDayIcon : clearNightIcon;

  String _getCloudIconPath(String condition) {
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

  String _getRainIconPath(String condition) {
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

  String _getWindIconPath(String condition) {
    switch (condition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return rainLightIcon;
      default:
        return rainLightIcon;
    }
  }

  String _getSnowIconPath(String condition) {
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
  }

  String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDay ? thunderstormDayIcon : thunderstormHeavyIcon;

      default:
        return thunderstormHeavyIcon;
    }
  }
}
