part of 'bg_image_bloc.dart';

enum ImageSettings {
  dynamic,
  deviceGallery,
  appGallery,
}

extension ImageSettingX on ImageSettings {
  bool get isDynamic => this == ImageSettings.dynamic;
  bool get isDeviceGallery => this == ImageSettings.deviceGallery;
  bool get isAppGallery => this == ImageSettings.appGallery;
}

class BgImageState extends Equatable {
  const BgImageState({
    this.imageSettings = ImageSettings.dynamic,
    this.bgImage,
    this.imageFileMap = const {},
    this.imageFileList = const [],
  });

  final ImageSettings imageSettings;
  final ImageProvider? bgImage;
  final Map<String, List<File>> imageFileMap;
  final List<File> imageFileList;

  BgImageState copyWith({
    ImageSettings? imageSettings,
    ImageProvider? bgImage,
    Map<String, List<File>>? imageFileMap,
    List<File>? imageFileList,
  }) {
    return BgImageState(
      imageSettings: imageSettings ?? this.imageSettings,
      bgImage: bgImage ?? this.bgImage,
      imageFileMap: imageFileMap ?? this.imageFileMap,
      imageFileList: imageFileList ?? this.imageFileList,
    );
  }

  @override
  String toString() {
    final settingString = EnumToString.convertToString(imageSettings);

    return 'BgImage: $bgImage ImageSettings: $settingString';
  }

  @override
  List<Object?> get props => [
        bgImage,
        imageSettings,
        imageFileMap,
        imageFileList,
      ];
}
