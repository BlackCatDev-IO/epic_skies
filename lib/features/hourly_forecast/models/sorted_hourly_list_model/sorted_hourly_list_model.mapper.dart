// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'sorted_hourly_list_model.dart';

class SortedHourlyListMapper extends ClassMapperBase<SortedHourlyList> {
  SortedHourlyListMapper._();

  static SortedHourlyListMapper? _instance;
  static SortedHourlyListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SortedHourlyListMapper._());
      HourlyVerticalWidgetModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'SortedHourlyList';

  static List<HourlyVerticalWidgetModel> _$next24Hours(SortedHourlyList v) =>
      v.next24Hours;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$next24Hours =
      Field('next24Hours', _$next24Hours, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day1(SortedHourlyList v) => v.day1;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day1 = Field('day1', _$day1, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day2(SortedHourlyList v) => v.day2;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day2 = Field('day2', _$day2, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day3(SortedHourlyList v) => v.day3;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day3 = Field('day3', _$day3, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day4(SortedHourlyList v) => v.day4;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day4 = Field('day4', _$day4, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day5(SortedHourlyList v) => v.day5;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day5 = Field('day5', _$day5, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day6(SortedHourlyList v) => v.day6;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day6 = Field('day6', _$day6, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day7(SortedHourlyList v) => v.day7;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day7 = Field('day7', _$day7, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day8(SortedHourlyList v) => v.day8;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day8 = Field('day8', _$day8, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day9(SortedHourlyList v) => v.day9;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day9 = Field('day9', _$day9, opt: true, def: const []);
  static List<HourlyVerticalWidgetModel> _$day10(SortedHourlyList v) => v.day10;
  static const Field<SortedHourlyList, List<HourlyVerticalWidgetModel>>
      _f$day10 = Field('day10', _$day10, opt: true, def: const []);

  @override
  final Map<Symbol, Field<SortedHourlyList, dynamic>> fields = const {
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

  static SortedHourlyList _instantiate(DecodingData data) {
    return SortedHourlyList(
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

  static SortedHourlyList fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<SortedHourlyList>(map));
  }

  static SortedHourlyList fromJson(String json) {
    return _guard((c) => c.fromJson<SortedHourlyList>(json));
  }
}

mixin SortedHourlyListMappable {
  String toJson() {
    return SortedHourlyListMapper._guard(
        (c) => c.toJson(this as SortedHourlyList));
  }

  Map<String, dynamic> toMap() {
    return SortedHourlyListMapper._guard(
        (c) => c.toMap(this as SortedHourlyList));
  }

  SortedHourlyListCopyWith<SortedHourlyList, SortedHourlyList, SortedHourlyList>
      get copyWith => _SortedHourlyListCopyWithImpl(
          this as SortedHourlyList, $identity, $identity);
  @override
  String toString() {
    return SortedHourlyListMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SortedHourlyListMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return SortedHourlyListMapper._guard((c) => c.hash(this));
  }
}

extension SortedHourlyListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SortedHourlyList, $Out> {
  SortedHourlyListCopyWith<$R, SortedHourlyList, $Out>
      get $asSortedHourlyList =>
          $base.as((v, t, t2) => _SortedHourlyListCopyWithImpl(v, t, t2));
}

abstract class SortedHourlyListCopyWith<$R, $In extends SortedHourlyList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get next24Hours;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day1;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day2;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day3;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day4;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day5;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day6;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day7;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day8;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day9;
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day10;
  $R call(
      {List<HourlyVerticalWidgetModel>? next24Hours,
      List<HourlyVerticalWidgetModel>? day1,
      List<HourlyVerticalWidgetModel>? day2,
      List<HourlyVerticalWidgetModel>? day3,
      List<HourlyVerticalWidgetModel>? day4,
      List<HourlyVerticalWidgetModel>? day5,
      List<HourlyVerticalWidgetModel>? day6,
      List<HourlyVerticalWidgetModel>? day7,
      List<HourlyVerticalWidgetModel>? day8,
      List<HourlyVerticalWidgetModel>? day9,
      List<HourlyVerticalWidgetModel>? day10});
  SortedHourlyListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SortedHourlyListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SortedHourlyList, $Out>
    implements SortedHourlyListCopyWith<$R, SortedHourlyList, $Out> {
  _SortedHourlyListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SortedHourlyList> $mapper =
      SortedHourlyListMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get next24Hours => ListCopyWith(
      $value.next24Hours,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(next24Hours: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day1 => ListCopyWith(
      $value.day1, (v, t) => v.copyWith.$chain(t), (v) => call(day1: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day2 => ListCopyWith(
      $value.day2, (v, t) => v.copyWith.$chain(t), (v) => call(day2: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day3 => ListCopyWith(
      $value.day3, (v, t) => v.copyWith.$chain(t), (v) => call(day3: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day4 => ListCopyWith(
      $value.day4, (v, t) => v.copyWith.$chain(t), (v) => call(day4: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day5 => ListCopyWith(
      $value.day5, (v, t) => v.copyWith.$chain(t), (v) => call(day5: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day6 => ListCopyWith(
      $value.day6, (v, t) => v.copyWith.$chain(t), (v) => call(day6: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day7 => ListCopyWith(
      $value.day7, (v, t) => v.copyWith.$chain(t), (v) => call(day7: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day8 => ListCopyWith(
      $value.day8, (v, t) => v.copyWith.$chain(t), (v) => call(day8: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day9 => ListCopyWith(
      $value.day9, (v, t) => v.copyWith.$chain(t), (v) => call(day9: v));
  @override
  ListCopyWith<
      $R,
      HourlyVerticalWidgetModel,
      HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel>> get day10 => ListCopyWith(
      $value.day10, (v, t) => v.copyWith.$chain(t), (v) => call(day10: v));
  @override
  $R call(
          {List<HourlyVerticalWidgetModel>? next24Hours,
          List<HourlyVerticalWidgetModel>? day1,
          List<HourlyVerticalWidgetModel>? day2,
          List<HourlyVerticalWidgetModel>? day3,
          List<HourlyVerticalWidgetModel>? day4,
          List<HourlyVerticalWidgetModel>? day5,
          List<HourlyVerticalWidgetModel>? day6,
          List<HourlyVerticalWidgetModel>? day7,
          List<HourlyVerticalWidgetModel>? day8,
          List<HourlyVerticalWidgetModel>? day9,
          List<HourlyVerticalWidgetModel>? day10}) =>
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
  SortedHourlyList $make(CopyWithData data) => SortedHourlyList(
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
  SortedHourlyListCopyWith<$R2, SortedHourlyList, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SortedHourlyListCopyWithImpl($value, $cast, t);
}
