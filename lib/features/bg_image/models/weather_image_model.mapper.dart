// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_image_model.dart';

class WeatherImageTypeMapper extends EnumMapper<WeatherImageType> {
  WeatherImageTypeMapper._();

  static WeatherImageTypeMapper? _instance;
  static WeatherImageTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherImageTypeMapper._());
    }
    return _instance!;
  }

  static WeatherImageType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  WeatherImageType decode(dynamic value) {
    switch (value) {
      case 'clear':
        return WeatherImageType.clear;
      case 'cloudy':
        return WeatherImageType.cloudy;
      case 'rain':
        return WeatherImageType.rain;
      case 'snow':
        return WeatherImageType.snow;
      case 'storm':
        return WeatherImageType.storm;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(WeatherImageType self) {
    switch (self) {
      case WeatherImageType.clear:
        return 'clear';
      case WeatherImageType.cloudy:
        return 'cloudy';
      case WeatherImageType.rain:
        return 'rain';
      case WeatherImageType.snow:
        return 'snow';
      case WeatherImageType.storm:
        return 'storm';
    }
  }
}

extension WeatherImageTypeMapperExtension on WeatherImageType {
  String toValue() {
    WeatherImageTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<WeatherImageType>(this) as String;
  }
}

class WeatherImageModelMapper extends ClassMapperBase<WeatherImageModel> {
  WeatherImageModelMapper._();

  static WeatherImageModelMapper? _instance;
  static WeatherImageModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherImageModelMapper._());
      WeatherImageTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherImageModel';

  static WeatherImageType _$condition(WeatherImageModel v) => v.condition;
  static const Field<WeatherImageModel, WeatherImageType> _f$condition =
      Field('condition', _$condition);
  static bool _$isDay(WeatherImageModel v) => v.isDay;
  static const Field<WeatherImageModel, bool> _f$isDay =
      Field('isDay', _$isDay);
  static String _$imageUrl(WeatherImageModel v) => v.imageUrl;
  static const Field<WeatherImageModel, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl);

  @override
  final MappableFields<WeatherImageModel> fields = const {
    #condition: _f$condition,
    #isDay: _f$isDay,
    #imageUrl: _f$imageUrl,
  };

  static WeatherImageModel _instantiate(DecodingData data) {
    return WeatherImageModel(
        condition: data.dec(_f$condition),
        isDay: data.dec(_f$isDay),
        imageUrl: data.dec(_f$imageUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherImageModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherImageModel>(map);
  }

  static WeatherImageModel fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherImageModel>(json);
  }
}

mixin WeatherImageModelMappable {
  String toJson() {
    return WeatherImageModelMapper.ensureInitialized()
        .encodeJson<WeatherImageModel>(this as WeatherImageModel);
  }

  Map<String, dynamic> toMap() {
    return WeatherImageModelMapper.ensureInitialized()
        .encodeMap<WeatherImageModel>(this as WeatherImageModel);
  }

  WeatherImageModelCopyWith<WeatherImageModel, WeatherImageModel,
          WeatherImageModel>
      get copyWith => _WeatherImageModelCopyWithImpl(
          this as WeatherImageModel, $identity, $identity);
  @override
  String toString() {
    return WeatherImageModelMapper.ensureInitialized()
        .stringifyValue(this as WeatherImageModel);
  }

  @override
  bool operator ==(Object other) {
    return WeatherImageModelMapper.ensureInitialized()
        .equalsValue(this as WeatherImageModel, other);
  }

  @override
  int get hashCode {
    return WeatherImageModelMapper.ensureInitialized()
        .hashValue(this as WeatherImageModel);
  }
}

extension WeatherImageModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherImageModel, $Out> {
  WeatherImageModelCopyWith<$R, WeatherImageModel, $Out>
      get $asWeatherImageModel =>
          $base.as((v, t, t2) => _WeatherImageModelCopyWithImpl(v, t, t2));
}

abstract class WeatherImageModelCopyWith<$R, $In extends WeatherImageModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({WeatherImageType? condition, bool? isDay, String? imageUrl});
  WeatherImageModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WeatherImageModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherImageModel, $Out>
    implements WeatherImageModelCopyWith<$R, WeatherImageModel, $Out> {
  _WeatherImageModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherImageModel> $mapper =
      WeatherImageModelMapper.ensureInitialized();
  @override
  $R call({WeatherImageType? condition, bool? isDay, String? imageUrl}) =>
      $apply(FieldCopyWithData({
        if (condition != null) #condition: condition,
        if (isDay != null) #isDay: isDay,
        if (imageUrl != null) #imageUrl: imageUrl
      }));
  @override
  WeatherImageModel $make(CopyWithData data) => WeatherImageModel(
      condition: data.get(#condition, or: $value.condition),
      isDay: data.get(#isDay, or: $value.isDay),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl));

  @override
  WeatherImageModelCopyWith<$R2, WeatherImageModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WeatherImageModelCopyWithImpl($value, $cast, t);
}
