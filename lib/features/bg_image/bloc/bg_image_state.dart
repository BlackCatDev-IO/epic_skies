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
    @Default(ImageSettings.dynamic) ImageSettings imageSettings,
    @Default('') String bgImagePath,
  }) = _BgImageState;

  factory BgImageState.fromJson(Map<String, Object?> json) =>
      _$BgImageStateFromJson(json);

  const BgImageState._();

  @override
  String toString() {
    return 'BgImage Path: $bgImagePath Settings: $imageSettings';
  }
}
