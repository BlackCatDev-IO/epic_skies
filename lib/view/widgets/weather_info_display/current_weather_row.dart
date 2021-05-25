import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/html_entity.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherRow extends GetView<ViewController> {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (weatherRepoController) => GetBuilder<ViewController>(
        builder: (controller) => RoundedContainer(
          color: controller.homeContainerColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TempColumn(),
              if (weatherRepoController.searchIsLocal)
                const AddressColumn()
              else
                const RemoteLocationColumn(),
            ],
          ).paddingSymmetric(vertical: 5),
        ),
      ),
    ).paddingOnly(bottom: 2.5);
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) => GetBuilder<ViewController>(
        builder: (viewController) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(
              text: locationController.street,
              fontSize: 20,
              color: viewController.bgImageTextColor,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans',
            ),
            MyTextWidget(
              text: locationController.subLocality,
              fontSize: 50,
              color: viewController.bgImageTextColor,
              fontFamily: 'OpenSans',
            ).paddingSymmetric(horizontal: 10),
            MyTextWidget(
              text: locationController.administrativeArea,
              fontSize: 22,
              color: viewController.bgImageTextColor,
              fontFamily: 'OpenSans',
            ),
          ],
        ),
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
          builder: (viewController) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextWidget(
                text: searchController.searchCity,
                fontSize: 50,
                color: viewController.bgImageTextColor,
                fontFamily: 'OpenSans',
              ).paddingOnly(right: 5),
              Row(
                children: [
                  if (searchController.searchState == '')
                    const SizedBox()
                  else
                    MyTextWidget(
                        text: '${searchController.searchState}, ',
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        color: viewController.bgImageTextColor),
                  MyTextWidget(
                      text: '${searchController.searchCountry} ',
                      fontSize: 23,
                      fontFamily: 'OpenSans',
                      color: viewController.bgImageTextColor),
                ],
              ).paddingOnly(bottom: 8),
            ],
          ).paddingSymmetric(horizontal: 5),
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
      builder: (weatherController) => GetBuilder<ViewController>(
        builder: (viewController) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextWidget(
                  text: weatherController.temp.toString(),
                  fontSize: 75,
                  fontFamily: 'OpenSans',
                  color: viewController.bgImageTextColor,
                ),
                Column(
                  children: [
                    sizedBox10High,
                    MyTextWidget(
                      text: deg,
                      fontSize: 40,
                      fontFamily: 'OpenSans',
                      color: viewController.bgImageTextColor,
                    ),
                  ],
                ),
                MyTextWidget(
                  text: CurrentWeatherController.to.tempUnitString,
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  color: viewController.bgImageTextColor,
                ).paddingOnly(top: 17, left: 2.5),
              ],
            ),
            MyTextWidget(
              text: weatherController.condition,
              fontSize: 25,
              fontFamily: 'OpenSans',
              color: viewController.conditionColor,
            ),
            Row(
              children: [
                MyTextWidget(
                  text: 'Feels Like: ',
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  color: viewController.bgImageParamColor,
                ),
                MyTextWidget(
                  text: weatherController.feelsLike.toString(),
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  color: viewController.paramValueColor,
                ),
                MyTextWidget(
                  text: deg,
                  fontSize: 20,
                  color: viewController.conditionColor,
                ),
              ],
            ),
            Row(
              children: [
                MyTextWidget(
                  text: 'Wind Speed: ',
                  fontSize: 18,
                  color: viewController.bgImageParamColor,
                ),
                MyTextWidget(
                  text: '${weatherController.windSpeed}',
                  fontSize: 18,
                  color: viewController.paramValueColor,
                ),
                MyTextWidget(
                  text: ' ${CurrentWeatherController.to.speedUnitString}',
                  fontSize: 18,
                  // color: Colors.amber[100],
                  color: viewController.conditionColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ).paddingOnly(left: 10, bottom: 5);
  }
}
