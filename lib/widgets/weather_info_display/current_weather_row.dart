import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/html_entity.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherRow extends GetView<ViewController> {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (weatherRepoController) => RoundedContainer(
        color: controller.containerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TempColumn(),
            if (weatherRepoController.searchIsLocal)
              const AddressColumn()
            else
              const RemoteLocationColumn(),
          ],
        ).paddingOnly(top: 5, bottom: 5),
      ),
    );
  }
}

class AddressColumn extends GetView<ViewController> {
  const AddressColumn();

  @override
  Widget build(BuildContext context) {
    final color = controller.bgImageTextColor;
    // final color = Colors.blue;
    return GetBuilder<LocationController>(
      builder: (locationController) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyTextWidget(
              text: locationController.street,
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.w400),
          MyTextWidget(
            text: locationController.subLocality,
            fontSize: 50,
            color: color,
          ).paddingSymmetric(horizontal: 6),
          MyTextWidget(
              text: locationController.administrativeArea,
              fontSize: 22,
              color: color),
        ],
      ),
    );
  }
}

class RemoteLocationColumn extends StatelessWidget {
  const RemoteLocationColumn();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (searchController) {
        return GetBuilder<ViewController>(
          builder: (colorController) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextWidget(text: searchController.searchCity, fontSize: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (searchController.searchState == '')
                    const SizedBox()
                  else
                    MyTextWidget(
                      text: '${searchController.searchState}, ',
                      fontSize: 20,
                    ),
                  MyTextWidget(
                    text: '${searchController.searchCountry} ',
                    fontSize: 23,
                  ),
                ],
              ).paddingOnly(bottom: 8),
            ],
          ).paddingSymmetric(horizontal: 20),
        );
      },
    );
  }
}

class TempColumn extends GetView<ViewController> {
  const TempColumn();

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);

    return GetBuilder<CurrentWeatherController>(
      builder: (weatherController) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextWidget(
                text: weatherController.temp.toString(),
                fontSize: 80,
                color: controller.bgImageTextColor,
              ),
              Column(
                children: [
                  sizedBox10High,
                  MyTextWidget(
                    text: deg,
                    fontSize: 40,
                    color: controller.bgImageTextColor,
                  ),
                ],
              ),
              GetBuilder<SettingsController>(
                builder: (settingsController) => MyTextWidget(
                  text: settingsController.tempUnitString,
                  fontSize: 20,
                  color: controller.bgImageTextColor,
                ).paddingOnly(top: 17, left: 2.5),
              )
            ],
          ),
          MyTextWidget(text: weatherController.condition, fontSize: 25),
          Row(
            children: [
              const MyTextWidget(text: 'Feels Like: ', fontSize: 18),
              MyTextWidget(
                  text: weatherController.feelsLike.toString(), fontSize: 18),
              MyTextWidget(text: deg, fontSize: 20),
            ],
          ),
          Row(
            children: [
              const MyTextWidget(text: 'Wind Speed: ', fontSize: 18),
              MyTextWidget(
                  text:
                      '${weatherController.windSpeed} ${SettingsController.to.speedUnitString}',
                  fontSize: 18),
            ],
          ),
        ],
      ),
    );
  }
}
