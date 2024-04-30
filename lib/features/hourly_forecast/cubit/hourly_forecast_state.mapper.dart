// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hourly_forecast_state.dart';

class HourlyForecastStateMapper extends ClassMapperBase<HourlyForecastState> {
  HourlyForecastStateMapper._();

  static HourlyForecastStateMapper? _instance;
  static HourlyForecastStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HourlyForecastStateMapper._());
      HourlyForecastModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HourlyForecastState';

  static List<HourlyForecastModel> _$next24Hours(HourlyForecastState v) =>
      v.next24Hours;
  static const Field<HourlyForecastState, List<HourlyForecastModel>>
      _f$next24Hours =
      Field('next24Hours', _$next24Hours, opt: true, def: const []);
  static List<HourlyForecastModel> _$day1(HourlyForecastState v) => v.day1;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day1 =
      Field('day1', _$day1, opt: true, def: const []);
  static List<HourlyForecastModel> _$day2(HourlyForecastState v) => v.day2;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day2 =
      Field('day2', _$day2, opt: true, def: const []);
  static List<HourlyForecastModel> _$day3(HourlyForecastState v) => v.day3;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day3 =
      Field('day3', _$day3, opt: true, def: const []);
  static List<HourlyForecastModel> _$day4(HourlyForecastState v) => v.day4;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day4 =
      Field('day4', _$day4, opt: true, def: const []);
  static List<HourlyForecastModel> _$day5(HourlyForecastState v) => v.day5;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day5 =
      Field('day5', _$day5, opt: true, def: const []);
  static List<HourlyForecastModel> _$day6(HourlyForecastState v) => v.day6;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day6 =
      Field('day6', _$day6, opt: true, def: const []);
  static List<HourlyForecastModel> _$day7(HourlyForecastState v) => v.day7;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day7 =
      Field('day7', _$day7, opt: true, def: const []);
  static List<HourlyForecastModel> _$day8(HourlyForecastState v) => v.day8;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day8 =
      Field('day8', _$day8, opt: true, def: const []);
  static List<HourlyForecastModel> _$day9(HourlyForecastState v) => v.day9;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day9 =
      Field('day9', _$day9, opt: true, def: const []);
  static List<HourlyForecastModel> _$day10(HourlyForecastState v) => v.day10;
  static const Field<HourlyForecastState, List<HourlyForecastModel>> _f$day10 =
      Field('day10', _$day10, opt: true, def: const []);

  @override
  final MappableFields<HourlyForecastState> fields = const {
    #next24Hours: _f$next24Hours,
    #day1: _f$day1,
    #day2: _f$day2,
    #day3: _f$day3,
    #day4: _f$day4,
    #day5: _f$day5,
    #day6: _f$day6,
    #day7: _f$day7,
    #day8: _f$day8,
    #day9: _f$day9,
    #day10: _f$day10,
  };

  static HourlyForecastState _instantiate(DecodingData data) {
    return HourlyForecastState(
        next24Hours: data.dec(_f$next24Hours),
        day1: data.dec(_f$day1),
        day2: data.dec(_f$day2),
        day3: data.dec(_f$day3),
        day4: data.dec(_f$day4),
        day5: data.dec(_f$day5),
        day6: data.dec(_f$day6),
        day7: data.dec(_f$day7),
        day8: data.dec(_f$day8),
        day9: data.dec(_f$day9),
        day10: data.dec(_f$day10));
  }

  @override
  final Function instantiate = _instantiate;

  static HourlyForecastState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HourlyForecastState>(map);
  }

  static HourlyForecastState fromJson(String json) {
    return ensureInitialized().decodeJson<HourlyForecastState>(json);
  }
}

mixin HourlyForecastStateMappable {
  String toJson() {
    return HourlyForecastStateMapper.ensureInitialized()
        .encodeJson<HourlyForecastState>(this as HourlyForecastState);
  }

  Map<String, dynamic> toMap() {
    return HourlyForecastStateMapper.ensureInitialized()
        .encodeMap<HourlyForecastState>(this as HourlyForecastState);
  }

  HourlyForecastStateCopyWith<HourlyForecastState, HourlyForecastState,
          HourlyForecastState>
      get copyWith => _HourlyForecastStateCopyWithImpl(
          this as HourlyForecastState, $identity, $identity);
  @override
  String toString() {
    return HourlyForecastStateMapper.ensureInitialized()
        .stringifyValue(this as HourlyForecastState);
  }

  @override
  bool operator ==(Object other) {
    return HourlyForecastStateMapper.ensureInitialized()
        .equalsValue(this as HourlyForecastState, other);
  }

  @override
  int get hashCode {
    return HourlyForecastStateMapper.ensureInitialized()
        .hashValue(this as HourlyForecastState);
  }
}

extension HourlyForecastStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HourlyForecastState, $Out> {
  HourlyForecastStateCopyWith<$R, HourlyForecastState, $Out>
      get $asHourlyForecastState =>
          $base.as((v, t, t2) => _HourlyForecastStateCopyWithImpl(v, t, t2));
}

abstract class HourlyForecastStateCopyWith<$R, $In extends HourlyForecastState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get next24Hours;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day1;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day2;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day3;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day4;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day5;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day6;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day7;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day8;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day9;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day10;
  $R call(
      {List<HourlyForecastModel>? next24Hours,
      List<HourlyForecastModel>? day1,
      List<HourlyForecastModel>? day2,
      List<HourlyForecastModel>? day3,
      List<HourlyForecastModel>? day4,
      List<HourlyForecastModel>? day5,
      List<HourlyForecastModel>? day6,
      List<HourlyForecastModel>? day7,
      List<HourlyForecastModel>? day8,
      List<HourlyForecastModel>? day9,
      List<HourlyForecastModel>? day10});
  HourlyForecastStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HourlyForecastStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HourlyForecastState, $Out>
    implements HourlyForecastStateCopyWith<$R, HourlyForecastState, $Out> {
  _HourlyForecastStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HourlyForecastState> $mapper =
      HourlyForecastStateMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get next24Hours => ListCopyWith(
      $value.next24Hours,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(next24Hours: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day1 => ListCopyWith(
      $value.day1, (v, t) => v.copyWith.$chain(t), (v) => call(day1: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day2 => ListCopyWith(
      $value.day2, (v, t) => v.copyWith.$chain(t), (v) => call(day2: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day3 => ListCopyWith(
      $value.day3, (v, t) => v.copyWith.$chain(t), (v) => call(day3: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day4 => ListCopyWith(
      $value.day4, (v, t) => v.copyWith.$chain(t), (v) => call(day4: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day5 => ListCopyWith(
      $value.day5, (v, t) => v.copyWith.$chain(t), (v) => call(day5: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day6 => ListCopyWith(
      $value.day6, (v, t) => v.copyWith.$chain(t), (v) => call(day6: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day7 => ListCopyWith(
      $value.day7, (v, t) => v.copyWith.$chain(t), (v) => call(day7: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day8 => ListCopyWith(
      $value.day8, (v, t) => v.copyWith.$chain(t), (v) => call(day8: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day9 => ListCopyWith(
      $value.day9, (v, t) => v.copyWith.$chain(t), (v) => call(day9: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get day10 => ListCopyWith(
      $value.day10, (v, t) => v.copyWith.$chain(t), (v) => call(day10: v));
  @override
  $R call(
          {List<HourlyForecastModel>? next24Hours,
          List<HourlyForecastModel>? day1,
          List<HourlyForecastModel>? day2,
          List<HourlyForecastModel>? day3,
          List<HourlyForecastModel>? day4,
          List<HourlyForecastModel>? day5,
          List<HourlyForecastModel>? day6,
          List<HourlyForecastModel>? day7,
          List<HourlyForecastModel>? day8,
          List<HourlyForecastModel>? day9,
          List<HourlyForecastModel>? day10}) =>
      $apply(FieldCopyWithData({
        if (next24Hours != null) #next24Hours: next24Hours,
        if (day1 != null) #day1: day1,
        if (day2 != null) #day2: day2,
        if (day3 != null) #day3: day3,
        if (day4 != null) #day4: day4,
        if (day5 != null) #day5: day5,
        if (day6 != null) #day6: day6,
        if (day7 != null) #day7: day7,
        if (day8 != null) #day8: day8,
        if (day9 != null) #day9: day9,
        if (day10 != null) #day10: day10
      }));
  @override
  HourlyForecastState $make(CopyWithData data) => HourlyForecastState(
      next24Hours: data.get(#next24Hours, or: $value.next24Hours),
      day1: data.get(#day1, or: $value.day1),
      day2: data.get(#day2, or: $value.day2),
      day3: data.get(#day3, or: $value.day3),
      day4: data.get(#day4, or: $value.day4),
      day5: data.get(#day5, or: $value.day5),
      day6: data.get(#day6, or: $value.day6),
      day7: data.get(#day7, or: $value.day7),
      day8: data.get(#day8, or: $value.day8),
      day9: data.get(#day9, or: $value.day9),
      day10: data.get(#day10, or: $value.day10));

  @override
  HourlyForecastStateCopyWith<$R2, HourlyForecastState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HourlyForecastStateCopyWithImpl($value, $cast, t);
}
