import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/services/weather/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hourly_widgets/hourly_detailed_row.dart';

class CurrentWeatherRow extends GetView<ViewController> {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (weatherRepoController) => GetBuilder<ViewController>(
        builder: (controller) => RoundedContainer(
          color: controller.theme.homeContainerColor,
          height: controller.currentWeatherWidgetHeight,
          child: Stack(
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
      height: ViewController.to.currentWeatherWidgetHeight,
      right: 5,
      child: GetBuilder<LocationController>(
        builder: (locationController) => GetBuilder<ViewController>(
          builder: (viewController) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextWidget(
                text: locationController.street,
                fontSize: 20,
                color: viewController.theme.bgImageTextColor,
                fontWeight: FontWeight.w200,
              ).paddingOnly(left: 10),
              sizedBox5High,
              MyTextWidget(
                text: locationController.subLocality,
                fontSize: 45,
                color: viewController.theme.bgImageTextColor,
              ).paddingSymmetric(horizontal: 10),
              sizedBox5High,
              MyTextWidget(
                text: locationController.administrativeArea,
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: viewController.theme.bgImageTextColor,
              ),
              sizedBox5High
            ],
          ),
        ),
      ),
    );
  }
}

class RemoteLocationColumn extends StatelessWidget {
  const RemoteLocationColumn();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: ViewController.to.currentWeatherWidgetHeight,
      right: 0,
      child: GetBuilder<LocationController>(
        builder: (locationController) {
          return GetBuilder<ViewController>(
            builder: (viewController) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextWidget(
                  text: locationController.searchCity,
                  fontSize: 35,
                  fontWeight: FontWeight.w200,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: viewController.theme.bgImageTextColor),
                    MyTextWidget(
                        text: '${locationController.searchCountry} ',
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: viewController.theme.bgImageTextColor),
                  ],
                ).paddingOnly(bottom: 8),
                sizedBox20High
              ],
            ).paddingSymmetric(horizontal: 5),
          );
        },
      ),
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
              fontSize: 20,
              color: viewController.theme.conditionColor,
            ),
            FeelsLikeRow(),
            Row(
              children: [
                MyTextWidget(
                  text: 'Wind Speed:',
                  fontSize: 17,
                  color: viewController.theme.bgImageParamColor,
                ),
                MyTextWidget(
                  text:
                      '${weatherController.windSpeed} ${weatherController.speedUnitString}',
                  fontSize: 17,
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

class MainCurrentTempWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextWidget(
          text: CurrentWeatherController.to.temp.toString(),
          fontSize: 65,
          // fontWeight: FontWeight.w200,
          // color: ViewController.to.theme.bgImageTextColor,
          color: Colors.white60,
        ).paddingSymmetric(vertical: 5),
        Column(
          children: [
            sizedBox10High,
            MyTextWidget(
              text: deg,
              fontSize: 40,
              color: ViewController.to.theme.bgImageTextColor,
            ),
          ],
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.tempUnitString,
          fontSize: 18,
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
          fontSize: 17,
          color: ViewController.to.theme.bgImageParamColor,
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.feelsLike.toString(),
          fontSize: 17,
          color: ViewController.to.theme.paramValueColor,
        ),
        MyTextWidget(
          text: deg,
          fontSize: 20,
          color: ViewController.to.theme.conditionColor,
        ),
      ],
    );
  }
}

class MyRichTextWidget extends StatelessWidget {
  final String text1, text2;
  final Color text1Color, text2Color;
  final double text1FontSize, text2FontSize;
  final FontWeight? text1FontWeight, text2FontWeight;

  const MyRichTextWidget(
      {required this.text1,
      required this.text2,
      required this.text1Color,
      required this.text2Color,
      required this.text1FontSize,
      required this.text2FontSize,
      this.text1FontWeight,
      this.text2FontWeight});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
            color: text1Color,
            fontWeight: text1FontWeight ?? FontWeight.normal,
            decoration: TextDecoration.underline),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
                color: text2Color,
                fontWeight: text2FontWeight ?? FontWeight.normal,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
