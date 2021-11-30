import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/location/location_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchLocalWeatherButton extends GetView<DrawerAnimationController> {
  const SearchLocalWeatherButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.navigateToHome();
        WeatherRepository.to.fetchLocalWeatherData();
      },
      child: GetBuilder<ColorController>(
        builder: (colorController) => RoundedContainer(
          color: colorController.theme.soloCardColor,
          radius: 8,
          height: 50.sp,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: const [
              _TempWidget(),
              _LocationWidget(),
              _ContidionIcon(),
            ],
          ),
        ),
      ),
    ).paddingSymmetric(vertical: 8);
  }
}

class _TempWidget extends StatelessWidget {
  const _TempWidget();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentWeatherController>(
      builder: (controller) {
        final temp = StorageController.to.restoreCurrentLocalTemp();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextWidget(
                  text: temp.toString(),
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorController.to.theme.bgImageTextColor,
                ),
                Column(
                  children: [
                    MyTextWidget(
                      text: degreeSymbol,
                      fontSize: 23.sp,
                      color: ColorController.to.theme.bgImageTextColor,
                    ),
                  ],
                ),
                MyTextWidget(
                  text: controller.data.tempUnit,
                  fontWeight: FontWeight.w400,
                  color: ColorController.to.theme.bgImageTextColor,
                ).paddingOnly(top: 3.sp),
              ],
            ).paddingOnly(left: 10),
          ],
        );
      },
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextWidget(
                  text: controller.data!.subLocality,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
                sizedBox5High,
                MyTextWidget(
                  text: controller.data!.administrativeArea,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ContidionIcon extends StatelessWidget {
  const _ContidionIcon();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 3.sp,
      child: GetBuilder<CurrentWeatherController>(
        builder: (controller) {
          final iconPath = IconController.getIconImagePath(
            temp: StorageController.to.restoreCurrentLocalTemp(),
            condition: StorageController.to.restoreCurrentLocalCondition(),
            isDayForCurrentLocationButton:
                StorageController.to.restoreLocalIsDay(),
          );
          return MyAssetImage(
            height: 5.h,
            path: iconPath,
          );
        },
      ),
    );
  }
}
