class WeatherCodeConverter {
  const WeatherCodeConverter();

  static String convertWeatherKitCodes(String code) {
    return switch (code.toLowerCase()) {
      'blowingdust' => 'Blowing dust or sandstorm',
      'clear' => 'Clear',
      'cloudy' => 'Cloudy',
      'foggy' => 'Fog',
      'haze' => 'Haze',
      'mostlyclear' => 'Mostly clear',
      'mostlycloudy' => 'Mostly cloudy',
      'partlycloudy' => 'Partly cloudy',
      'smoky' => 'Smoky',
      'breezy' => 'Light wind',
      'windy' => 'Windy',
      'drizzle' => 'Drizzle',
      'heavyrain' => 'Heavy rain',
      'isolatedThunderstorms' => 'Thunderstorms',
      'rain' => 'Rain',
      'sunshowers' => 'Rain with visible sun',
      'scatteredthunderstorms' => 'Scattered thunderstorms',
      'strongstorms' => 'Strong thunderstorms',
      'thunderstorms' => 'Thunderstorms',
      'frigid' => 'Frigid conditions',
      'hail' => 'Hail',
      'hot' => 'High temperatures',
      'flurries' => 'Flurries',
      'sleet' => 'Sleet',
      'snow' => 'Snow',
      'sunflurries' => 'Snow flurries with visible sun',
      'wintrymix' => 'Wintry mix',
      'blizzard' => 'Blizzard',
      'blowingsnow' => 'Drifting snow',
      'freezingdrizzle' => 'Freezing drizzle',
      'freezingrain' => 'Freezing rain',
      'heavysnow' => 'Heavy snow',
      'hurricane' => 'Hurricane',
      'tropicalstorm' => 'Tropical storm',
      'isolatedthunderstorms' => 'Isolated thunderstorms',
      _ => code,
    };
  }

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
        return 'Freezing Drizzle';
      case 6001:
      case 6200:
      case 6201:
        return 'Freezing Rain';
      case 7000:
      case 7101:
      case 7102:
        return 'Ice Pellets';
      case 8000:
        return 'Thunderstorm';

      default:
        return '';
    }
  }

  static bool falseSnow({
    required String condition,
    required int temp,
    required bool tempUnitsMetric,
  }) =>
      tempUnitsMetric ? temp > 0 : temp > 32;
}
