import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'WEATHER_API_KEY', obfuscate: true)
  static final String weatherApiKey = _Env.weatherApiKey;

  @EnviedField(varName: 'WEATHER_API_BASE_URL', obfuscate: true)
  static final String weatherBaseUrl = _Env.weatherBaseUrl;

  @EnviedField(varName: 'GOOGLE_PLACES_KEY', obfuscate: true)
  static final String googlePlacesKey = _Env.googlePlacesKey;

  @EnviedField(varName: 'BING_MAPS_BACKUP_API_KEY', obfuscate: true)
  static final String bingMapsBackupKey = _Env.bingMapsBackupKey;

  @EnviedField(varName: 'BING_MAPS_BASE_URL', obfuscate: true)
  static final String bingMapsBaseUrl = _Env.bingMapsBaseUrl;

  @EnviedField(varName: 'MIX_PANEL_TOKEN', obfuscate: true)
  static final String mixpanelToken = _Env.mixpanelToken;

  @EnviedField(varName: 'ANDROID_TEST_AD_ID', obfuscate: true)
  static final String androidTestAdId = _Env.androidTestAdId;

  @EnviedField(varName: 'REMOVE_ADS_PRODUCT_KEY', obfuscate: true)
  static final String removeAdsProdectKey = _Env.removeAdsProdectKey;

  @EnviedField(varName: 'SENTRY_PATH', obfuscate: true)
  static final String sentryPath = _Env.sentryPath;

  @EnviedField(varName: 'WEATHER_SERVICE_ID', obfuscate: true)
  static final String weatherServiceId = _Env.weatherServiceId;

  @EnviedField(varName: 'WEATHER_KIT_KEY_ID', obfuscate: true)
  static final String weatherKitKeyId = _Env.weatherKitKeyId;

  @EnviedField(varName: 'APPLE_TEAM_ID', obfuscate: true)
  static final String appleTeamId = _Env.appleTeamId;

  @EnviedField(varName: 'IOS_AD_FREE_PRODUCT_ID', obfuscate: true)
  static final String iOsAdFreeProductId = _Env.iOsAdFreeProductId;

  @EnviedField(varName: 'ANDROID_AD_FREE_PRODUCT_ID', obfuscate: true)
  static final String androidAdFreeProductId = _Env.androidAdFreeProductId;

  @EnviedField(varName: 'ANDROID_PROD_AD_ID', obfuscate: true)
  static final String androidProdId = _Env.androidProdId;

  @EnviedField(varName: 'IOS_PROD_AD_ID', obfuscate: true)
  static final String iOsProdId = _Env.iOsProdId;

  @EnviedField(varName: 'IOS_TEST_AD_ID', obfuscate: true)
  static final String iOsTestId = _Env.iOsTestId;

  @EnviedField(varName: 'IMAGE_CDN_URL', obfuscate: true)
  static final String imageCdnUrl = _Env.imageCdnUrl;

  @EnviedField(varName: 'WEATHER_KIT_P8', obfuscate: true)
  static final String weatherKitP8 = _Env.weatherKitP8;

  @EnviedField(varName: 'EPIC_SKIES_API_TOKEN', obfuscate: true)
  static final String epicSkiesApiToken = _Env.epicSkiesApiToken;

  @EnviedField(varName: 'ANALYTICS_BASE_URL', obfuscate: true)
  static final String analyticsBaseUrl = _Env.analyticsBaseUrl;

  @EnviedField(varName: 'UMAMI_PROJECT_ID', obfuscate: true)
  static final String umamiProjectId = _Env.umamiProjectId;

  @EnviedField(varName: 'UMAMI_DOMAIN', obfuscate: true)
  static final String umamiDomain = _Env.umamiDomain;
}
