import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:charcode/charcode.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HourlyForecastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: forecastRowWidget(),
    );
  }

  final ScrollController _scrollController = ScrollController();
  Widget forecastRowWidget() {
    return GestureDetector(
      onTap: () {},
      child: MyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedContainer(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTextWidget(
                    text: 'Next 24 Hours',
                    color: Colors.white54,
                    fontSize: 16,
                    spacing: 5,
                  )
                ],
              ),
            ),
            RoundedContainer(
                height: screenHeight * .22,
                child: GetX<ForecastController>(
                  builder: (controller) {
                    return Scrollbar(
                      controller: _scrollController,
                      thickness: 3,
                      radius: const Radius.circular(40),
                      isAlwaysShown: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.hourColumns.length,
                        itemBuilder: (context, index) {
                          return controller.hourColumns[index];
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
      ).paddingSymmetric(vertical: 10),
    );
  }
}

class HourColumn extends StatelessWidget {
  final String temp;
  final String time;
  final String precipitation;
  final String iconPath;

  const HourColumn(
      {Key key, this.temp, this.time, this.precipitation, this.iconPath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // debugPrint('Hour Column build @ time: $time');
    final deg = String.fromCharCode($deg);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyTextWidget(
            text: time,
            fontSize: 16,
            color: Colors.blueGrey[400],
          ),
          // TempWidget(temp.toString()),
          Row(
            children: [
              MyTextWidget(
                text: temp,
                fontSize: 20,
                color: Colors.white70,
              ),
              MyTextWidget(
                text: deg,
                fontSize: 18,
                color: Colors.white70,
              ),
            ],
          ),
          Image(
            width: 40,
            image: AssetImage(
                iconPath ?? 'assets/icons/vclouds_icons/clear_day.png'),
            // color: Colors.black,
          ),
          MyTextWidget(
            text: ' $precipitation%',
            fontSize: 16,
            color: Colors.white54,
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}

class HourlyDetailedRow extends StatelessWidget {
  final String iconPath, time, temp, feelsLike, precipitation, condition;

  const HourlyDetailedRow(
      {Key key,
      this.temp,
      this.feelsLike,
      this.precipitation,
      this.iconPath,
      this.time,
      this.condition})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deg = String.fromCharCode($deg);
    String displayCondition = condition.capitalizeFirst;

    return MyCard(
      radius: 9,
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextWidget(text: time.toString() ?? 'fah Q', fontSize: 15)
                    .paddingSymmetric(vertical: 5),
                MyAssetImage(
                  height: 50,
                  path: iconPath,
                ),
                TempDisplayWidget(temp: temp, deg: deg),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyTextWidget(text: displayCondition),
                MyTextWidget(text: 'Feels like: $feelsLike'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTextWidget(
                  text: 'Precipitation',
                  fontSize: 15,
                ),
                MyTextWidget(
                    text: precipitation != null ? '$precipitation %' : 'fah Q'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TempDisplayWidget extends StatelessWidget {
  const TempDisplayWidget({
    @required this.temp,
    @required this.deg,
    this.fontsize,
  });

  final String temp;
  final String deg;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyTextWidget(text: temp ?? 'fah Q', fontSize: fontsize ?? 25),
        MyTextWidget(
          text: deg,
          fontSize: fontsize ?? 25,
        ),
      ],
    );
  }
}
