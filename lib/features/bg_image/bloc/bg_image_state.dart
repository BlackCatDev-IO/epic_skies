import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bg_image_state.freezed.dart';
part 'bg_image_state.g.dart';

enum BgImageStatus { initial, loading, loaded, error }

enum ImageSettings { dynamic, deviceGallery, appGallery }

extension BgImageStatusX on BgImageStatus {
  bool get isInitial => this == BgImageStatus.initial;
  bool get isLoading => this == BgImageStatus.loading;
  bool get isLoaded => this == BgImageStatus.loaded;
  bool get isError => this == BgImageStatus.error;
}

extension ImageSettingX on ImageSettings {
  bool get isDynamic => this == ImageSettings.dynamic;
  bool get isDeviceGallery => this == ImageSettings.deviceGallery;
  bool get isAppGallery => this == ImageSettings.appGallery;
}

@freezed
class BgImageState with _$BgImageState {
  const factory BgImageState({
    @Default(BgImageStatus.initial) BgImageStatus status,
    @Default([]) List<WeatherImageModel> bgImageList,
    @Default(ImageSettings.dynamic) ImageSettings imageSettings,
    @Default('') String bgImagePath,
  }) = _BgImageState;

  factory BgImageState.fromJson(Map<String, Object?> json) =>
      _$BgImageStateFromJson(json);

  const BgImageState._();

  @override
  String toString() {
    return '''
BgImage status: $status Path: $bgImagePath Settings: $imageSettings''';
  }
}
