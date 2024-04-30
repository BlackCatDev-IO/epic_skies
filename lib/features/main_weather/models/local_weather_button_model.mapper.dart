// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_weather_button_model.dart';

class LocalWeatherButtonModelMapper
    extends ClassMapperBase<LocalWeatherButtonModel> {
  LocalWeatherButtonModelMapper._();

  static LocalWeatherButtonModelMapper? _instance;
  static LocalWeatherButtonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = LocalWeatherButtonModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalWeatherButtonModel';

  static int _$temp(LocalWeatherButtonModel v) => v.temp;
  static const Field<LocalWeatherButtonModel, int> _f$temp =
      Field('temp', _$temp, opt: true, def: 0);
  static String _$condition(LocalWeatherButtonModel v) => v.condition;
  static const Field<LocalWeatherButtonModel, String> _f$condition =
      Field('condition', _$condition, opt: true, def: '');
  static bool _$isDay(LocalWeatherButtonModel v) => v.isDay;
  static const Field<LocalWeatherButtonModel, bool> _f$isDay =
      Field('isDay', _$isDay, opt: true, def: true);
  static bool _$tempUnitsMetric(LocalWeatherButtonModel v) => v.tempUnitsMetric;
  static const Field<LocalWeatherButtonModel, bool> _f$tempUnitsMetric =
      Field('tempUnitsMetric', _$tempUnitsMetric, opt: true, def: false);

  @override
  final MappableFields<LocalWeatherButtonModel> fields = const {
    #temp: _f$temp,
    #condition: _f$condition,
    #isDay: _f$isDay,
    #tempUnitsMetric: _f$tempUnitsMetric,
  };

  static LocalWeatherButtonModel _instantiate(DecodingData data) {
    return LocalWeatherButtonModel(
        temp: data.dec(_f$temp),
        condition: data.dec(_f$condition),
        isDay: data.dec(_f$isDay),
        tempUnitsMetric: data.dec(_f$tempUnitsMetric));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalWeatherButtonModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalWeatherButtonModel>(map);
  }

  static LocalWeatherButtonModel fromJson(String json) {
    return ensureInitialized().decodeJson<LocalWeatherButtonModel>(json);
  }
}

mixin LocalWeatherButtonModelMappable {
  String toJson() {
    return LocalWeatherButtonModelMapper.ensureInitialized()
        .encodeJson<LocalWeatherButtonModel>(this as LocalWeatherButtonModel);
  }

  Map<String, dynamic> toMap() {
    return LocalWeatherButtonModelMapper.ensureInitialized()
        .encodeMap<LocalWeatherButtonModel>(this as LocalWeatherButtonModel);
  }

  LocalWeatherButtonModelCopyWith<LocalWeatherButtonModel,
          LocalWeatherButtonModel, LocalWeatherButtonModel>
      get copyWith => _LocalWeatherButtonModelCopyWithImpl(
          this as LocalWeatherButtonModel, $identity, $identity);
  @override
  String toString() {
    return LocalWeatherButtonModelMapper.ensureInitialized()
        .stringifyValue(this as LocalWeatherButtonModel);
  }

  @override
  bool operator ==(Object other) {
    return LocalWeatherButtonModelMapper.ensureInitialized()
        .equalsValue(this as LocalWeatherButtonModel, other);
  }

  @override
  int get hashCode {
    return LocalWeatherButtonModelMapper.ensureInitialized()
        .hashValue(this as LocalWeatherButtonModel);
  }
}

extension LocalWeatherButtonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalWeatherButtonModel, $Out> {
  LocalWeatherButtonModelCopyWith<$R, LocalWeatherButtonModel, $Out>
      get $asLocalWeatherButtonModel => $base
          .as((v, t, t2) => _LocalWeatherButtonModelCopyWithImpl(v, t, t2));
}

abstract class LocalWeatherButtonModelCopyWith<
    $R,
    $In extends LocalWeatherButtonModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? temp, String? condition, bool? isDay, bool? tempUnitsMetric});
  LocalWeatherButtonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LocalWeatherButtonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalWeatherButtonModel, $Out>
    implements
        LocalWeatherButtonModelCopyWith<$R, LocalWeatherButtonModel, $Out> {
  _LocalWeatherButtonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalWeatherButtonModel> $mapper =
      LocalWeatherButtonModelMapper.ensureInitialized();
  @override
  $R call({int? temp, String? condition, bool? isDay, bool? tempUnitsMetric}) =>
      $apply(FieldCopyWithData({
        if (temp != null) #temp: temp,
        if (condition != null) #condition: condition,
        if (isDay != null) #isDay: isDay,
        if (tempUnitsMetric != null) #tempUnitsMetric: tempUnitsMetric
      }));
  @override
  LocalWeatherButtonModel $make(CopyWithData data) => LocalWeatherButtonModel(
      temp: data.get(#temp, or: $value.temp),
      condition: data.get(#condition, or: $value.condition),
      isDay: data.get(#isDay, or: $value.isDay),
      tempUnitsMetric: data.get(#tempUnitsMetric, or: $value.tempUnitsMetric));

  @override
  LocalWeatherButtonModelCopyWith<$R2, LocalWeatherButtonModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _LocalWeatherButtonModelCopyWithImpl($value, $cast, t);
}
