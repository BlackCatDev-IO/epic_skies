import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchLocalWeatherButton extends GetView<DrawerAnimationController> {
  final bool isSearchPage;
  const SearchLocalWeatherButton({required this.isSearchPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.navigateToHome();
        WeatherRepository.to.fetchLocalWeatherData();
      },
      child: GetBuilder<ColorController>(
        builder: (colorController) => Container(
          color:
              isSearchPage ? Colors.black54 : colorController.theme.appBarColor,
          height: 65.sp,
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
    );
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          ],
        ).paddingOnly(left: 10);
      },
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<LocationController>(
          builder: (controller) {
            final fontSize =
                controller.data!.subLocality.length > 19 ? 12.5.sp : 13.sp;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextWidget(
                  text: controller.data!.subLocality,
                  fontSize: fontSize,
                  // fontWeight: FontWeight.w400,
                  fontWeight: FontWeight.w500,
                ),
                MyTextWidget(
                  text: controller.data!.administrativeArea,
                  fontSize: 10.sp,
                  // fontWeight: FontWeight.w300,
                  fontWeight: FontWeight.w400,
                ),
                sizedBox10High,
                const _CurrentLocationIndicator()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CurrentLocationIndicator extends StatelessWidget {
  const _CurrentLocationIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.near_me,
          color: Colors.blue[100],
          size: 12.sp,
        ).paddingOnly(top: 3),
        sizedBox5Wide,
        MyTextWidget(
          text: 'Your location',
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w500,
          color: Colors.blue,
        )
      ],
    ).paddingOnly(right: 4.w);
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
            tempUnitsMetric:
                StorageController.to.savedUnitSettings().tempUnitsMetric,
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
