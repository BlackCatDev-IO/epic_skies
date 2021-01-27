import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/widgets/default_textfield.dart';
import 'package:epic_skies/widgets/my_elevated_button.dart';
import 'package:epic_skies/widgets/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SearchPage extends StatelessWidget {
  static const id = 'search_page';
  final TextEditingController controller =
      Get.find<SearchController>().textController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WeatherImageContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultTextField(
                borderColor: Colors.black87,
                fillColor: Colors.white54,
                controller: controller,
                onChanged: (data) {
                  debugPrint(controller.text);
                },
              ).paddingSymmetric(vertical: 30),
              MyElevatedButton(
                onPressed: () {
                  Get.find<SearchController>().searchCityWeather();
                },
                color: Colors.black87,
                text: 'Fah Q',
              ).paddingOnly(bottom: 20),
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }
}
