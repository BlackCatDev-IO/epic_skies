import 'dart:io';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ImageRepository {
  ImageRepository();

  final _firebaseStorage = FirebaseStorage.instance.ref();

  late ByteData earthFromSpaceBytes;

  late File earthFromSpaceFile;

  Future<List<WeatherImageModel>> fetchFirebaseImages({
    int retryCount = 0,
  }) async {
    try {
      final hasConnection = await InternetConnection().hasInternetAccess;

      if (!hasConnection) {
        throw NoConnectionException();
      }

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
      AppDebug.logSentryError(
        'Error on fetchFirebaseImages: $e retryCount: $retryCount',
        name: 'Image Repository',
        stack: StackTrace.current,
      );

      if (retryCount < 3) {
        return fetchFirebaseImages(retryCount: retryCount + 1);
      } else {
        rethrow;
      }
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
