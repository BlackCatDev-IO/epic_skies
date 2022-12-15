import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/view_controllers/color_controller.dart';

class HoulyForecastRow extends StatelessWidget {
  final HourlyForecastModel model;

  const HoulyForecastRow({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
      builder: (colorController) => Container(
        color: colorController.theme.soloCardColor,
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TimeWidget(time: model.time),
            _TempColumn(
              temp: model.temp,
              feelsLike: '${model.feelsLike}$degreeSymbol',
              precip:
                  '${model.precipitationProbability}% ${model.precipitationType}',
            ),
            MyAssetImage(path: model.iconPath, height: 4.5.h, width: 4.5.h)
                .paddingOnly(right: 5),
            _ConditionAndWindWidget(
              condition: model.condition,
              windSpeed: '${model.windSpeed} ${model.speedUnit}',
              precipitationProbability: model.precipitationProbability,
            ),
            _PrecipitationWidget(
              precipitationProbability: model.precipitationProbability,
              precipitationType: model.precipitationType,
            ),
          ],
        ).paddingSymmetric(horizontal: 3.w),
      ),
    );
  }
}

class _TimeWidget extends StatelessWidget {
  const _TimeWidget({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 13.w,
      height: 2.5.h,
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: time,
        color: Colors.black,
        fontSize: 8.5.sp,
        fontWeight: FontWeight.w400,
      ).center(),
    ).paddingOnly(right: 2.w);
  }
}

class _FeelsLikeWidget extends StatelessWidget {
  final String temp, precip;

  const _FeelsLikeWidget({required this.temp, required this.precip});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 11.sp,
          color: HexColor('ffc288'),
          fontWeight: FontWeight.w300,
        ),
        text: 'Feels Like ',
        children: [
          TextSpan(
            text: temp,
            style: TextStyle(fontSize: 11.sp, color: Colors.white70),
          )
        ],
      ),
    );
  }
}

class _TempColumn extends StatelessWidget {
  final int temp;
  final String feelsLike, precip;
  const _TempColumn({
    required this.temp,
    required this.feelsLike,
    required this.precip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(text: '$temp$degreeSymbol', fontSize: 12.sp),
          sizedBox10High,
          _FeelsLikeWidget(temp: feelsLike, precip: precip),
        ],
      ),
    );
  }
}

class _ConditionAndWindWidget extends StatelessWidget {
  final String condition, windSpeed;

  final num precipitationProbability;

  const _ConditionAndWindWidget({
    required this.condition,
    required this.windSpeed,
    required this.precipitationProbability,
  });
  @override
  Widget build(BuildContext context) {
    final double leftPadding = precipitationProbability <= 9 ? 5 : 0;
    return SizedBox(
      width: 14.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final word in condition.splitWordList())
            MyTextWidget(
              text: word,
              color: Colors.blue[300],
              fontSize: 10.sp,
              textAlign: TextAlign.center,
            ),
          sizedBox10High,
          MyTextWidget(
            text: windSpeed,
            fontSize: 10.sp,
            fontWeight: FontWeight.w300,
          ),
        ],
      ).paddingOnly(left: leftPadding),
    );
  }
}

class _PrecipitationWidget extends StatelessWidget {
  const _PrecipitationWidget({
    required this.precipitationProbability,
    required this.precipitationType,
  });

  final num? precipitationProbability;
  final String precipitationType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: precipitationProbability == 100 ? 9.w : 7.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
            text: '$precipitationProbability%',
            fontSize: 10.sp,
          ),
          if (precipitationProbability == 0)
            const SizedBox()
          else
            MyAssetImage(
              path: IconController.getPrecipIconPath(
                precipType: precipitationType,
              ),
              height: 1.75.h,
              width: 1.75.h,
            ).paddingOnly(top: 10),
        ],
      ),
    );
  }
}
