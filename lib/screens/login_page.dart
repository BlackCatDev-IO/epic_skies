// import 'package:black_cat_lib/constants.dart';
// import 'package:epic_skies/services/user_authentication/email_registration_controller.dart';
// import 'package:epic_skies/services/user_authentication/google_registration_controller.dart';
// import 'package:epic_skies/widgets/default_textfield.dart';
// import 'package:epic_skies/widgets/login_button.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:validators/validators.dart';

// import 'registration_page.dart';

// class LoginPage extends StatelessWidget {
//   static const id = 'login_page';
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   // final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     final emailSignInController = Get.find<EmailRegistrationController>();
//     final googleSignInController = Get.find<GoogleSignInController>();
//     emailSignInController.addTextFieldListeners();
//     final GlobalKey key = GlobalKey<FormState>();

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
//                   'Log In',
//                   style: kGoogleFontOpenSansCondensed.copyWith(
//                       color: Colors.white, fontSize: 40),
//                 ),
//                 DefaultTextField(
//                   controller: emailSignInController.emailController,
//                   hintText: 'Email',
//                   color: Colors.white,
//                 ),
//                 DefaultTextField(
//                   controller: emailSignInController.passwordController,
//                   hintText: 'Password',
//                   color: Colors.white,
//                 ),
//                 LoginButtonNoIcon(
//                     onPressed: () {
//                       emailSignInController.loginWithEmail();
//                     },
//                     text: 'Login'),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             style: kGoogleFontOpenSansCondensed,
//                             text: 'Not a member? ',
//                             children: [
//                               TextSpan(
//                                   text: ' Join us',
//                                   style: const TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.w800,
//                                       decoration: TextDecoration.underline),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Get.to(RegistrationPage());
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
//                     onPressed: () {},
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
// }
