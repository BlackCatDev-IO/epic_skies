import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/loading_status_controller/loading_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends GetView<LoadingStatusController> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              GetBuilder<LoadingStatusController>(
                builder: (_) {
                  return controller.statusString == ''
                      ? const SizedBox()
                      : RoundedContainer(
                          radius: 8,
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                          child: MyTextWidget(
                            text: controller.statusString,
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          )
                              .paddingSymmetric(
                                vertical: 15,
                                horizontal: 20,
                              )
                              .center(),
                        );
                },
              ),
              SizedBox(height: 4.h),
              const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ).center(),
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }
}
