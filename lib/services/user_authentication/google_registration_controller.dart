// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   RxString email = ' '.obs;
//   RxString password = ' '.obs;

//   Future<void> loginWithGoogle() async {
//     try {
//       final GoogleSignInAccount googleSignInAccount =
//           await googleSignIn.signIn();
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       final authResult = await _auth.signInWithCredential(credential);

//       final User user = authResult.user;
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//       final User currentUser = _auth.currentUser;
//       assert(user.uid == currentUser.uid);
//       return;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> logoutGoogle() async {
//     await googleSignIn.signOut();
//     Get.back(); // navigate to your wanted page after logout.
//   }
// }
