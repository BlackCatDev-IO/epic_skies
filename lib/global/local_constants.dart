import 'dart:ui';

import 'package:flutter/material.dart';

/* -------------------------------------------------------------------------- */
/*                              MAP/STORAGE KEYS                              */
/* -------------------------------------------------------------------------- */

const imageFileNameListKey = 'image_file_list_key';
const bgImageDynamicKey = 'bg_image_dynamic_key';
const bgImageAppGalleryKey = 'bg_image_app_gallery_key';
const deviceImagePathKey = 'device_image_path_key';
const imageSettingKey = 'image_setting_key';
const mostRecentSearchKey = 'most_recent_search';
const searchHistoryKey = 'search_history_key';
const appVersionStorageKey = 'app_version_key';
const searchIsLocalKey = 'search_is_local_key';
const tempUnitsMetricKey = 'temp_units_key';
const precipInMmKey = 'precip_unit_key';
const timeIs24HrsKey = 'time_format_key';
const speedInKphKey = 'speed_unit_key';
const timezoneOffsetKey = 'timezone_offset_key';
const isDayKey = 'is_day_key';
const placeIdKey = 'place_id_key';
const dataMapKey = 'data_map_storage';
const localLocationKey = 'local_location_key';
const remoteLocationKey = 'remote_location_key';
const subLocalityKey = 'sub_locality';
const localityKey = 'locality';
const administrativeAreaKey = 'admin_area';
const subAdministrativeAreaKey = 'sub_admin_area';
const countryKey = 'country';
const addressKey = 'address';
const streetKey = 'street';
const settingsMapKey = 'settings_map';

/* -------------------------------------------------------------------------- */
/*                          BACKGROUND IMAGE STRINGS                          */
/* -------------------------------------------------------------------------- */

const clearDay1 = 'assets/images/01_sunny_compressed.jpg';
const earthFromSpace = 'assets/images/01_earth_from_space.png';
const earthFromSpaceWithLogo = 'assets/images/earth_from_space_with_logo.png';
const clearNight1 = '01_starry_mountain_night_compressed.jpg';
const clearNight2 = '02_starry_city_night_compressed.jpg';
const cloudyDay1 = '01_cloudy_day.jpg';
const cloudyDaySunset2 = '02_cloudy_sunset_compressed.jpg';
const cloudyDayPalmTree3 = '03_palm_tree_sunset_compressed.jpg';
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
