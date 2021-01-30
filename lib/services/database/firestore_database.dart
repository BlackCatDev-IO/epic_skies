import 'package:cloud_firestore/cloud_firestore.dart';

const plants = 'plants';

class FirebaseUserController {
  String description, name;
  int rating = 4;

  CollectionReference plantCollection =
      FirebaseFirestore.instance.collection(plants);

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return plantCollection
        .add({
          'description': 'tits mcgee', // John Doe
          'name': 'costa rican butternut squash', // Stokes and Sons
          'rating_number': 9 // 42
        })
        .then((value) => print("Plant Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
