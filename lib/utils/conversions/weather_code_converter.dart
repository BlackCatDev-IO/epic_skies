import 'package:epic_skies/core/database/storage_controller.dart';

class WeatherCodeConverter {
  const WeatherCodeConverter();

  static String getPrecipitationTypeFromCode({required int code}) {
    switch (code) {
      case 0:
        return '';
      case 1:
        return 'Rain';
      case 2:
        return 'Snow';
      case 3:
        return 'Freezing Rain';
      case 4:
        return 'Ice Pellets';
      default:
        return '';
    }
  }

  static String getConditionFromWeatherCode(int? code) {
    switch (code) {
      case 0:
        return 'Unknown';
      case 1000:
        return 'Clear';
      case 1001:
        return 'Cloudy';
      case 1100:
        return 'Mostly Clear';
      case 1101:
        return 'Partly Cloudy';
      case 1102:
        return 'Mostly Cloudy';
      case 2000:
        return 'Fog';
      case 2100:
        return 'Light Fog';
      case 3000:
        return 'Light Wind';
      case 3001:
        return 'Wind';
      case 3002:
        return 'Strong Wind';
      case 4000:
        return 'Drizzle';
      case 4001:
        return 'Rain';
      case 4200:
        return 'Light Rain';
      case 4201:
        return 'Heavy Rain';
      case 5000:
        return 'Snow';
      case 5001:
        return 'Flurries';
      case 5100:
        return 'Light Snow';
      case 5101:
        return 'Heavy Snow';
      case 6000:
        return ' Freezing Drizzle';
      case 6001:
        return 'Freezing Rain';
      case 6200:
        return 'Light Freezing Rain';
      case 6201:
        return 'Heavy Freezing Rain';
      case 7000:
        return 'Ice Pellets';
      case 7101:
        return 'Heavy Ice Pellets';
      case 7102:
        return 'Light Ice Pellets';
      case 8000:
        return 'Thunderstorm';

      default:
        return '';
    }
  }

  static bool falseSnow({required String condition, required int temp}) {
    late final bool falseSnow;
    final tempUnitsCelcius = StorageController.to.tempUnitsCelcius();
    if (tempUnitsCelcius) {
      falseSnow = temp > 0;
    } else {
      falseSnow = temp > 32;
    }
    return falseSnow;
  }
}
