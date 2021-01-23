// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';
// import 'package:template/services/weather/weather_controller.dart';
// import 'package:template/widgets/weekly_forecast_row.dart';
//
// class WeeklyForecastController extends GetxController {
//   String todayTemp,
//       tomorrowTemp,
//       twoDaysTemp,
//       threeDaysTemp,
//       fourDaysTemp,
//       fiveDaysTemp,
//       sixDaysTemp;
//
//   final dayColumnList = List<Widget>().obs;
//
//   void _getTemps(String data) {
//     todayTemp = (jsonDecode(data)['daily'][0]['temp']['day']).round();
//     tomorrowTemp = (jsonDecode(data)['daily'][1]['temp']['day']).round();
//     twoDaysTemp = (jsonDecode(data)['daily'][2]['temp']['day']).round();
//     threeDaysTemp = (jsonDecode(data)['daily'][3]['temp']['day']).round();
//     fourDaysTemp = (jsonDecode(data)['daily'][4]['temp']['day']).round();
//     fiveDaysTemp = (jsonDecode(data)['daily'][5]['temp']['day']).round();
//     sixDaysTemp = (jsonDecode(data)['daily'][6]['temp']['day']).round();
//
//     update();
//   }
//
//   void buildWeekWidget(String data) {
//     dayColumnList.clear();
//
//     int today = DateTime.now().weekday;
//     for (int i = 0; i < 7; i++) {
//       String temp =
//           (jsonDecode(data)['daily'][i]['temp']['day']).round().toString();
//       String main = (jsonDecode(data)['daily'][i]['weather'][0]['main']);
//       String condition =
//           (jsonDecode(data)['daily'][i]['weather'][0]['description']);
//
//       String day = WeatherController().getNext7Days(today + i);
//       String iconPath =
//           WeatherController().getWeatherIcon(main: main, condition: condition);
//
//       final dayColumn = DayColumn(
//         day: day,
//         iconPath: iconPath,
//         temp: temp,
//       );
//
//       dayColumnList.add(dayColumn);
//     }
//   }
// }
