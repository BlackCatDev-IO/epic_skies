import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter/material.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';

class WelcomeScreen extends GetView<WeatherRepository> {
  static const id = '/location_refresh_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MyImageContainer(
          width: double.infinity,
          imagePath: earthFromSpace,
          child: Column(
            children: [
              const SizedBox(height: 65),
              MyTextWidget(
                  text: 'Epic Skies',
                  fontSize: 60,
                  color: Colors.blueGrey[400],
                  spacing: 4,
                  fontFamily: 'OpenSans'),
              SizedBox(height: screenHeight * 0.25),
              RoundedContainer(
                color: Colors.black54,
                width: double.maxFinite,
                child: const MyTextWidget(
                  text: 'Fetching your local weather data!',
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ).paddingSymmetric(vertical: 15, horizontal: 20).center(),
              ),
              const SizedBox(height: 30),
              const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white38,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              ),
              const SizedBox(height: 60),
            ],
          ).paddingSymmetric(horizontal: 15),
        ),
      ),
    );
  }
}
