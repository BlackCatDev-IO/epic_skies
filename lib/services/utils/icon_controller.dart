import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

//TODO: Implement logic to account for not showing snow icons when clima cell returns flurries in non freezing weather

class IconController {
  bool isDayCurrent;

  String getIconImagePath({@required String condition, String origin}) {
    final iconCondition = condition.toLowerCase();
    isDayCurrent = Get.find<WeatherRepository>().isDay;

    // debugPrint('Main: $main Condition: $condition : Origin: $origin');

    switch (iconCondition) {
      case 'thunderstorm':
        return _getThunderstormIconPath(iconCondition);
        break;
      case 'drizzle':
      case 'rain':
      case 'light rain':
      case 'heavy rain':
        return _getRainIconPath(iconCondition);
        break;
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
        break;
      case 'clear':
      case 'mostly clear':
        return _getClearIconPath(iconCondition);
        break;
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return _getCloudIconPath(iconCondition);
        break;
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return _getWindIconPath(iconCondition);
        break;

      default:
        return isDayCurrent ? clearDayIcon : clearNightIcon;

        throw 'getIconPath function failing on condition: $condition ';
    }
  }

  String _getClearIconPath(String condition) =>
      isDayCurrent ? clearDayIcon : clearNightIcon;

  String _getCloudIconPath(String condition) {
    switch (condition) {
      case 'cloudy':
      case 'partly cloudy':
      case 'mostly cloudy':
      case 'fog':
      case 'light fog':
        return isDayCurrent ? fewCloudsDay : fewCloudsNight;
        break;
      case 'mostly cloudy':
        return isDayCurrent ? scatteredCloudsDay : nightCloudy;
        break;
      case 'mostly cloudy':
        return overcastClouds;
        break;
      default:
        throw '_getCloudImagePath function failing on main: $condition ';

        return isDayCurrent ? fewCloudsDay : nightCloudy;
    }
  }

  String _getRainIconPath(String condition) {
    switch (condition) {
      case 'heavy rain':
        return rainHeavyIcon;
        break;
      case 'light rain':
      case 'rain':
      case 'drizzle':
        return rainLightIcon;
        break;
      default:
        throw '_getRainImagePath function failing on condition: $condition ';
        return rainLightIcon;
    }
  }

  String _getWindIconPath(String condition) {
    switch (condition) {
      case 'light wind':
      case 'strong wind':
      case 'wind':
        return rainLightIcon;
        break;
      default:
        return rainLightIcon;
    }
  }

  String _getSnowIconPath(String condition) {
    switch (condition) {
      case 'light snow':
      case 'snow':
        return isDayCurrent ? daySnowIcon : nightSnowIcon;
        break;
      case 'heavy snow':
      case 'heavy shower snow':
      case 'shower snow':
        return heavySnowIcon;
        break;
      case 'flurries':
      case 'light freezing rain':
      case 'heavy freezing rain':
      case 'ice pellets':
      case 'heavy ice pellets':
      case 'light ice pellets':
      case 'heavy snow':
      case 'freezing drizzle':
      case 'freezing rain':
        return sleetIcon;
        break;
      default:
        throw '_getSnowImagePath function failing on condition: $condition ';

        return isDayCurrent ? daySnowIcon : nightSnowIcon;
    }
  }

  String _getThunderstormIconPath(String condition) {
    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return isDayCurrent ? thunderstormDayIcon : thunderstormHeavyIcon;
        break;

      default:
        return thunderstormHeavyIcon;
    }
  }
}
