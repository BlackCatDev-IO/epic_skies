class WeatherCodeConverter {
  const WeatherCodeConverter();

  static String convertWeatherKitCodes(String code) {
    switch (code.toLowerCase()) {
      case 'blowingdust':
        return 'Blowing dust or sandstorm';
      case 'clear':
        return 'Clear';
      case 'cloudy':
        return 'Cloudy, overcast conditions';
      case 'foggy':
        return 'Fog';
      case 'haze':
        return 'Haze';
      case 'mostlyclear':
        return 'Mostly clear';
      case 'mostlycloudy':
        return 'Mostly cloudy';
      case 'partlycloudy':
        return 'Partly cloudy';
      case 'smoky':
        return 'Smoky';
      case 'breezy':
        return 'Breezy, light wind';
      case 'windy':
        return 'Windy';
      case 'drizzle':
        return 'Drizzle or light rain';
      case 'heavyRain':
        return 'Heavy rain';
      case 'isolatedThunderstorms':
        return 'Isolated thunderstorms';
      case 'rain':
        return 'Rain';
      case 'sunshowers':
        return 'Rain with visible sun';
      case 'scatteredthunderstorms':
        return 'Scattered thunderstorms';
      case 'strongstorms':
        return 'Strong thunderstorms';
      case 'thunderstorms':
        return 'Thunderstorms';
      case 'frigid':
        return 'Frigid conditions';
      case 'hail':
        return 'Hail';
      case 'hot'
            'High temperatures':
      case 'flurries':
        return 'Flurries or light snow';
      case 'sleet':
        return 'Sleet';
      case 'snow':
        return 'Snow';
      case 'sunflurries':
        return 'Snow flurries with visible sun';
      case 'wintrymix':
        return 'Wintry mix';
      case 'blizzard':
        return 'Blizzard';
      case 'blowingsnow':
        return 'Blowing or drifting snow';
      case 'freezingdrizzle':
        return 'Freezing drizzle or light rain';
      case 'freezingrain':
        return 'Freezing rain';
      case 'heavysnow':
        return 'Heavy snow';
      case 'hurricane':
        return 'Hurricane';
      case 'tropicalstorm':
        return 'Tropical storm';

      default:
        return code;
    }
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
