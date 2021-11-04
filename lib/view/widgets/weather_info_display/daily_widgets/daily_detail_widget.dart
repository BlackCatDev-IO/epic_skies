import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:epic_skies/services/weather_forecast/hourly_forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../hourly_widgets/horizontal_scroll_widget.dart';

class DailyDetailWidget extends StatelessWidget {
  final int tempDay, feelsLikeDay, precipitationCode, index;
  final int highTemp, lowTemp;
  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;
  final String condition;
  final String tempUnit;
  final String speedUnit;
  final String precipitationType;
  final String? extendedHourlyForecastKey;
  final SunTimesModel sunTime;

  final num precipitationAmount, windSpeed, precipitationProbability;

  const DailyDetailWidget({
    required this.iconPath,
    required this.tempDay,
    required this.feelsLikeDay,
    required this.precipitationProbability,
    required this.condition,
    required this.sunTime,
    required this.day,
    required this.precipitationType,
    required this.precipitationCode,
    required this.month,
    required this.year,
    required this.date,
    required this.tempUnit,
    required this.precipitationAmount,
    required this.speedUnit,
    required this.windSpeed,
    required this.index,
    required this.highTemp,
    required this.lowTemp,
    required this.extendedHourlyForecastKey,
  });

  @override
  Widget build(BuildContext context) {
    final displayCondition = condition.capitalizeFirst!;
    final precipUnitString = StorageController.to.precipUnitString();

    /// fullDetail is for a the extended hourly forecast. There is only 108
    /// available hours so this prevents the widget from trying to build
    /// the _ExtendedHourlyForecastRow when no data is available
    final fullDetail = extendedHourlyForecastKey != null;

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
              _DateLabel(day: day, month: month, date: date, year: year),
              _DetailWidgetHeaderRow(
                deg: degreeSymbol,
                condition: displayCondition,
                iconPath: iconPath,
                temp: tempDay,
              ),
              const Divider(color: Colors.white, indent: 10, endIndent: 10),
              _DetailRow(
                category: 'Feels Like: ',
                value: feelsLikeDay.toString(),
              ),
              _DetailRow(
                category: 'Wind Speed: ',
                value: '$windSpeed $speedUnit',
              ),
              _DetailRow(
                category: 'Precipitation: $precipitationType',
                value: '$precipitationProbability%',
              ),
              _DetailRow(
                category: 'Total Precip: ',
                value: '$precipitationAmount $precipUnitString',
              ),
              _DetailRow(category: 'Sunrise: ', value: sunTime.sunriseString),
              _DetailRow(category: 'Sunset: ', value: sunTime.sunsetString),
              if (fullDetail)
                _ExtendedHourlyForecastRow(
                  hourlyKey: extendedHourlyForecastKey!,
                  highTemp: highTemp,
                  lowTemp: lowTemp,
                  tempUnit: tempUnit,
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
        HorizontalScrollWidget(
          list: HourlyForecastController
              .to.hourlyForecastHorizontalScrollWidgetMap[hourlyKey]!,
          layeredCard: true,
          header: const HourlyHeader(),
        ).paddingSymmetric(horizontal: 2.5, vertical: 10)
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
            text: controller.tempUnitString,
            fontSize: unitFontsize,
          ),
        ).paddingOnly(
          bottom: unitPadding!,
        ),
      ],
    );
  }
}
