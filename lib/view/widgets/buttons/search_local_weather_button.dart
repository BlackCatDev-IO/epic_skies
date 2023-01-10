import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../features/current_weather_forecast/cubit/current_weather_cubit.dart';
import '../../../features/location/remote_location/bloc/location_bloc.dart';
import '../../../services/ticker_controllers/tab_navigation_controller.dart';

class SearchLocalWeatherButton extends GetView<TabNavigationController> {
  const SearchLocalWeatherButton({
    required this.isSearchPage,
  });

  final bool isSearchPage;

  @override
  Widget build(BuildContext context) {
    final buttonModel = context.read<WeatherBloc>().state.searchButtonModel;
    final iconPath = IconController.getIconImagePath(
      temp: buttonModel.temp,
      condition: buttonModel.condition,
      isDay: buttonModel.isDay,
      tempUnitsMetric: buttonModel.tempUnitsMetric,
    );
    return GestureDetector(
      onTap: () {
        controller.navigateToHome();
        context.read<LocationBloc>().add(LocationUpdateLocal());
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
                temp: buttonModel.temp,
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
    return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
      builder: (context, state) {
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
                  text: state.data!.tempUnit,
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
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            final fontSize =
                state.data.subLocality.length > 19 ? 12.5.sp : 13.sp;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.data.longNameList != null)
                  _LongNameWidget(
                    longNameList: state.data.longNameList!,
                  )
                else
                  MyTextWidget(
                    text: state.data.subLocality,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                MyTextWidget(
                  text: state.data.administrativeArea,
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

class _LongNameWidget extends StatelessWidget {
  const _LongNameWidget({Key? key, required this.longNameList})
      : super(key: key);
  final List<String> longNameList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          longNameList.map((word) => MyTextWidget(text: '$word ')).toList(),
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
      child: MyAssetImage(
        height: 5.h,
        path: iconPath,
      ),
    );
  }
}
