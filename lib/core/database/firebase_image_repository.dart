import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImageRepository {
  FirebaseImageRepository();

  final _firebaseStorage = FirebaseStorage.instance.ref();

  Future<List<WeatherImageModel>> fetchFirebaseImages() async {
    try {
      /// List of Futures that will be used to get the image urls in parallel
      final imageRequestList = <Future<WeatherImageModel>>[];

      final allImages = await _firebaseStorage.listAll();

      for (final prefix in allImages.prefixes) {
        final dayList = await prefix.child('day').listAll();
        final nightList = await prefix.child('night').listAll();

        final list = _getImageModelRequestList(
          items: dayList.items,
          name: prefix.name,
          isDay: true,
        );

        final nightImageList = _getImageModelRequestList(
          items: nightList.items,
          name: prefix.name,
          isDay: false,
        );

        imageRequestList.addAll([...list, ...nightImageList]);
      }

      final imageList = await Future.wait(imageRequestList);

      return imageList;
    } catch (e) {
      await FailureHandler.handleFetchFirebaseImagesAndStoreLocallyError(
        error: e.toString(),
      );
      throw Exception(e);
    }
  }

  List<Future<WeatherImageModel>> _getImageModelRequestList({
    required List<Reference> items,
    required String name,
    required bool isDay,
  }) {
    final imageRequestList = items.map((ref) async {
      final imageUrl = await ref.getDownloadURL();

      return WeatherImageModel(
        imageUrl: imageUrl,
        isDay: isDay,
        condition: _getTypeFromName(name),
      );
    }).toList();

    return imageRequestList;
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
