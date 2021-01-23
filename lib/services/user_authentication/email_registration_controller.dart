// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EmailRegistrationController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // String _email, _password;

  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  // final emailNode = FocusNode();
  // final passwordNode = FocusNode();

  // @override
  // void onClose() {
  //   emailController?.dispose();
  //   passwordController?.dispose();
  //   super.onClose();
  // }

  // void addTextFieldListeners() {
  //   emailController.addListener(() {
  //     _email = emailController.text;
  //     debugPrint('Email controller value: ${emailController.text}. ');
  //   });
  //   passwordController.addListener(() {
  //     _password = passwordController.text;
  //     debugPrint('Password controller value: ${passwordController.text}');
  //   });
  // }

  // void focusToPasswordField() {
  //   FocusScope.of(Get.context).requestFocus(passwordNode);
  // }

  // Future<void> registerNewUserWithEmail() async {
  //   debugPrint('Email: $_email Password: $_password');
  //   try {
  //     final user = await _auth.createUserWithEmailAndPassword(
  //         email: _email.trim(), password: _password.trim());
  //     if (user != null) {
  //       // wiping values of controllers after successful login
  //       emailController.text = '';
  //       passwordController.text = '';
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Error();
  //   }
  // }

  // Future<void> loginWithEmail() async {
  //   try {
  //     final user = await _auth.signInWithEmailAndPassword(
  //         email: _email.trim(), password: _password.trim());
  //     if (user != null) {
  //     }
  //   } catch (e) {
  //     print(e);

  //     throw Error();
  //   }
  // }

  // void emailLogout() {
  //   _auth.signOut();
  //   Get.back();
  // }
// }
