import 'dart:io';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'storage_controller.dart';

class FirebaseImageController extends GetxController {
  static FirebaseImageController get to => Get.find();

  late String path;

  Reference storage = FirebaseStorage.instance.ref();

  List<String> fullImageList = [];

  /// These are the file paths that get stored into the phones
  /// local directory. index 0 for day images, 1 for night images
  List<List<String>> clearImageList = [[], []];
  List<List<String>> cloudyImageList = [[], []];
  List<List<String>> rainImageList = [[], []];
  List<List<String>> snowImageList = [[], []];
  List<List<String>> stormImageList = [[], []];

  Future<void> fetchFirebaseImagesAndStoreLocally() async {
    path = StorageController.to.appDirectoryPath;

    try {
      final allImages = await storage.listAll();
      for (final prefix in allImages.prefixes) {
        final ListResult dayList = await prefix.child('day').listAll();
        final ListResult nightList = await prefix.child('night').listAll();

        _addToDayLists(items: dayList.items, name: prefix.name);
        _addToNightLists(items: nightList.items, name: prefix.name);
      }
    } catch (e) {
      FailureHandler.handleFetchFirebaseImagesAndStoreLocallyError(
        error: e.toString(),
      );
      throw Exception(e);
    }

    final Map<String, List<List<String>>> map = {
      'clear': clearImageList,
      'cloudy': cloudyImageList,
      'rain': rainImageList,
      'snow': snowImageList,
      'thunder_storm': stormImageList,
    };

    StorageController.to.storeBgImageFileNames(map);
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

  Future<void> _storeImageToAppDirectory({
    required Reference ref,
    required String fileName,
  }) async {
    final file = File('$path/$fileName');

    try {
      ref.writeToFile(file);
    } on FirebaseException catch (e) {
      FailureHandler.handleStoreImageToAppDirectoryError(error: e.toString());
      throw FirebaseException; // TODO Handle this error
    }
  }
}
