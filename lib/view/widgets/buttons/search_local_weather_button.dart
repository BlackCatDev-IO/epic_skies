import 'package:black_cat_lib/black_cat_lib.dart';
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
  const SearchLocalWeatherButton({
    required this.isSearchPage,
    required this.weatherRepository,
  });
  final WeatherRepository weatherRepository;

  @override
  Widget build(BuildContext context) {
    final iconPath = IconController.getIconImagePath(
      temp: weatherRepository.storage.restoreCurrentLocalTemp(),
      condition: weatherRepository.storage.restoreCurrentLocalCondition(),
      isDay: weatherRepository.storage.restoreLocalIsDay(),
      tempUnitsMetric:
          weatherRepository.storage.savedUnitSettings().tempUnitsMetric,
    );
    return GestureDetector(
      onTap: () {
        controller.navigateToHome();
        weatherRepository.fetchLocalWeatherData();
      },
      child: GetBuilder<ColorController>(
        builder: (colorController) => Container(
          color:
              isSearchPage ? Colors.black54 : colorController.theme.appBarColor,
          height: 65.sp,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _TempWidget(
                temp: weatherRepository.storage.restoreCurrentLocalTemp(),
              ),
              const _LocationWidget(),
              _ConditionIcon(iconPath: iconPath),
            ],
          ),
        ),
      ),
    );
  }
}

class _TempWidget extends StatelessWidget {
  const _TempWidget({required this.temp});
  final int temp;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentWeatherController>(
      builder: (controller) {
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
                  fontWeight: FontWeight.w500,
                ),
                MyTextWidget(
                  text: controller.data!.administrativeArea,
                  fontSize: 10.sp,
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

class _ConditionIcon extends StatelessWidget {
  const _ConditionIcon({required this.iconPath});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 3.sp,
      child: GetBuilder<CurrentWeatherController>(
        builder: (controller) {
          return MyAssetImage(
            height: 5.h,
            path: iconPath,
          );
        },
      ),
    );
  }
}
