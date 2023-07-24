import 'dart:ui';

import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';

/* -------------------------------------------------------------------------- */
/*                          BACKGROUND IMAGE STRINGS                          */
/* -------------------------------------------------------------------------- */

const earthFromSpace = 'assets/images/01_earth_from_space.png';
const clearDay1 = '01_sunny_compressed.jpg';
const clearNight1 = '01_starry_mountain_night_compressed.jpg';
const clearNight2 = '02_starry_city_night_compressed.jpg';
const cloudyDay1 = '01_cloudy_day.jpg';
const cloudyDaySunset2 = '02_cloudy_sunset_compressed.jpg';
const cloudyNight1 = '01_night_starry_clouds.jpg';
const cloudyNight2 = '02_night_moon_clouds.jpg';
const cloudyNight3 = '03_northern_lights_clouds.jpg';
const cloudyNight4 = '04_night_eerie_clouds.jpg';
const rainSadFace1 = '01_light_rain_sadface_compressed.jpg';
const snowDay1 = '01_snowflake.jpg';
const snowNight1 = '01_snowy_city_street_compressed.jpg';
const stormNight1 = '01_storm.jpg';

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
const sunriseIcon = 'assets/icons/sun_time_icons/sunrise_icon.png';
const rainDrop = 'assets/icons/precip_icons/rain_drop.png';
const snowflake = 'assets/icons/precip_icons/snow.png';
const hail = 'assets/icons/precip_icons/hail.png';

/* -------------------------------------------------------------------------- */
/*                                   COLORS                                   */
/* -------------------------------------------------------------------------- */

const Color kBlackCustom = Color.fromRGBO(0, 0, 0, 0.7);

const myEmail = 'loren@blackcatdev.io';

/* -------------------------------------------------------------------------- */
/*                              IMAGE CREDIT URLS                             */
/* -------------------------------------------------------------------------- */

const vcloudIconsUrl = 'https://www.deviantart.com/vclouds';
const earthFromSpaceUrl = 'https://unsplash.com/photos/Q1p7bh3SHj8';
const clearDay1Url =
    'http://www.wa11papers.com/images/nature-sky-outdoors-landscape-trees-clouds-grass-mountain-summer-scenic-sun-light-daylight-color-wallpaper-11085.html';
const clearNight1Url = 'https://pixy.org/171739/';
const clearNight2Url =
    'https://www.desktopbackground.org/wallpaper/night-sky-star-lights-ipad-wallpapers-download-54026';
const cloudyDay1Url = 'https://pixy.org/4798768/';

/* -------------------------------------------------------------------------- */
/*                                   SYMBOLS                                  */
/* -------------------------------------------------------------------------- */

final degreeSymbol = String.fromCharCode($deg);
