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
              fontSize: 18,
              color: viewController.bgImageTextColor,
              fontWeight: FontWeight.w200,
              // fontFamily: 'OpenSans',
            ),
            MyTextWidget(
              text: locationController.subLocality,
              fontSize: 40,
              fontWeight: FontWeight.w200,
              color: viewController.bgImageTextColor,
              // fontFamily: 'OpenSans',
            ).paddingSymmetric(horizontal: 10),
            MyTextWidget(
              text: locationController.administrativeArea,
              fontSize: 20,
              fontWeight: FontWeight.w200,

              color: viewController.bgImageTextColor,
              // fontFamily: 'OpenSans',
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
      builder: (locationController) {
        return GetBuilder<ViewController>(
          builder: (viewController) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextWidget(
                text: locationController.searchCity,
                fontSize: 50,
                color: viewController.bgImageTextColor,
                fontFamily: 'OpenSans',
              ).paddingOnly(right: 5),
              Row(
                children: [
                  if (locationController.searchState == '')
                    const SizedBox()
                  else
                    MyTextWidget(
                        text: '${locationController.searchState}, ',
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        color: viewController.bgImageTextColor),
                  MyTextWidget(
                      text: '${locationController.searchCountry} ',
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

    return GetBuilder<CurrentWeatherController>(
      builder: (weatherController) => GetBuilder<ViewController>(
        builder: (viewController) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainCurrentTempWidget(),
            MyTextWidget(
              text: weatherController.condition,
              fontSize: 20,
              color: viewController.conditionColor,
            ),
            FeelsLikeRow(),
            Row(
              children: [
                MyTextWidget(
                  text: 'Wind Speed:',
                  fontSize: 17,
                  color: viewController.bgImageParamColor,
                ),
                MyTextWidget(
                  text:
                      '${weatherController.windSpeed} ${weatherController.speedUnitString}',
                  fontSize: 17,
                  color: viewController.paramValueColor,
                ),
                // MyTextWidget(
                //   text: ' ${weatherController.speedUnitString}',
                //   fontSize: 17,
                //   color: viewController.conditionColor,
                // ),
              ],
            ),
          ],
        ),
      ),
    ).paddingOnly(left: 10, bottom: 5).expanded();
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
          fontSize: 75,
          fontFamily: 'OpenSans',
          color: ViewController.to.bgImageTextColor,
        ),
        Column(
          children: [
            sizedBox10High,
            MyTextWidget(
              text: deg,
              fontSize: 40,
              fontFamily: 'OpenSans',
              color: ViewController.to.bgImageTextColor,
            ),
          ],
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.tempUnitString,
          fontSize: 20,
          fontFamily: 'OpenSans',
          color: ViewController.to.bgImageTextColor,
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
          color: ViewController.to.bgImageParamColor,
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.feelsLike.toString(),
          fontSize: 17,
          color: ViewController.to.paramValueColor,
        ),
        MyTextWidget(
          text: deg,
          fontSize: 20,
          color: ViewController.to.conditionColor,
        ),
      ],
    );
  }
}

class MyRichTextWidget extends StatelessWidget {
  final String text1, text2;
  final Color text1Color, text2Color;
  final double text1FontSize, text2FontSize;
  final FontWeight text1FontWeight, text2FontWeight;

  const MyRichTextWidget(
      {required this.text1,
      required this.text2,
      required this.text1Color,
      required this.text2Color,
      required this.text1FontSize,
      required this.text2FontSize,
      required this.text1FontWeight,
      required this.text2FontWeight});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
            color: text1Color,
            fontWeight: FontWeight.w800,
            decoration: TextDecoration.underline),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
                color: text2Color,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
