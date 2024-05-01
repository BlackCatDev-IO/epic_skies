// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sun_time_model.dart';

class SunTimesModelMapper extends ClassMapperBase<SunTimesModel> {
  SunTimesModelMapper._();

  static SunTimesModelMapper? _instance;
  static SunTimesModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SunTimesModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SunTimesModel';

  static String _$sunriseString(SunTimesModel v) => v.sunriseString;
  static const Field<SunTimesModel, String> _f$sunriseString =
      Field('sunriseString', _$sunriseString);
  static String _$sunsetString(SunTimesModel v) => v.sunsetString;
  static const Field<SunTimesModel, String> _f$sunsetString =
      Field('sunsetString', _$sunsetString);
  static DateTime? _$sunriseTime(SunTimesModel v) => v.sunriseTime;
  static const Field<SunTimesModel, DateTime> _f$sunriseTime =
      Field('sunriseTime', _$sunriseTime, opt: true);
  static DateTime? _$sunsetTime(SunTimesModel v) => v.sunsetTime;
  static const Field<SunTimesModel, DateTime> _f$sunsetTime =
      Field('sunsetTime', _$sunsetTime, opt: true);

  @override
  final MappableFields<SunTimesModel> fields = const {
    #sunriseString: _f$sunriseString,
    #sunsetString: _f$sunsetString,
    #sunriseTime: _f$sunriseTime,
    #sunsetTime: _f$sunsetTime,
  };

  static SunTimesModel _instantiate(DecodingData data) {
    return SunTimesModel(
        sunriseString: data.dec(_f$sunriseString),
        sunsetString: data.dec(_f$sunsetString),
        sunriseTime: data.dec(_f$sunriseTime),
        sunsetTime: data.dec(_f$sunsetTime));
  }

  @override
  final Function instantiate = _instantiate;

  static SunTimesModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SunTimesModel>(map);
  }

  static SunTimesModel fromJson(String json) {
    return ensureInitialized().decodeJson<SunTimesModel>(json);
  }
}

mixin SunTimesModelMappable {
  String toJson() {
    return SunTimesModelMapper.ensureInitialized()
        .encodeJson<SunTimesModel>(this as SunTimesModel);
  }

  Map<String, dynamic> toMap() {
    return SunTimesModelMapper.ensureInitialized()
        .encodeMap<SunTimesModel>(this as SunTimesModel);
  }

  SunTimesModelCopyWith<SunTimesModel, SunTimesModel, SunTimesModel>
      get copyWith => _SunTimesModelCopyWithImpl(
          this as SunTimesModel, $identity, $identity);
  @override
  String toString() {
    return SunTimesModelMapper.ensureInitialized()
        .stringifyValue(this as SunTimesModel);
  }

  @override
  bool operator ==(Object other) {
    return SunTimesModelMapper.ensureInitialized()
        .equalsValue(this as SunTimesModel, other);
  }

  @override
  int get hashCode {
    return SunTimesModelMapper.ensureInitialized()
        .hashValue(this as SunTimesModel);
  }
}

extension SunTimesModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SunTimesModel, $Out> {
  SunTimesModelCopyWith<$R, SunTimesModel, $Out> get $asSunTimesModel =>
      $base.as((v, t, t2) => _SunTimesModelCopyWithImpl(v, t, t2));
}

abstract class SunTimesModelCopyWith<$R, $In extends SunTimesModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? sunriseString,
      String? sunsetString,
      DateTime? sunriseTime,
      DateTime? sunsetTime});
  SunTimesModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SunTimesModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SunTimesModel, $Out>
    implements SunTimesModelCopyWith<$R, SunTimesModel, $Out> {
  _SunTimesModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SunTimesModel> $mapper =
      SunTimesModelMapper.ensureInitialized();
  @override
  $R call(
          {String? sunriseString,
          String? sunsetString,
          Object? sunriseTime = $none,
          Object? sunsetTime = $none}) =>
      $apply(FieldCopyWithData({
        if (sunriseString != null) #sunriseString: sunriseString,
        if (sunsetString != null) #sunsetString: sunsetString,
        if (sunriseTime != $none) #sunriseTime: sunriseTime,
        if (sunsetTime != $none) #sunsetTime: sunsetTime
      }));
  @override
  SunTimesModel $make(CopyWithData data) => SunTimesModel(
      sunriseString: data.get(#sunriseString, or: $value.sunriseString),
      sunsetString: data.get(#sunsetString, or: $value.sunsetString),
      sunriseTime: data.get(#sunriseTime, or: $value.sunriseTime),
      sunsetTime: data.get(#sunsetTime, or: $value.sunsetTime));

  @override
  SunTimesModelCopyWith<$R2, SunTimesModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SunTimesModelCopyWithImpl($value, $cast, t);
}
