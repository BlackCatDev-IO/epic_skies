import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> loadEnv() => dotenv.load();

/* ------------------------------ Weather Keys ------------------------------ */

  static String get weatherApiKey => dotenv.env['VISUAL_CROSSING_API_KEY']!;
  static String get baseWeatherUrl => dotenv.env['VISUAL_CROSSING_BASE_URL']!;

/* ------------------------------ Location Keys ----------------------------- */

  static String get googlePlacesKey => dotenv.env['GOOGLE_PLACES_KEY']!;
  static String get bingMapsBackupKey =>
      dotenv.env['BING_MAPS_BACKUP_API_KEY']!;

  static String get bingMapsBaseUrl => dotenv.env['BING_MAPS_BASE_URL']!;

/* ------------------------------ Analytics Key ----------------------------- */

  static String get mixPanelToken => dotenv.env['MIX_PANEL_TOKEN']!;

/* ----------------------------- Google Ads Keys ---------------------------- */

  static String get testAndroidNativeId => dotenv.env['ANDROID_TEST_AD_ID']!;
  static String get testIOSNativeId => dotenv.env['IOS_TEST_AD_ID']!;
  static String get removeAdsProductKey =>
      dotenv.env['REMOVE_ADS_PRODUCT_KEY']!;

  static String get testNativeAdUnitId {
    return Platform.isAndroid ? testAndroidNativeId : testIOSNativeId;
  }
}
