class MockStorageReturns {
  static const todayData = {
    'temperature': 59.23,
    'temperatureApparent': 59.23,
    'humidity': 96.03,
    'cloudBase': 3.65,
    'cloudCeiling': 3.84,
    'cloudCover': 100,
    'windSpeed': 16.08,
    'windDirection': 275.28,
    'precipitationProbability': 85,
    'precipitationType': 2,
    'precipitationIntensity': 0.0425,
    'visibility': 9.94,
    'weatherCode': 5100,
    'sunsetTime': '2022-02-12T17:26:40-05:00',
    'sunriseTime': '2022-02-12T06:53:20-05:00'
  };

  static const bronxLocationData = {
    'subLocality': 'The Bronx',
    'administrativeArea': 'New York',
    'country': 'United States',
    'longNameList': null,
  };

  static const ouagaLocationData = {
    'remoteLong': -1.5196603,
    'remoteLat': 12.3714277,
    'city': 'Ouagadougou',
    'state': '',
    'country': 'Burkina Faso',
    'longNameList': null,
  };

  static final adaptiveLayoutModel = {
    'appBarPadding': 18,
    'appBarHeight': 18.5,
    'settingsHeaderHeight': 18.toDouble()
  };

  static const appDirectoryPath =
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter';

  static const bgDynamicImagePath =
      '/data/user/0/com.blackcatdev.epic_skies/app_flutter/assets/images/01_sunny_compressed.jpg';
}
