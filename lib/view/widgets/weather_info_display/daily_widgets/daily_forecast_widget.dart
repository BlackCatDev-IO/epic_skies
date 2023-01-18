import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../hourly_widgets/horizontal_scroll_widget.dart';

class DailyForecastWidget extends StatelessWidget {
  final DailyForecastModel model;

  const DailyForecastWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    final displayCondition = model.condition.capitalizeFirst!;

    /// fullDetail is for a the extended hourly forecast. There is only 108
    /// available hours so this prevents the widget from trying to build
    /// the _ExtendedHourlyForecastRow when no data is available
    final fullDetail = model.extendedHourlyForecastKey != null;

    return MyCard(
      radius: 10,
      child: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          return RoundedContainer(
            color: state.theme.soloCardColor,
            height: fullDetail ? 84.h : 50.h,
            borderColor: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sizedBox10High,
                _DateLabel(
                  day: model.day,
                  month: model.month,
                  date: model.date,
                  year: model.year,
                ),
                _DetailWidgetHeaderRow(
                  condition: displayCondition,
                  iconPath: model.iconPath,
                  temp: model.dailyTemp,
                  tempUnit: model.tempUnit,
                ),
                const Divider(color: Colors.white, indent: 10, endIndent: 10),
                _DetailRow(
                  category: 'Feels Like: ',
                  value: '${model.feelsLikeDay}${model.tempUnit}',
                ),
                _DetailRow(
                  category: 'Wind Speed: ',
                  value: '${model.windSpeed} ${model.speedUnit}',
                ),
                _DetailRow(
                  category: 'Precipitation: ',
                  precipType: model.precipitationType,
                  value: '${model.precipitationProbability}%',
                  iconPath: model.precipIconPath,
                ),
                _DetailRow(
                  category: 'Total Precip: ',
                  value: '${model.precipitationAmount} ${model.precipUnit}',
                ),
                _DetailRow(
                  category: 'Sunrise: ',
                  value: model.suntime.sunriseString,
                ),
                _DetailRow(
                  category: 'Sunset: ',
                  value: model.suntime.sunsetString,
                ),
                if (fullDetail)
                  _ExtendedHourlyForecastRow(
                    hourlyKey: model.extendedHourlyForecastKey!,
                    highTemp: model.highTemp!,
                    lowTemp: model.lowTemp!,
                    tempUnit: model.tempUnit,
                  )
                else
                  const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExtendedHourlyForecastRow extends StatelessWidget {
  const _ExtendedHourlyForecastRow({
    required this.highTemp,
    required this.lowTemp,
    required this.tempUnit,
    required this.hourlyKey,
  });

  final int highTemp, lowTemp;
  final String tempUnit;
  final String hourlyKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DetailRow(
          category: 'High Temp: ',
          value: '$highTemp$degreeSymbol $tempUnit',
        ),
        _DetailRow(
          category: 'Low Temp: ',
          value: '$lowTemp$degreeSymbol $tempUnit',
        ),
        GetBuilder<HourlyForecastController>(
          builder: (hourlyController) {
            return HorizontalScrollWidget(
              list: hourlyController
                  .hourlyForecastHorizontalScrollWidgetMap[hourlyKey]!,
              layeredCard: true,
              header: const HourlyHeader(),
            ).paddingSymmetric(horizontal: 2.5, vertical: 10);
          },
        )
      ],
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    required this.day,
    required this.month,
    required this.date,
    required this.year,
  });

  final String day;
  final String month;
  final String date;
  final String year;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.blueGrey[300],
      child: MyTextWidget(
        text: '$day $month $date, $year',
        color: Colors.black,
        fontSize: 11.sp,
      ).paddingSymmetric(horizontal: 10),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String category, value;
  final String? iconPath;
  final String? precipType;

  const _DetailRow({
    required this.category,
    required this.value,
    this.iconPath,
    this.precipType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (precipType != null)
              Row(
                children: [
                  MyTextWidget(text: category, fontSize: 11.sp),
                  MyTextWidget(
                    text: precipType!,
                    fontSize: 11.sp,
                    color: Colors.blue[300],
                  ),
                ],
              )
            else
              MyTextWidget(text: category, fontSize: 11.sp),
            if (iconPath != null)
              Row(
                children: [
                  MyAssetImage(path: iconPath!, width: 3.7.w, height: 3.7.w),
                  MyTextWidget(
                    text: value,
                    fontSize: 11.sp,
                    color: Colors.blue[200],
                  ).paddingOnly(left: 5),
                ],
              )
            else
              MyTextWidget(
                text: value,
                fontSize: 11.sp,
                color: Colors.blue[200],
              ),
          ],
        ).paddingSymmetric(horizontal: 15),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}

class _DetailWidgetHeaderRow extends StatelessWidget {
  const _DetailWidgetHeaderRow({
    required this.condition,
    required this.iconPath,
    required this.temp,
    required this.tempUnit,
  });

  final String condition;
  final String tempUnit;
  final String iconPath;

  final int temp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2.5.h,
          left: 5,
          child: MyTextWidget(text: condition, fontSize: 14.sp),
        ),
        Align(
          child: MyAssetImage(
            height: 10.h,
            path: iconPath,
          ),
        ),
        Positioned(
          top: 2.h,
          right: 5,
          child: _TempDisplayWidget(temp: '  $temp', tempUnit: tempUnit),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class _TempDisplayWidget extends StatelessWidget {
  const _TempDisplayWidget({required this.temp, required this.tempUnit});

  final String temp, tempUnit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: temp, fontSize: 20.sp),
        const SizedBox(width: 1),
        MyTextWidget(
          text: degreeSymbol,
          fontSize: 22.sp,
        ),
        const SizedBox(width: 1),
        MyTextWidget(
          text: tempUnit,
          fontSize: 20,
        ).paddingOnly(
          bottom: 10,
        ),
      ],
    );
  }
}
