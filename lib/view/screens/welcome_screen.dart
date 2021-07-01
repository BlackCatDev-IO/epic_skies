import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/notch_dependent_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends GetView<WeatherRepository> {
  static const id = '/location_refresh_screen';
  const WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return NotchDependentSafeArea(
      child: Scaffold(
        body: MyImageContainer(
          width: double.infinity,
          imagePath: earthFromSpace,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextWidget(
                      text: 'Epic ',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontFamily: 'Montserrat'),
                  MyTextWidget(
                      text: 'Skies',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w100,
                      color: Colors.white70,
                      fontFamily: 'Montserrat'),
                ],
              ),
              SizedBox(height: ViewController.to.screenHeight * 0.25),
              RoundedContainer(
                color: Colors.black54,
                width: double.maxFinite,
                child: MyTextWidget(
                  text: 'Fetching your local weather data!',
                  fontSize: 15.sp,
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
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }
}

