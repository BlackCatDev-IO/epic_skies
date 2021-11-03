import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/models/sun_time_model.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../hourly_widgets/horizontal_scroll_widget.dart';
import '../temp_display_widget.dart';

class DailyDetailWidget extends StatelessWidget {
  final int tempDay, feelsLikeDay, precipitationCode, index;

  final int? highTemp, lowTemp;

  final String iconPath;
  final String day;
  final String month;
  final String year;
  final String date;

  final SunTimesModel sunTime;
  final String condition;
  final String tempUnit;
  final String speedUnit;
  final String precipitationType;

  final num precipitationAmount, windSpeed, precipitationProbability;

  final List? list;

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
    required this.list,
    required this.index,
    this.highTemp,
    this.lowTemp,
  });

  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    final displayCondition = condition.capitalizeFirst!;
    final precipUnitString = StorageController.to.precipUnitString();

    /// fullDetail is for a different build for periods after the next 108 available hourly temps
    final fullDetail = list != null;

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
              DateLabel(day: day, month: month, date: date, year: year),
              DetailWidgetHeaderRow(
                deg: deg,
                condition: displayCondition,
                iconPath: iconPath,
                temp: tempDay,
              ),
              const Divider(color: Colors.white, indent: 10, endIndent: 10),
              DetailRow(
                category: 'Feels Like: ',
                value: feelsLikeDay.toString(),
              ),
              DetailRow(
                category: 'Wind Speed: ',
                value: '$windSpeed $speedUnit',
              ),
              DetailRow(
                category: 'Precipitation: $precipitationType',
                value: '$precipitationProbability%',
              ),
              DetailRow(
                category: 'Total Precip: ',
                value: '$precipitationAmount $precipUnitString',
              ),
              DetailRow(category: 'Sunrise: ', value: sunTime.sunriseString),
              DetailRow(category: 'Sunset: ', value: sunTime.sunsetString),
              if (fullDetail) detailColumn(deg) else const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailColumn(String deg) {
    return Column(
      children: [
        DetailRow(category: 'High Temp: ', value: '$highTemp$deg $tempUnit'),
        DetailRow(category: 'Low Temp: ', value: '$lowTemp$deg $tempUnit'),
        HorizontalScrollWidget(
          list: list!,
          layeredCard: true,
          header: const HourlyHeader(),
        ).paddingSymmetric(horizontal: 2.5, vertical: 10)
      ],
    );
  }
}

class DateLabel extends StatelessWidget {
  const DateLabel({
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

class DetailRow extends StatelessWidget {
  final String category, value;

  const DetailRow({required this.category, required this.value});
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

class DetailWidgetHeaderRow extends StatelessWidget {
  final String deg, condition, iconPath;

  final int temp;

  const DetailWidgetHeaderRow({
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
          child: TempDisplayWidget(
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
