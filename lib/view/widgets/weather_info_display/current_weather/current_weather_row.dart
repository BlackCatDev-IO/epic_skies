import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/location/location_controller.dart';
import 'package:epic_skies/services/location/remote_location_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CurrentWeatherRow extends StatelessWidget {
  const CurrentWeatherRow();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (controller) => RoundedContainer(
        color: controller.theme.homeContainerColor,
        height: 26.h,
        child: GetBuilder<WeatherRepository>(
          builder: (weatherRepoController) => Stack(
            children: [
              const _TempColumn(),
              if (weatherRepoController.searchIsLocal)
                const _AddressColumn()
              else
                const _RemoteLocationColumn(),
            ],
          ).paddingSymmetric(vertical: 5),
        ),
      ),
    ).paddingSymmetric(horizontal: 2);
  }
}

class _AddressColumn extends StatelessWidget {
  const _AddressColumn();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 24.h,
      right: 5,
      child: GetBuilder<LocationController>(
        builder: (locationController) {
          return GetBuilder<ColorController>(
            builder: (colorController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextWidget(
                    text: locationController.data.street,
                    fontSize: 13.sp,
                    color: colorController.theme.bgImageTextColor,
                  ).paddingOnly(left: 10),
                  if (locationController.data.longNameList != null)
                    const _MultiWordCityWidget()
                  else
                    MyTextWidget(
                      text: locationController.data.subLocality,
                      fontSize: locationController.data.subLocality.length > 10
                          ? 22.sp
                          : 28.sp,
                      fontWeight: FontWeight.w400,
                      color: colorController.theme.bgImageTextColor,
                    ).paddingSymmetric(horizontal: 10),
                  MyTextWidget(
                    text: locationController.data.administrativeArea,
                    fontSize: 15.sp,
                    color: colorController.theme.bgImageTextColor,
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

class _RemoteLocationColumn extends StatelessWidget {
  const _RemoteLocationColumn();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RemoteLocationController>(
      builder: (locationController) {
        final longCityName = locationController.data.city.length > 10;

        return Positioned(
          height: 24.h,
          right: longCityName ? 0 : 5,
          child: GetBuilder<ColorController>(
            builder: (colorController) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (locationController.data.longNameList != null)
                  const _MultiWordCityWidget()
                else
                  MyTextWidget(
                    text: locationController.data.city,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    color: colorController.theme.bgImageTextColor,
                  ).paddingOnly(right: 5),
                sizedBox5High,
                Row(
                  children: [
                    if (locationController.data.state == '')
                      const SizedBox()
                    else
                      MyTextWidget(
                        text: '${locationController.data.state}, ',
                        fontSize: 15.sp,
                        color: colorController.theme.bgImageTextColor,
                      ),
                    MyTextWidget(
                      text: '${locationController.data.country} ',
                      fontSize: 15.sp,
                      color: colorController.theme.bgImageTextColor,
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

class _MultiWordCityWidget extends StatelessWidget {
  const _MultiWordCityWidget();

  @override
  Widget build(BuildContext context) {
    List wordList = [];
    final searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      wordList = LocationController.to.data.longNameList!;
    } else {
      wordList = RemoteLocationController.to.data.longNameList!;
    }
    return GetBuilder<ColorController>(
      builder: (colorController) {
        return Column(
          children: [
            Column(
              children: [
                for (final word in wordList)
                  MyTextWidget(
                    text: word as String,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w400,
                    color: colorController.theme.bgImageTextColor,
                  ).paddingOnly(right: 5, bottom: 5),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TempColumn extends StatelessWidget {
  const _TempColumn();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentWeatherController>(
      builder: (weatherController) => GetBuilder<ColorController>(
        builder: (colorController) {
          // just to add more fontweight for when the text in contrast to earthFromSpace image
          final fontWeight = colorController.heavyFont ? FontWeight.w500 : null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sizedBox10High,
              _MainCurrentTempWidget(),
              MyTextWidget(
                text: weatherController.condition,
                fontSize: 14.sp,
                fontWeight: fontWeight,
                color: colorController.theme.conditionColor,
              ),
              _FeelsLikeRow(),
              Row(
                children: [
                  MyTextWidget(
                    text: 'Wind Speed: ',
                    fontSize: 12.sp,
                    fontWeight: fontWeight,
                    color: colorController.theme.bgImageParamColor,
                  ),
                  MyTextWidget(
                    text:
                        '${weatherController.windSpeed} ${weatherController.speedUnitString}',
                    fontSize: 12.sp,
                    fontWeight: fontWeight,
                    color: colorController.theme.paramValueColor,
                  ),
                ],
              ),
              sizedBox5High
            ],
          );
        },
      ),
    ).paddingOnly(left: 10, bottom: 5);
  }
}

class _MainCurrentTempWidget extends GetView<CurrentWeatherController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextWidget(
          text: controller.temp.toString(),
          fontSize: 45.sp,
          fontWeight: FontWeight.bold,
          color: ColorController.to.theme.bgImageTextColor,
        ).paddingSymmetric(vertical: 5),
        Column(
          children: [
            sizedBox10High,
            MyTextWidget(
              text: degreeSymbol,
              fontSize: 30.sp,
              color: ColorController.to.theme.bgImageTextColor,
            ),
          ],
        ),
        MyTextWidget(
          text: controller.tempUnitString,
          textStyle: TextStyle(
            height: 0.9,
            fontSize: 14.sp,
            color: ColorController.to.theme.bgImageTextColor,
          ),
        ).paddingOnly(top: 20, left: 2.5),
      ],
    );
  }
}

class _FeelsLikeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontWeight = ColorController.to.heavyFont ? FontWeight.w500 : null;
    return Row(
      children: [
        MyTextWidget(
          text: 'Feels Like: ',
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: ColorController.to.theme.bgImageParamColor,
        ),
        MyTextWidget(
          text: CurrentWeatherController.to.feelsLike.toString(),
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: ColorController.to.theme.paramValueColor,
        ),
        MyTextWidget(
          text: degreeSymbol,
          fontSize: 12.sp,
          fontWeight: fontWeight,
          color: ColorController.to.theme.conditionColor,
        ),
      ],
    );
  }
}
