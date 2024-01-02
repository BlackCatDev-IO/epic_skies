// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'daily_nav_button_model.dart';

class DailyNavButtonModelMapper extends ClassMapperBase<DailyNavButtonModel> {
  DailyNavButtonModelMapper._();

  static DailyNavButtonModelMapper? _instance;
  static DailyNavButtonModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyNavButtonModelMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'DailyNavButtonModel';

  static String _$day(DailyNavButtonModel v) => v.day;
  static const Field<DailyNavButtonModel, String> _f$day = Field('day', _$day);
  static String _$month(DailyNavButtonModel v) => v.month;
  static const Field<DailyNavButtonModel, String> _f$month =
      Field('month', _$month);
  static String _$date(DailyNavButtonModel v) => v.date;
  static const Field<DailyNavButtonModel, String> _f$date =
      Field('date', _$date);
  static int _$index(DailyNavButtonModel v) => v.index;
  static const Field<DailyNavButtonModel, int> _f$index =
      Field('index', _$index);

  @override
  final Map<Symbol, Field<DailyNavButtonModel, dynamic>> fields = const {
    #day: _f$day,
    #month: _f$month,
    #date: _f$date,
    #index: _f$index,
  };

  static DailyNavButtonModel _instantiate(DecodingData data) {
    return DailyNavButtonModel(
        day: data.dec(_f$day),
        month: data.dec(_f$month),
        date: data.dec(_f$date),
        index: data.dec(_f$index));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyNavButtonModel fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<DailyNavButtonModel>(map));
  }

  static DailyNavButtonModel fromJson(String json) {
    return _guard((c) => c.fromJson<DailyNavButtonModel>(json));
  }
}

mixin DailyNavButtonModelMappable {
  String toJson() {
    return DailyNavButtonModelMapper._guard(
        (c) => c.toJson(this as DailyNavButtonModel));
  }

  Map<String, dynamic> toMap() {
    return DailyNavButtonModelMapper._guard(
        (c) => c.toMap(this as DailyNavButtonModel));
  }

  DailyNavButtonModelCopyWith<DailyNavButtonModel, DailyNavButtonModel,
          DailyNavButtonModel>
      get copyWith => _DailyNavButtonModelCopyWithImpl(
          this as DailyNavButtonModel, $identity, $identity);
  @override
  String toString() {
    return DailyNavButtonModelMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DailyNavButtonModelMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return DailyNavButtonModelMapper._guard((c) => c.hash(this));
  }
}

extension DailyNavButtonModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyNavButtonModel, $Out> {
  DailyNavButtonModelCopyWith<$R, DailyNavButtonModel, $Out>
      get $asDailyNavButtonModel =>
          $base.as((v, t, t2) => _DailyNavButtonModelCopyWithImpl(v, t, t2));
}

abstract class DailyNavButtonModelCopyWith<$R, $In extends DailyNavButtonModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? day, String? month, String? date, int? index});
  DailyNavButtonModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DailyNavButtonModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyNavButtonModel, $Out>
    implements DailyNavButtonModelCopyWith<$R, DailyNavButtonModel, $Out> {
  _DailyNavButtonModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyNavButtonModel> $mapper =
      DailyNavButtonModelMapper.ensureInitialized();
  @override
  $R call({String? day, String? month, String? date, int? index}) =>
      $apply(FieldCopyWithData({
        if (day != null) #day: day,
        if (month != null) #month: month,
        if (date != null) #date: date,
        if (index != null) #index: index
      }));
  @override
  DailyNavButtonModel $make(CopyWithData data) => DailyNavButtonModel(
      day: data.get(#day, or: $value.day),
      month: data.get(#month, or: $value.month),
      date: data.get(#date, or: $value.date),
      index: data.get(#index, or: $value.index));

  @override
  DailyNavButtonModelCopyWith<$R2, DailyNavButtonModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DailyNavButtonModelCopyWithImpl($value, $cast, t);
}
