import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/html_entity.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/color_controller.dart';
import 'package:epic_skies/services/utils/location_controller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:epic_skies/widgets/general/border_text_stack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TempColumn(),
          if (controller.searchIsLocal)
            const AddressColumn()
          else
            const RemoteLocationColumn(),
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
                  BorderTextStack(
                      text: searchController.city, fontSize: 50, height: 0.999),
                ],
              ).paddingSymmetric(horizontal: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (searchController.state == '')
                    const SizedBox()
                  else
                    BorderTextStack(
                      text: '${searchController.state}, ',
                      fontSize: 20,
                    ),
                  BorderTextStack(
                    text: '${searchController.country}, ',
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
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderTextStack(text: controller.temp.toString(), fontSize: 80),
              Column(
                children: [
                  sizedBox10High,
                  BorderTextStack(text: deg, fontSize: 40),
                ],
              ),
              GetBuilder<SettingsController>(
                builder: (settingsController) => BorderTextStack(
                        text: settingsController.tempUnitString, fontSize: 20)
                    .paddingOnly(top: 17, left: 2.5),
              )
              //
            ],
          ),
          BorderTextStack(text: controller.condition, fontSize: 25),
          Row(
            children: [
              const BorderTextStack(text: 'Feels Like: ', fontSize: 18),
              BorderTextStack(
                  text: controller.feelsLike.toString(), fontSize: 18),
              BorderTextStack(text: deg, fontSize: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BorderTextStack(
                text: locationController.street,
                fontSize: 20,
              )
            ],
          ).paddingOnly(bottom: 8),
          Row(children: [
            BorderTextStack(
                text: locationController.subLocality,
                fontSize: 50,
                height: 0.999),
          ]).paddingSymmetric(horizontal: 6, vertical: 5),
          Row(
            children: [
              BorderTextStack(
                  text: locationController.administrativeArea,
                  fontSize: 18,
                  height: 0.94),
            ],
          ),
        ],
      ),
    );
  }
}
