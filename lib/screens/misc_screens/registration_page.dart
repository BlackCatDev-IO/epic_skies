// import 'package:black_cat_lib/constants.dart';
// import 'package:epic_skies/services/user_authentication/email_registration_controller.dart';
// import 'package:epic_skies/services/user_authentication/google_registration_controller.dart';
// import 'package:epic_skies/widgets/default_textfield.dart';
// import 'package:epic_skies/widgets/login_button.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../local_constants.dart';
// import 'login_page.dart';

// class RegistrationPage extends StatelessWidget {
//   static const id = 'registration_page';
//   @override
//   Widget build(BuildContext context) {
//     final emailRegistrationController = Get.find<EmailRegistrationController>();
//     final googleSignInController = Get.find<GoogleSignInController>();
//     emailRegistrationController.addTextFieldListeners();

//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Form(
//           key: key,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Text(
//                   'Create Account',
//                   style: kGoogleFontOpenSansCondensed.copyWith(
//                       color: Colors.white, fontSize: 40),
//                 ),
//                 DefaultTextField(
//                   controller: emailRegistrationController.emailController,
//                   hintText: 'Email',
//                 ),
//                 DefaultTextField(
//                   controller: emailRegistrationController.passwordController,
//                   hintText: 'Password',
//                 ),
//                 LoginButtonNoIcon(
//                     onPressed: () {
//                       emailRegistrationController.registerNewUserWithEmail();
//                     },
//                     text: 'Create Account'),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             style: kGoogleFontOpenSansCondensed,
//                             text: 'Already a member? ',
//                             children: [
//                               TextSpan(
//                                   text: ' Log in',
//                                   style: const TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.w800,
//                                       decoration: TextDecoration.underline),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Get.to(LoginPage());
//                                     }),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: screenHeight * .2),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Or continue with',
//                           style: kGoogleFontOpenSansCondensed.copyWith(
//                               color: Colors.white, fontSize: 17.5),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 // SizedBox(height: screenHeight * .2),
//                 LoginButtonWithIcon(
//                     onPressed: () {
//                       googleSignInController.loginWithGoogle();
//                     },
//                     text: 'Sign in with Google',
//                     iconIsImage: true,
//                     imageIcon: 'assets/icons/icons8-google-100.png'),
//                 LoginButtonWithIcon(
//                     onPressed: () {
//                       googleSignInController.loginWithGoogle();
//                     },
//                     iconIsImage: true,
//                     text: 'Sign in with FaceBook',
//                     imageIcon: 'assets/icons/icons8-facebook-64.png'),
//               ],
//             ).paddingSymmetric(horizontal: 15, vertical: 15),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget loginTextField(
//       {@required TextEditingController controller, String hintText}) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(hintText: hintText),
//     );
//   }
// }
