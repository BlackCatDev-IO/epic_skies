import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/services/location/location_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../hourly_widgets/hourly_detailed_row.dart';

class CurrentWeatherRow extends GetView<ViewController> {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      builder: (controller) => RoundedContainer(
        color: controller.theme.homeContainerColor,
        height: 26.h,
        child: GetBuilder<WeatherRepository>(
          builder: (weatherRepoController) => Stack(
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
    ).paddingSymmetric(horizontal: 2);
  }
}

class AddressColumn extends StatelessWidget {
  const AddressColumn();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 24.h,
      right: 5,
      child: GetBuilder<LocationController>(
        builder: (locationController) {
          return GetBuilder<ViewController>(
            builder: (viewController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextWidget(
                    text: locationController.street,
                    fontSize: 13.sp,
                    color: viewController.theme.bgImageTextColor,
                  ).paddingOnly(left: 10),
                  MyTextWidget(
                    text: locationController.subLocality,
                    fontSize: locationController.subLocality.length > 10
                        ? 22.sp
                        : 28.sp,
                    fontWeight: FontWeight.w400,
                    color: viewController.theme.bgImageTextColor,
                  ).paddingSymmetric(horizontal: 10),
                  MyTextWidget(
                    text: locationController.administrativeArea,
                    fontSize: 15.sp,
                    color: viewController.theme.bgImageTextColor,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class RemoteLocationColumn extends StatelessWidget {
  const RemoteLocationColumn();
  @override
  Widget build(BuildContext context) {
    debugPrint(
      'city string length: ${LocationController.to.searchCity.length}',
    );
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Positioned(
          height: 24.h,
          right: locationController.searchCity.length > 10 ? 0 : 5,
          child: GetBuilder<ViewController>(
            builder: (viewController) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextWidget(
                  text: locationController.searchCity,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: viewController.theme.bgImageTextColor,
                ).paddingOnly(right: 5),
                sizedBox5High,
                Row(
                  children: [
                    if (locationController.searchState == '')
                      const SizedBox()
                    else
                      MyTextWidget(
                        text: '${locationController.searchState}, ',
                        fontSize: 15.sp,
                        color: viewController.theme.bgImageTextColor,
                      ),
                    MyTextWidget(
                      text: '${locationController.searchCountry} ',
                      fontSize: 15.sp,
                      color: viewController.theme.bgImageTextColor,
                    ),
                  ],
                ).paddingOnly(bottom: 8),
              ],
            ).paddingSymmetric(horizontal: 5),
          ),
        );
      },
    );
  }
}

class TempColumn extends StatelessWidget {
  const TempColumn();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentWeatherController>(
      builder: (weatherController) => GetBuilder<ViewController>(
        builder: (viewController) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sizedBox10High,
            MainCurrentTempWidget(),
            MyTextWidget(
              text: weatherController.condition,
              fontSize: 14.sp,
              color: viewController.theme.conditionColor,
            ),
            FeelsLikeRow(),
            Row(
              children: [
                MyTextWidget(
                  text: 'Wind Speed: ',
                  fontSize: 12.sp,
                  color: viewController.theme.bgImageParamColor,
                ),
                MyTextWidget(
                  text:
                      '${weatherController.windSpeed} ${weatherController.speedUnitString}',
                  fontSize: 12.sp,
                  color: viewController.theme.paramValueColor,
                ),
              ],
            ),
            sizedBox5High
          ],
        ),
      ),
    ).paddingOnly(left: 10, bottom: 5);
  }
}

class MainCurrentTempWidget extends GetView<CurrentWeatherController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextWidget(
          text: controller.temp.toString(),
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: ViewController.to.theme.bgImageTextColor,
        ).paddingSymmetric(vertical: 5),
        Column(
          children: [
            sizedBox10High,
            MyTextWidget(
              text: deg,
              fontSize: 30.sp,
              color: ViewController.to.theme.bgImageTextColor,
            ),
          ],
        ),
        MyTextWidget(
          text: controller.tempUnitString,
          fontSize: 14.sp,
          color: ViewController.to.theme.bgImageTextColor,
        ).paddingOnly(top: 17, left: 2.5),
      ],
    );
  }
}

class FeelsLikeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyTextWidget(
          text: 'Feels Like: ',
          fontSize: 12.sp,
          color: ViewController.to.theme.bgImageParamColor,
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.feelsLike.toString(),
          fontSize: 12.sp,
          color: ViewController.to.theme.paramValueColor,
        ),
        MyTextWidget(
          text: deg,
          fontSize: 12.sp,
          color: ViewController.to.theme.conditionColor,
        ),
      ],
    );
  }
}
