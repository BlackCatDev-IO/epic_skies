import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/widget_models/hourly_forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class HoulyForecastRow extends StatelessWidget {
  final HourlyForecastModel model;

  const HoulyForecastRow({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Row(
        children: [
          sizedBox10Wide,
          TimeWidget(time: model.time),
          sizedBox10Wide,
          TempColumn(
            temp: model.temp,
            feelsLike: '${model.feelsLike}$degreeSymbol',
            precip:
                '${model.precipitationProbability}% ${model.precipitationType}',
          ),
          sizedBox10Wide,

          MyAssetImage(path: model.iconPath, height: 5.h, width: 5.h),
          // sizedBox10Wide,
          ConditionAndWindWidget(
            condition: model.condition,
            windSpeed: '${model.windSpeed} ${model.speedUnit}',
            color: Colors.blueAccent[100]!,
          ),
          PrecipitationWidget(
            precipitationProbability: model.precipitationProbability,
            precipitationType: model.precipitationType,
            precipitationAmount: model.precipitationAmount,
            precipUnit: model.precipUnit,
          ),
          sizedBox10Wide
        ],
      ),
    );
  }
}


class PrecipitationWidget extends StatelessWidget {
  const PrecipitationWidget({
    required this.precipitationProbability,
    required this.precipitationType,
    required this.precipitationAmount,
    required this.precipUnit,
  });

  final num? precipitationProbability;
  final String precipitationType;
  final num? precipitationAmount;
  final String precipUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(
          text: '$precipitationProbability% $precipitationType',
          fontSize: 11.sp,
        ),
        if (precipitationAmount == 0)
          const SizedBox()
        else
          MyTextWidget(
            text: '$precipitationAmount$precipUnit',
            fontSize: 11.sp,
            color: HexColor('ffc288'),
          ),
      ],
    );
  }
}

class TempAndIconWidget extends StatelessWidget {
  const TempAndIconWidget({
    required this.temp,
    required this.iconPath,
  });

  final int temp;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyTextWidget(text: '$temp$degreeSymbol', fontSize: 14.sp),
          const Spacer(),
          MyAssetImage(path: iconPath, height: 10.h, width: 10.h),
        ],
      ),
    );
  }
}

class TempColumn extends StatelessWidget {
  final int temp;
  final String feelsLike, precip;
  const TempColumn({
    required this.temp,
    required this.feelsLike,
    required this.precip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: '$temp$degreeSymbol', fontSize: 12.sp),
        sizedBox10High,
        FeelsLikeWidget(temp: feelsLike, precip: precip),
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({required this.time});

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

class ConditionAndWindWidget extends StatelessWidget {
  final String condition, windSpeed;
  final Color color;

  const ConditionAndWindWidget({
    required this.condition,
    required this.windSpeed,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return HourlyDetailSpacer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextWidget(
            text: condition,
            color: Colors.blue[300],
            fontSize: 11.sp,
            textAlign: TextAlign.center,
          ),
          sizedBox5High,
          MyTextWidget(
            text: windSpeed,
            fontSize: 10.sp,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}

class HourlyDetailSpacer extends StatelessWidget {
  final Widget child;

  const HourlyDetailSpacer({required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5.w,
      child: child.center(),
    ).expanded();
  }
}

class FeelsLikeWidget extends StatelessWidget {
  final String temp, precip;

  const FeelsLikeWidget({required this.temp, required this.precip});
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
