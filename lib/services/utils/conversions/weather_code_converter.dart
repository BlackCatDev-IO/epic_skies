class WeatherCodeConverter {
  const WeatherCodeConverter();

  String getPrecipitationTypeFromCode(int code) {
    switch (code) {
      case 0:
        return '';
        break;
      case 1:
        return 'Rain';
        break;
      case 2:
        return 'Snow';
        break;
      case 3:
        return 'Freezing Rain';
        break;
      case 4:
        return 'Ice Pellets';
        break;
      default:
        return '';
    }
  }

  String getConditionFromWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Unknown';
        break;
      case 1000:
        return 'Clear';
        break;
      case 1001:
        return 'Cloudy';
        break;
      case 1100:
        return 'Mostly Clear';
        break;
      case 1101:
        return 'Partly Cloudy';
        break;
      case 1102:
        return 'Mostly Cloudy';
        break;
      case 2000:
        return 'Fog';
        break;
      case 2100:
        return 'Light Fog';
        break;
      case 3000:
        return 'Light Wind';
        break;
      case 3001:
        return 'Wind';
        break;
      case 3002:
        return 'Strong Wind';
        break;
      case 4000:
        return 'Drizzle';
        break;
      case 4001:
        return 'Rain';
        break;
      case 4200:
        return 'Light Rain';
        break;
      case 4201:
        return 'Heavy Rain';
        break;
      case 5000:
        return 'Snow';
        break;
      case 5001:
        return 'Flurries';
        break;
      case 5100:
        return 'Light Snow';
        break;
      case 5101:
        return 'Heavy Snow';
        break;
      case 6000:
        return ' Freezing Drizzle';
        break;
      case 6001:
        return 'Freezing Rain';
        break;
      case 6200:
        return 'Light Freezing Rain';
        break;
      case 6201:
        return 'Heavy Freezing Rain';
        break;
      case 7000:
        return 'Ice Pellets';
        break;
      case 7101:
        return 'Heavy Ice Pellets';
        break;
      case 7102:
        return 'Light Ice Pellets';
        break;
      case 8000:
        return 'Thunderstorm';
        break;

      default:
        return '';
    }
  }
}
