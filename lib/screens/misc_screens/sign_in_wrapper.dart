// import 'package:black_cat_lib/constants.dart';
// import 'package:epic_skies/widgets/login_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'login_page.dart';
// import 'registration_page.dart';


// class SignInWrapperPage extends StatelessWidget {
//   static const id = 'sign_in_wrapper';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(height: screenHeight * 0.7),
//               // Expanded(flex: 2, child: Container()),
//               LoginButtonNoIcon(
//                 onPressed: () {
//                   Get.to(RegistrationPage());
//                 },
//                 text: 'Create Account',
//               ),
//               sizedBox5High,
//               LoginButtonNoIcon(
//                 onPressed: () {
//                   Get.to(LoginPage());
//                 },
//                 text: 'Login',
//               ),
//               sizedBox10High,
//             ],
//           ).paddingSymmetric(horizontal: 15, vertical: 15),
//         ),
//       ),
//     );
//   }
// }
