import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';

part 'bg_image_state.mapper.dart';

@MappableEnum()
enum BgImageStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == BgImageStatus.initial;
  bool get isLoading => this == BgImageStatus.loading;
  bool get isLoaded => this == BgImageStatus.loaded;
  bool get isError => this == BgImageStatus.error;
}

@MappableEnum()
enum ImageSettings {
  dynamic,
  deviceGallery,
  appGallery;

  bool get isDynamic => this == ImageSettings.dynamic;
  bool get isDeviceGallery => this == ImageSettings.deviceGallery;
  bool get isAppGallery => this == ImageSettings.appGallery;
}

@MappableClass()
class BgImageState with BgImageStateMappable {
  const BgImageState({
    this.status = BgImageStatus.initial,
    this.bgImageList = const [],
    this.imageSettings = ImageSettings.dynamic,
    this.bgImagePath = '',
  });

  final BgImageStatus status;
  final List<WeatherImageModel> bgImageList;
  final ImageSettings imageSettings;
  final String bgImagePath;

  static const fromMap = BgImageStateMapper.fromMap;

  @override
  String toString() {
    return '''
BgImage status: $status Path: $bgImagePath Settings: $imageSettings''';
  }
}
