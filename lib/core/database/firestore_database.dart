import 'dart:io';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImageController {
  FirebaseImageController({required this.storage});

  final StorageController storage;

  late String path;

  Reference firebaseStorage = FirebaseStorage.instance.ref();

  List<String> fullImageList = [];

  /// These are the file paths that get stored into the phones
  /// local directory. index 0 for day images, 1 for night images
  List<List<String>> clearImageList = [[], []];
  List<List<String>> cloudyImageList = [[], []];
  List<List<String>> rainImageList = [[], []];
  List<List<String>> snowImageList = [[], []];
  List<List<String>> stormImageList = [[], []];

  Future<void> fetchFirebaseImagesAndStoreLocally() async {
    path = storage.restoreAppDirectory();

    try {
      final allImages = await firebaseStorage.listAll();
      for (final prefix in allImages.prefixes) {
        final dayList = await prefix.child('day').listAll();
        final nightList = await prefix.child('night').listAll();

        _addToDayLists(items: dayList.items, name: prefix.name);
        _addToNightLists(items: nightList.items, name: prefix.name);
      }
    } catch (e) {
      await FailureHandler.handleFetchFirebaseImagesAndStoreLocallyError(
        error: e.toString(),
      );
      throw Exception(e);
    }

    final map = <String, List<List<String>>>{
      'clear': clearImageList,
      'cloudy': cloudyImageList,
      'rain': rainImageList,
      'snow': snowImageList,
      'thunder_storm': stormImageList,
    };

    storage.storeBgImageFileNames(map);
  }

  void _addToDayLists({required List<Reference> items, required String name}) {
    for (final ref in items) {
      fullImageList.add(ref.name);

      switch (name) {
        case 'clear':
          clearImageList[0].add(ref.name);
          break;
        case 'cloudy':
          cloudyImageList[0].add(ref.name);
          break;
        case 'rain':
          rainImageList[0].add(ref.name);
          break;
        case 'snow':
          snowImageList[0].add(ref.name);
          break;
        case 'thunder_storm':
          stormImageList[0].add(ref.name);
          break;
      }
      _storeImageToAppDirectory(ref: ref, fileName: ref.name);
    }
  }

  void _addToNightLists({
    required List<Reference> items,
    required String name,
  }) {
    for (final ref in items) {
      fullImageList.add(ref.name);

      switch (name) {
        case 'clear':
          clearImageList[1].add(ref.name);
          break;
        case 'cloudy':
          cloudyImageList[1].add(ref.name);
          break;
        case 'rain':
          rainImageList[1].add(ref.name);
          break;
        case 'snow':
          snowImageList[1].add(ref.name);
          break;
        case 'thunder_storm':
          stormImageList[1].add(ref.name);
          break;
      }
      _storeImageToAppDirectory(ref: ref, fileName: ref.name);
    }
  }

  void _storeImageToAppDirectory({
    required Reference ref,
    required String fileName,
  }) {
    final file = File('$path/$fileName');

    try {
      ref.writeToFile(file);
    } on FirebaseException catch (e) {
      FailureHandler.handleStoreImageToAppDirectoryError(error: e.toString());
      rethrow; // TODO Handle this error
    }
  }
}
