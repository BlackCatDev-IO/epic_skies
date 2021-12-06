import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/settings/settings.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:flutter/material.dart';
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
      child: GetBuilder<ColorController>(
        builder: (controller) => RoundedContainer(
          color: controller.theme.soloCardColor,
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
                deg: degreeSymbol,
                condition: displayCondition,
                iconPath: model.iconPath,
                temp: model.dailyTemp,
              ),
              const Divider(color: Colors.white, indent: 10, endIndent: 10),
              _DetailRow(
                category: 'Feels Like: ',
                value: model.feelsLikeDay.toString(),
              ),
              _DetailRow(
                category: 'Wind Speed: ',
                value: '${model.windSpeed} ${model.speedUnit}',
              ),
              _DetailRow(
                category: 'Precipitation: ${model.precipitationType}',
                value: '${model.precipitationProbability}%',
              ),
              _DetailRow(
                category: 'Total Precip: ',
                value: '${model.precipitationAmount} ${model.precipUnit}',
              ),
              _DetailRow(
                category: 'Sunrise: ',
                value: model.sunTime.sunriseString,
              ),
              _DetailRow(
                category: 'Sunset: ',
                value: model.sunTime.sunsetString,
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
        ),
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

  const _DetailRow({required this.category, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextWidget(text: category, fontSize: 11.sp),
            MyTextWidget(text: value, fontSize: 11.sp, color: Colors.blue[200]),
          ],
        ).paddingSymmetric(horizontal: 15),
        const Divider(color: Colors.white, indent: 10, endIndent: 10),
      ],
    );
  }
}

class _DetailWidgetHeaderRow extends StatelessWidget {
  final String deg, condition, iconPath;

  final int temp;

  const _DetailWidgetHeaderRow({
    required this.deg,
    required this.condition,
    required this.iconPath,
    required this.temp,
  });
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
          child: _TempDisplayWidget(
            temp: '  $temp',
            deg: deg,
            degFontSize: 22.sp,
            tempFontsize: 20.sp,
            unitFontsize: 20,
            unitPadding: 10,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class _TempDisplayWidget extends StatelessWidget {
  const _TempDisplayWidget({
    required this.temp,
    required this.deg,
    required this.tempFontsize,
    required this.unitFontsize,
    required this.unitPadding,
    required this.degFontSize,
  });

  final String temp, deg;
  final double? tempFontsize, unitFontsize, unitPadding, degFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextWidget(text: temp, fontSize: tempFontsize),
        const SizedBox(width: 1),
        MyTextWidget(
          text: deg,
          fontSize: degFontSize,
        ),
        const SizedBox(width: 1),
        GetBuilder<CurrentWeatherController>(
          builder: (controller) => MyTextWidget(
            text: Settings.tempUnitsCelcius ? 'C' : 'F',
            fontSize: unitFontsize,
          ),
        ).paddingOnly(
          bottom: unitPadding!,
        ),
      ],
    );
  }
}
