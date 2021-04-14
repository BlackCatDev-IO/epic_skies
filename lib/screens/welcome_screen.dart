import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';

import '../global/local_constants.dart';

class WelcomeScreen extends GetView<WeatherRepository> {
  static const id = 'location_refresh_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MyImageContainer(
          imagePath: earthFromSpace,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyTextWidget(
                text: 'Epic Skies',
                fontSize: 57,
                color: Colors.blueGrey[500],
                spacing: 4,
              ).paddingSymmetric(vertical: 60),
              Expanded(
                child: _buildMainColumn(),
              )
            ],
          ).paddingSymmetric(horizontal: 15),
        ),
      ),
    );
  }

  Column _buildMainColumn() {
    return Column(
      children: [
        const SizedBox(height: 100),
        RoundedContainer(
          color: Colors.black45,
          width: double.maxFinite,
          child: const MyTextWidget(
            text: 'Fetching your local weather data!',
            fontSize: 25,
            color: Colors.white54,
          ).paddingSymmetric(vertical: 15, horizontal: 20).center(),
        ),
        // const SizedBox(height: 75),
        const Center(
          child: CircularProgressIndicator(
              backgroundColor: Colors.white38,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white38)),
        ).paddingOnly(top: 60),
      ],
    );
  }
}
