// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:flutter/foundation.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FirebaseUserController extends GetxController {
//   final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   bool isSignedIn() => _firebaseAuth.currentUser != null;

//   Stream<auth.User> onAuthChanged() => _firebaseAuth.authStateChanges();

//   auth.User getCurrentUser() => _firebaseAuth.currentUser;

//   Future<String> getAccessToken() => getCurrentUser().getIdToken();

//   Future<String> getRefreshToken() => _firebaseAuth.currentUser.getIdToken();

//   bool isEmailVerified() => _firebaseAuth.currentUser.emailVerified;

//   Future<void> signOut()  {
//     return  Future.wait([
//       _firebaseAuth.signOut(),
//       _googleSignIn.signOut(),
//     ]);
//   }

//   Future<void> sendEmailVerification() =>
//       _firebaseAuth.currentUser.sendEmailVerification();

//   void changeEmail(String email) =>
//       _firebaseAuth.currentUser.updateEmail(email);

//   Future<void> changePassword(String password) async {
//     final auth.User user = _firebaseAuth.currentUser;
//     await user.updatePassword(password).then((_) {
//       debugPrint("Succesfull changed password");
//     }).catchError((error) {
//       debugPrint("Password can't be changed: $error");
//     });
//   }

//   Future<void> deleteUser() async {
//     final auth.User user = _firebaseAuth.currentUser;
//     await user.delete().then((_) {
//       debugPrint("Succesfull user deleted");
//     }).catchError((error) {
//       debugPrint("user can't be delete: $error");
//     });
//   }

//   Future<void> sendPasswordResetMail(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }
// }
