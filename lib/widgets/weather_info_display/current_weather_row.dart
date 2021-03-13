import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/html_entity.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/location_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TempColumn(),

          controller.searchIsLocal ? AddressColumn() : RemoteLocationColumn(),
          // const WeatherIcon(),
        ],
      ).paddingOnly(top: 5, bottom: 5),
    );
  }
}

class RemoteLocationColumn extends StatelessWidget {
  const RemoteLocationColumn();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (searchController) {
        return GetBuilder<ColorController>(
          builder: (colorController) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    searchController.city,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageCityColor,
                        fontSize: 50,
                        height: 0.999),
                  ),
                ],
              ).paddingSymmetric(horizontal: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  searchController.state == ''
                      ? Container()
                      : MyTextWidget(
                          text: '${searchController.state}, ',
                          color: colorController.bgImageStreetColor,
                          fontSize: 20,
                        ),
                  MyTextWidget(
                    text: searchController.country,
                    color: colorController.bgImageStreetColor,
                    fontSize: 20,
                  ),
                ],
              ).paddingOnly(bottom: 8),
            ],
          ).paddingSymmetric(horizontal: 30),
        );
      },
    );
  }
}

class TempColumn extends StatelessWidget {
  const TempColumn();
  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);

    return GetBuilder<CurrentWeatherController>(
      builder: (controller) {
        return GetBuilder<ColorController>(
          builder: (colorController) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.temp,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageTextColor, fontSize: 80),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      sizedBox10High,
                      Text(
                        deg,
                        style: kGoogleFontOpenSansCondensed.copyWith(
                            color: colorController.bgImageTextColor,
                            fontSize: 40),
                      ),
                    ],
                  ),
                  GetBuilder<SettingsController>(
                    builder: (settingsController) => MyTextWidget(
                      text: settingsController.tempUnitString,
                    ).paddingOnly(top: 17, left: 2.5),
                  )
                ],
              ),
              Text(
                controller.condition,
                style: kGoogleFontOpenSansCondensed.copyWith(
                    color: colorController.bgImageTextColor, fontSize: 25),
              ),
              Row(
                children: [
                  Text(
                    'Feels Like: ',
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageTextColor, fontSize: 18),
                  ),
                  Text(
                    controller.feelsLike.toString(),
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageTextColor, fontSize: 18),
                  ),
                  Text(
                    deg,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageTextColor, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return GetBuilder<ColorController>(
          builder: (colorController) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    locationController.street,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageStreetColor,
                        fontSize: 15),
                  ),
                ],
              ).paddingOnly(bottom: 8),
              Row(
                children: [
                  Text(
                    locationController.subLocality,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageCityColor,
                        fontSize: 50,
                        height: 0.999),
                    // color: Colors.blueGrey[500], fontSize: 50, height: 0.999),
                  ),
                ],
              ).paddingSymmetric(horizontal: 6, vertical: 5),
              Row(
                children: [
                  Text(
                    locationController.administrativeArea,
                    style: kGoogleFontOpenSansCondensed.copyWith(
                        color: colorController.bgImageCityColor,
                        fontSize: 18,
                        height: 0.94),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
