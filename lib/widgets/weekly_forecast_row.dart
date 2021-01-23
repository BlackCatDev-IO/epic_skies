import 'package:epic_skies/screens/hourly_forecast_page.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class WeeklyForecastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HourlyForecastPage());
      },
      child: forecastRowWidget(),
    );
  }

  Widget forecastRowWidget() {
    return Card(
      color: Colors.black54,
      elevation: 10,
      child: RoundedContainer(
        height: screenHeight * .22,
        child: GetX<ForecastController>(
          builder: (controller) {
            if (controller.dayColumnList == null) {
              Get.snackbar('Null list', "you're fucked");
              throw 'Null dayColumnList';
            }
            return Row(children: controller.dayColumnList);

            // [
            //   dayColumn(
            //       day: today,
            //       temp: weatherController.currentTemp.toString(),
            //       iconPath: weatherController.currentIconUrl),
            //   dayColumn(
            //       day: today + 1,
            //       temp: weatherController.tomorrowTemp.toString(),
            //       iconPath: weatherController.tomorrowIconUrl),
            //   dayColumn(
            //       day: today + 2,
            //       temp: weatherController.twoDaysTemp.toString(),
            //       iconPath: weatherController.twoDaysIconUrl),
            //   dayColumn(
            //       day: today + 3,
            //       temp: weatherController.threeDaysTemp.toString(),
            //       iconPath: weatherController.threeDaysIconUrl),
            //   dayColumn(
            //       day: today + 4,
            //       temp: weatherController.fourDaysTemp.toString(),
            //       iconPath: weatherController.fourDaysIconUrl),
            //   dayColumn(
            //       day: today + 5,
            //       temp: weatherController.fiveDaysTemp.toString(),
            //       iconPath: weatherController.fiveDaysIconUrl),
            //   dayColumn(
            //       day: today + 6,
            //       temp: weatherController.sixDaysTemp.toString(),
            //       iconPath: weatherController.sixDaysIconUrl),
            // ],
            // );
          },
        ).paddingSymmetric(vertical: 10),
      ).paddingOnly(top: 10),
    );
  }
//   Widget dayColumn({int day, String temp, String iconPath}) {
//     final weatherController = Get.find<WeatherController>();
//     return Expanded(
//       child: Column(
//         children: [
//           days(weatherController.getNext7Days(day)),
//           temps(temp),
//           Image(
//             width: 40,
//             image: AssetImage(
//                 iconPath ?? 'assets/icons/vclouds_icons/moon_with_cloud.png'),
//             color: null,
//             // color: Colors.black,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget days(String day) => Expanded(
//         child: Text(
//           day,
//           style: kGoogleFontOpenSansCondensed.copyWith(fontSize: 18),
//         ),
//       );

//   Widget temps(String temp) {
//     return Expanded(
//       child: Text(
//         temp,
//         style: kGoogleFontOpenSansCondensed.copyWith(fontSize: 18),
//       ),
//     );
//   }
// }
}

class DayColumn extends StatelessWidget {
  final String day;
  final String temp;
  final String iconPath;

  const DayColumn({Key key, this.day, this.temp, this.iconPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextWidget(
          text: day,
          fontSize: 16,
          color: Colors.blueGrey[400],
        ).expanded(),
        MyTextWidget(text: temp).expanded(),
        Image(
          width: 40,
          image: AssetImage(
              iconPath ?? 'assets/icons/vclouds_icons/moon_with_cloud.png'),
          // color: null,
          // color: Colors.black,
        ).expanded(),
      ],
    ).expanded();
  }
}
