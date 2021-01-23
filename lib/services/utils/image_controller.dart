import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  RxString backgroundImageString = ' '.obs;
  RxBool isDay = true.obs;

  static const lightingCropped = 'assets/images/lighting_cropped3.jpg';
  static const cloudyPortrait = 'assets/images/cloudy_portrait2.jpg';
  static const snowPortrait = 'assets/images/snow_portrait.jpg';
  static const nightCloudy = ' assets/icons/vclouds_icons/night_cloudy.png';
  static const clearDay = 'assets/icons/vclouds_icons/clear_day.png';
  static const mist = 'assets/icons/vclouds_icons/mist.png';
  static const smoke = 'assets/icons/vclouds_icons/smoke.png';
  static const sand = 'assets/icons/vclouds_icons/sand.png';
  static const squalls = 'assets/icons/vclouds_icons/squalls.png';
  static const tornadoIcon = 'assets/icons/tornado.jpeg';
  static const daySnowIcon = 'assets/icons/vclouds_icons/snow_day.png';
  static const nightSnowIcon = 'assets/icons/vclouds_icons/snow_night.png';
  static const heavySnowIcon = 'assets/icons/vclouds_icons/snow_heavy.png';
  static const sleetIcon = 'assets/icons/vclouds_icons/sleet.png';
  static const rainHeavyIcon = 'assets/icons/vclouds_icons/rain_heavy.png';
  static const rainLightIcon = 'assets/icons/vclouds_icons/rain_light.png';
  static const rainShowerIcon = 'assets/icons/vclouds_icons/rain_shower.png';
  static const thunderstormDayIcon =
      'assets/icons/vclouds_icons/thunderstorm_day.png';
  static const thunderstormHeavyIcon =
      'assets/icons/vclouds_icons/thunderstorm_day.png';

  String getImagePath(
      {@required String condition, @required String main, String origin}) {
    // debugPrint('Main: $main Condition: $condition Origin: $origin');
    switch (main) {
      case 'Thunderstorm':
        return _getThunderstormImagePath(condition);
        break;
      case 'Drizzle':
      case 'Rain':
        return _getRainImagePath(condition);
        break;
      case 'Snow':
        return _getSnowImagePath(condition);
        break;
      case 'Atmosphere':
        return _getAtmosphereImagePath(condition);
        break;
      case 'Clear':
        return _getClearImagePath(condition);
        break;
      case 'Clouds':
        return _getCloudImagePath(condition);
        break;

      default:
        backgroundImageString.value = snowPortrait;
        throw 'getImagePath function failing on main: $main condition: $condition ';

        return clearDay;
    }
  }

  String _getThunderstormImagePath(String condition) {
    backgroundImageString.value = lightingCropped;

    switch (condition) {
      case 'thunderstorm with light rain':
      case 'thunderstorm with light drizzle':
        return thunderstormDayIcon;
        break;

      default:
        return thunderstormHeavyIcon;
    }
  }

  String _getRainImagePath(String condition) {
    backgroundImageString.value = snowPortrait;

    switch (condition) {
      case 'heavy intensity rain':
      case 'very heavy rain':
      case 'extreme rain':
      case 'freezing rain':
      case 'shower rain':
        return rainHeavyIcon;
        break;

      case 'light rain':
      case 'moderate rain':
      case 'light intensity shower rain':
      case 'light intensity drizzle':
      case 'drizzle':
      case 'shower drizzle':
      case 'heavy intensity drizzle':
      case 'light intensity drizzle rain':
      case 'drizzle rain':
      case 'shower rain and drizzle':
        return rainLightIcon;
        break;

      case 'heavy intensity shower rain':
      case 'heavy shower rain and drizzle':
      case 'ragged shower rain	':
        return rainShowerIcon;
        break;
      default:
        throw '_getRainImagePath function failing on condition: $condition ';

        return rainLightIcon;
    }
  }

  String _getSnowImagePath(String condition) {
    backgroundImageString.value = snowPortrait;

    switch (condition) {
      case 'light snow':
      case 'snow':
        return isDay() ? daySnowIcon : nightSnowIcon;
        break;
      case 'Heavy snow':
      case 'Heavy shower snow':
      case 'Shower snow':
        return heavySnowIcon;
        break;
      case 'Sleet':
      case 'Light shower sleet':
      case 'Shower sleet':
      case 'Light rain and snow':
      case 'Rain and snow':
      case 'Light shower snow':
        return sleetIcon;
        break;

      default:
        throw '_getSnowImagePath function failing on condition: $condition ';

        return daySnowIcon;
    }
  }

  String _getAtmosphereImagePath(String main) {
    backgroundImageString.value = cloudyPortrait;

    switch (main) {
      case 'Mist':
      case 'Haze':
      case 'Fog':
        return mist;
      case 'Smoke':
      case 'Ash':
        return smoke;
        break;
      case 'Dust':
      case 'Sand':
        return sand;
        break;
      case 'Squall':
        return squalls;
        break;
      case 'Tornado':
        return tornadoIcon;
        break;
      default:
        throw '_getAtmosphereImagePath function failing on main: $main ';

        return clearDay;
    }
  }

  String _getClearImagePath(String condition) {
    backgroundImageString.value = 'assets/images/sunny_portrait.jpg';

    switch (isDay.value) {
      case false:
        return 'assets/icons/vclouds_icons/clear_night.png';
        break;
      default:
        // throw '_getClearImagePath function failing on condition: $condition ';

        return clearDay;
    }
  }

  String _getCloudImagePath(String condition) {
    backgroundImageString.value = 'assets/images/cloudy_portrait2.jpg';
    switch (condition) {
      case 'few clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/few_clouds_day.png'
            : 'assets/icons/vclouds_icons/few_clouds_night.png';
        break;
      case 'scattered clouds':
      case 'broken clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/scattered_clouds_day.png'
            : nightCloudy;
        break;
      case 'overcast clouds':
        return isDay.value
            ? 'assets/icons/vclouds_icons/overcast_clouds_day.png'
            : nightCloudy;
        break;
      default:
        throw '_getCloudImagePath function failing on main: $condition ';

        return 'assets/icons/vclouds_icons/few_clouds_day.png';
    }
  }
}
