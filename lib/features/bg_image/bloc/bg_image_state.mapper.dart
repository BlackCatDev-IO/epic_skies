// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bg_image_state.dart';

class BgImageStatusMapper extends EnumMapper<BgImageStatus> {
  BgImageStatusMapper._();

  static BgImageStatusMapper? _instance;
  static BgImageStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BgImageStatusMapper._());
    }
    return _instance!;
  }

  static BgImageStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BgImageStatus decode(dynamic value) {
    switch (value) {
      case 'initial':
        return BgImageStatus.initial;
      case 'loading':
        return BgImageStatus.loading;
      case 'loaded':
        return BgImageStatus.loaded;
      case 'error':
        return BgImageStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BgImageStatus self) {
    switch (self) {
      case BgImageStatus.initial:
        return 'initial';
      case BgImageStatus.loading:
        return 'loading';
      case BgImageStatus.loaded:
        return 'loaded';
      case BgImageStatus.error:
        return 'error';
    }
  }
}

extension BgImageStatusMapperExtension on BgImageStatus {
  String toValue() {
    BgImageStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BgImageStatus>(this) as String;
  }
}

class ImageSettingsMapper extends EnumMapper<ImageSettings> {
  ImageSettingsMapper._();

  static ImageSettingsMapper? _instance;
  static ImageSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSettingsMapper._());
    }
    return _instance!;
  }

  static ImageSettings fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImageSettings decode(dynamic value) {
    switch (value) {
      case 'dynamic':
        return ImageSettings.dynamic;
      case 'deviceGallery':
        return ImageSettings.deviceGallery;
      case 'appGallery':
        return ImageSettings.appGallery;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImageSettings self) {
    switch (self) {
      case ImageSettings.dynamic:
        return 'dynamic';
      case ImageSettings.deviceGallery:
        return 'deviceGallery';
      case ImageSettings.appGallery:
        return 'appGallery';
    }
  }
}

extension ImageSettingsMapperExtension on ImageSettings {
  String toValue() {
    ImageSettingsMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImageSettings>(this) as String;
  }
}

class BgImageStateMapper extends ClassMapperBase<BgImageState> {
  BgImageStateMapper._();

  static BgImageStateMapper? _instance;
  static BgImageStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BgImageStateMapper._());
      BgImageStatusMapper.ensureInitialized();
      WeatherImageModelMapper.ensureInitialized();
      ImageSettingsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BgImageState';

  static BgImageStatus _$status(BgImageState v) => v.status;
  static const Field<BgImageState, BgImageStatus> _f$status =
      Field('status', _$status, opt: true, def: BgImageStatus.initial);
  static List<WeatherImageModel> _$bgImageList(BgImageState v) => v.bgImageList;
  static const Field<BgImageState, List<WeatherImageModel>> _f$bgImageList =
      Field('bgImageList', _$bgImageList, opt: true, def: const []);
  static ImageSettings _$imageSettings(BgImageState v) => v.imageSettings;
  static const Field<BgImageState, ImageSettings> _f$imageSettings = Field(
      'imageSettings', _$imageSettings,
      opt: true, def: ImageSettings.dynamic);
  static String _$bgImagePath(BgImageState v) => v.bgImagePath;
  static const Field<BgImageState, String> _f$bgImagePath =
      Field('bgImagePath', _$bgImagePath, opt: true, def: '');

  @override
  final MappableFields<BgImageState> fields = const {
    #status: _f$status,
    #bgImageList: _f$bgImageList,
    #imageSettings: _f$imageSettings,
    #bgImagePath: _f$bgImagePath,
  };

  static BgImageState _instantiate(DecodingData data) {
    return BgImageState(
        status: data.dec(_f$status),
        bgImageList: data.dec(_f$bgImageList),
        imageSettings: data.dec(_f$imageSettings),
        bgImagePath: data.dec(_f$bgImagePath));
  }

  @override
  final Function instantiate = _instantiate;

  static BgImageState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BgImageState>(map);
  }

  static BgImageState fromJson(String json) {
    return ensureInitialized().decodeJson<BgImageState>(json);
  }
}

mixin BgImageStateMappable {
  String toJson() {
    return BgImageStateMapper.ensureInitialized()
        .encodeJson<BgImageState>(this as BgImageState);
  }

  Map<String, dynamic> toMap() {
    return BgImageStateMapper.ensureInitialized()
        .encodeMap<BgImageState>(this as BgImageState);
  }

  BgImageStateCopyWith<BgImageState, BgImageState, BgImageState> get copyWith =>
      _BgImageStateCopyWithImpl(this as BgImageState, $identity, $identity);
  @override
  String toString() {
    return BgImageStateMapper.ensureInitialized()
        .stringifyValue(this as BgImageState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            BgImageStateMapper.ensureInitialized()
                .isValueEqual(this as BgImageState, other));
  }

  @override
  int get hashCode {
    return BgImageStateMapper.ensureInitialized()
        .hashValue(this as BgImageState);
  }
}

extension BgImageStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BgImageState, $Out> {
  BgImageStateCopyWith<$R, BgImageState, $Out> get $asBgImageState =>
      $base.as((v, t, t2) => _BgImageStateCopyWithImpl(v, t, t2));
}

abstract class BgImageStateCopyWith<$R, $In extends BgImageState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, WeatherImageModel,
          WeatherImageModelCopyWith<$R, WeatherImageModel, WeatherImageModel>>
      get bgImageList;
  $R call(
      {BgImageStatus? status,
      List<WeatherImageModel>? bgImageList,
      ImageSettings? imageSettings,
      String? bgImagePath});
  BgImageStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BgImageStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BgImageState, $Out>
    implements BgImageStateCopyWith<$R, BgImageState, $Out> {
  _BgImageStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BgImageState> $mapper =
      BgImageStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, WeatherImageModel,
          WeatherImageModelCopyWith<$R, WeatherImageModel, WeatherImageModel>>
      get bgImageList => ListCopyWith($value.bgImageList,
          (v, t) => v.copyWith.$chain(t), (v) => call(bgImageList: v));
  @override
  $R call(
          {BgImageStatus? status,
          List<WeatherImageModel>? bgImageList,
          ImageSettings? imageSettings,
          String? bgImagePath}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (bgImageList != null) #bgImageList: bgImageList,
        if (imageSettings != null) #imageSettings: imageSettings,
        if (bgImagePath != null) #bgImagePath: bgImagePath
      }));
  @override
  BgImageState $make(CopyWithData data) => BgImageState(
      status: data.get(#status, or: $value.status),
      bgImageList: data.get(#bgImageList, or: $value.bgImageList),
      imageSettings: data.get(#imageSettings, or: $value.imageSettings),
      bgImagePath: data.get(#bgImagePath, or: $value.bgImagePath));

  @override
  BgImageStateCopyWith<$R2, BgImageState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BgImageStateCopyWithImpl($value, $cast, t);
}
