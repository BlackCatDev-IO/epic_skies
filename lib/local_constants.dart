/* -------------------------------------------------------------------------- */
/*                                   MAPKEYS                                  */
/* -------------------------------------------------------------------------- */

import 'dart:convert';

import 'package:flutter/foundation.dart';

const dataMapKey = 'data_map_storage';
const locationMapKey = 'location_map';
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




Map<String, String> parseData(String data) {
  debugPrint('parseData on isolate thread');
  final map = {
    mainKey: (jsonDecode(data)['current']['weather'][0]['main']).toString(),
    currentConditionKey:
        jsonDecode(data)['current']['weather'][0]['description'].toString(),
    currentTempKey: (jsonDecode(data)['current']['temp']).round().toString(),
    feelsLikeKey:
        (jsonDecode(data)['current']['feels_like']).round().toString(),
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
  }

  return map;
}
