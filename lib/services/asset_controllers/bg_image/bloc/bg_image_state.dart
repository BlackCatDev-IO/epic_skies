import 'package:freezed_annotation/freezed_annotation.dart';

part 'bg_image_state.freezed.dart';

part 'bg_image_state.g.dart';

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

@freezed
class BgImageState with _$BgImageState {
  const factory BgImageState({
    required ImageSettings imageSettings,
    required String bgImagePath,
    required Map<String, List<String>> imageFileMap,
    required List<String> imageFileList,
  }) = _BgImageState;

  factory BgImageState.fromJson(Map<String, Object?> json) =>
      _$BgImageStateFromJson(json);

  factory BgImageState.initial(Map<String, List<String>> imageFileMap) {
    final imageFileList = <String>[];

    for (final fileList in imageFileMap.values) {
      for (final file in fileList) {
        imageFileList.add(file);
      }
    }
    return BgImageState(
      imageSettings: ImageSettings.dynamic,
      bgImagePath: '',
      imageFileMap: imageFileMap,
      imageFileList: imageFileList,
    );
  }
}
