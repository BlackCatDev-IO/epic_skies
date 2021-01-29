/* -------------------------------------------------------------------------- */
/*                                   MAPKEYS                                  */
/* -------------------------------------------------------------------------- */

import 'dart:convert';

import 'package:flutter/foundation.dart';

const isDayKey = 'is_day';

const dataMapKey = 'data_map_storage';
const locationMapKey = 'location_map';
const jsonMapKey = 'json_map';
const backgroundImageKey = 'background_image';
const currentConditionKey = 'current_condition';
const dailyConditionKey = 'current_condition';
const mainKey = 'main';
const dailyMainKey = 'daily_main';
const currentTempKey = 'current_temp';
const feelsLikeKey = 'feels_like';
const feelsLikeHourlyKey = 'feels_like_hourly';
const sunsetTimeKey = 'sunset_time';
const sunriseTimeKey = 'sunrise_time';
const precipitationKey = 'preciptitation';
const hourlyTempKey = 'hourly_temp';
const dailyTempKey = 'daily_temp';
const hourlyConditionKey = 'conditions';
const hourlyTimeKey = 'hourly_time';
const hourlyMainKey = 'hourly_main';
const iconPathKey = 'icon_path';
const nextDayKey = 'next_day';
const dayKey = 'day';
const nowKey = 'now';
const subLocalityKey = 'sub_locality';
const localityKey = 'locality';
const administrativeAreaKey = 'admin_area';
const countryKey = 'country';
const addressKey = 'address';
const streetKey = 'street';

/* -------------------------------------------------------------------------- */
/*                          BACKGROUND IMAGE STRINGS                          */
/* -------------------------------------------------------------------------- */

const cloudyPortrait = 'assets/images/cloudy_portrait2.jpg';
const lightingCropped = 'assets/images/lighting_cropped3.jpg';
const snowPortrait = 'assets/images/snow_portrait.jpg';
const clearDay1 = 'assets/images/sunny_portrait.jpg';
const earthFromSpaceLandscape = 'assets/images/earth_from_space_landscape.jpg';
const earthFromSpacePortrait = 'assets/images/earth_from_space_portrait.jpeg';
const moonLandscape = 'assets/images/moon_landscape.jpeg';
const moonPortrait = 'assets/images/moon_portrait.jpg';
const snowyCityStreetPortrait = 'assets/images/snowy_city_street_portrait.jpg';
const starryMountainPortrait = 'assets/images/starry_mountain_portrait.jpg';

/* -------------------------------------------------------------------------- */
/*                                ICON STRINGS                                */
/* -------------------------------------------------------------------------- */

const nightCloudy = 'assets/icons/vclouds_icons/night_cloudy.png';
const clearDayIcon = 'assets/icons/vclouds_icons/clear_day.png';
const clearNightIcon = 'assets/icons/vclouds_icons/clear_night.png';
const mist = 'assets/icons/vclouds_icons/mist.png';
const smoke = 'assets/icons/vclouds_icons/smoke.png';
const sand = 'assets/icons/vclouds_icons/sand.png';
const squalls = 'assets/icons/vclouds_icons/squalls.png';
const tornadoIcon = 'assets/icons/tornado.jpeg';
const daySnowIcon = 'assets/icons/vclouds_icons/snow_day.png';
const nightSnowIcon = 'assets/icons/vclouds_icons/snow_night.png';
const heavySnowIcon = 'assets/icons/vclouds_icons/snow_heavy.png';
const sleetIcon = 'assets/icons/vclouds_icons/sleet.png';
const rainHeavyIcon = 'assets/icons/vclouds_icons/rain_heavy.png';
const rainLightIcon = 'assets/icons/vclouds_icons/rain_light.png';
const rainShowerIcon = 'assets/icons/vclouds_icons/rain_shower.png';
const thunderstormDayIcon = 'assets/icons/vclouds_icons/thunderstorm_day.png';
const thunderstormHeavyIcon = 'assets/icons/vclouds_icons/thunderstorm_day.png';
const fewCloudsDay = 'assets/icons/vclouds_icons/few_clouds_day.png';
const fewCloudsNight = 'assets/icons/vclouds_icons/few_clouds_night.png';
const overcastClouds = 'assets/icons/vclouds_icons/overcast_clouds.png';
const scatteredCloudsDay =
    'assets/icons/vclouds_icons/scattered_clouds_day.png';

Map<String, dynamic> parseData(String data) {
  debugPrint('parseData on isolate thread');
  final map = {
    mainKey: (jsonDecode(data)['current']['weather'][0]['main']).toString(),
    currentConditionKey:
        jsonDecode(data)['current']['weather'][0]['description'].toString(),
    currentTempKey: (jsonDecode(data)['current']['temp']).round().toString(),
    feelsLikeKey:
        (jsonDecode(data)['current']['feels_like']).round().toString(),
    sunsetTimeKey: (jsonDecode(data)['current']['sunset']),
    sunriseTimeKey: jsonDecode(data)['current']['sunrise'],
  };

  for (int i = 0; i <= 24; i++) {
    if (i < 7) {
      map['$dailyTempKey:$i'] =
          (jsonDecode(data)['daily'][i]['temp']['day']).round().toString();
      map['$dailyMainKey:$i'] =
          jsonDecode(data)['daily'][i]['weather'][0]['main'].toString();
      map['$dailyConditionKey:$i'] =
          jsonDecode(data)['daily'][i]['weather'][0]['description'].toString();
    }
    map['$hourlyTempKey:$i'] =
        (jsonDecode(data)['hourly'][i]['temp']).round().toString();
    map['$precipitationKey:$i'] =
        (jsonDecode(data)['hourly'][i]['pop']).round().toString();
    map['$hourlyConditionKey:$i'] =
        jsonDecode(data)['hourly'][i]['weather'][0]['description'].toString();
    map['$feelsLikeHourlyKey:$i'] =
        (jsonDecode(data)['hourly'][i]['feels_like']).round().toString();
    map['$hourlyMainKey:$i'] =
        jsonDecode(data)['hourly'][i]['weather'][0]['main'].toString();
    map['$hourlyTempKey:$i'] =
        (jsonDecode(data)['hourly'][i]['temp']).round().toString();
    final timeCode = jsonDecode(data)['hourly'][i]['dt'];
    final formattedCode =
        DateTime.fromMillisecondsSinceEpoch(timeCode * 1000).toString();
    map['$hourlyTimeKey:$i'] = DateTime.parse(formattedCode).hour.toString();
  }

  return map;
}
