import 'dart:io';

import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/services/connectivity/connectivity_listener.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class ImageRepository {
  ImageRepository();

  final _firebaseStorage = FirebaseStorage.instance.ref();

  late ByteData earthFromSpaceBytes;

  late File earthFromSpaceFile;

  Future<List<WeatherImageModel>> fetchFirebaseImages() async {
    if (!ConnectivityListener.hasConnection) {
      throw Exception('No internet connection');
    }

    try {
      /// List of Futures that will be used to get the image urls in parallel
      final imageRequestList = <Future<WeatherImageModel>>[];

      final allImages = await _firebaseStorage.listAll();

      for (final prefix in allImages.prefixes) {
        final dayList = await prefix.child('day').listAll();
        final nightList = await prefix.child('night').listAll();

        final dayImageList = _getImageModelRequestList(
          items: dayList.items,
          name: prefix.name,
          isDay: true,
        );

        final nightImageList = _getImageModelRequestList(
          items: nightList.items,
          name: prefix.name,
          isDay: false,
        );

        imageRequestList.addAll([
          ...dayImageList,
          ...nightImageList,
        ]);
      }

      final imageList = await Future.wait(imageRequestList);

      return imageList;
    } catch (e) {
      AppDebug.log('Error on fetchFirebaseImages: $e');
      await FailureHandler.handleFetchFirebaseImagesAndStoreLocallyError(
        error: e.toString(),
      );
      rethrow;
    }
  }

  List<Future<WeatherImageModel>> _getImageModelRequestList({
    required List<Reference> items,
    required String name,
    required bool isDay,
  }) {
    try {
      final imageRequestList = items.map((ref) async {
        final url = await ref.getDownloadURL();

        return WeatherImageModel(
          imageUrl: url,
          isDay: isDay,
          condition: _getTypeFromName(name),
        );
      }).toList();

      return imageRequestList;
    } catch (e) {
      AppDebug.log('Error on _getImageModelRequestList: $e');
      rethrow;
    }
  }

  WeatherImageType _getTypeFromName(String name) {
    switch (name) {
      case 'clear':
        return WeatherImageType.clear;
      case 'cloudy':
        return WeatherImageType.cloudy;
      case 'rain':
        return WeatherImageType.rain;
      case 'snow':
        return WeatherImageType.snow;
      case 'thunder_storm':
        return WeatherImageType.storm;
    }

    return WeatherImageType.clear;
  }
}
