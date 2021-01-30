// import 'dart:convert';
// import 'dart:io';

// import 'package:epic_skies/services/utils/network.dart';
// import 'package:epic_skies/services/utils/search_controller.dart';
// import 'package:epic_skies/widgets/default_textfield.dart';
// import 'package:epic_skies/widgets/my_elevated_button.dart';
// import 'package:epic_skies/widgets/weather_image_container.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:black_cat_lib/black_cat_lib.dart';
// import 'package:http/http.dart';
// import 'package:uuid/uuid.dart';

// class SearchPage extends StatefulWidget {
//   static const id = 'search_page';

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController controller =
//       Get.find<SearchController>().textController;

//   final apiClient = NetworkController();

//   final RxString searchString = Get.find<SearchController>().searchString;

//   final _controller = TextEditingController();

//   String _streetNumber = '';

//   String _street = '';

//   String _city = '';

//   String _zipCode = '';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: WeatherImageContainer(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DefaultTextField(
//                 borderColor: Colors.black87,
//                 fillColor: Colors.white54,
//                 controller: controller,
//                 onTap: () async {},
//                 onChanged: (data) {
//                   debugPrint(controller.text);
//                 },
//               ).paddingSymmetric(vertical: 30),
//               MyElevatedButton(
//                 onPressed: () {
//                   Get.find<SearchController>().searchCityWeather();
//                 },
//                 color: Colors.black87,
//                 text: 'Fah Q',
//               ).paddingOnly(bottom: 20),
//               FutureBuilder(
//             ],
//           ).paddingSymmetric(horizontal: 10),
//         ),
//       ),
//     );
//   }
// }




