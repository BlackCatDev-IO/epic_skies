// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

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

  @override
  final String id = 'DailyNavButtonModel';

  static String _$day(DailyNavButtonModel v) => v.day;
  static const Field<DailyNavButtonModel, String> _f$day = Field('day', _$day);
  static String _$month(DailyNavButtonModel v) => v.month;
  static const Field<DailyNavButtonModel, String> _f$month =
      Field('month', _$month);
  static int _$date(DailyNavButtonModel v) => v.date;
  static const Field<DailyNavButtonModel, int> _f$date = Field('date', _$date);
  static bool _$isSelected(DailyNavButtonModel v) => v.isSelected;
  static const Field<DailyNavButtonModel, bool> _f$isSelected =
      Field('isSelected', _$isSelected, opt: true, def: false);

  @override
  final MappableFields<DailyNavButtonModel> fields = const {
    #day: _f$day,
    #month: _f$month,
    #date: _f$date,
    #isSelected: _f$isSelected,
  };

  static DailyNavButtonModel _instantiate(DecodingData data) {
    return DailyNavButtonModel(
        day: data.dec(_f$day),
        month: data.dec(_f$month),
        date: data.dec(_f$date),
        isSelected: data.dec(_f$isSelected));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyNavButtonModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyNavButtonModel>(map);
  }

  static DailyNavButtonModel fromJson(String json) {
    return ensureInitialized().decodeJson<DailyNavButtonModel>(json);
  }
}

mixin DailyNavButtonModelMappable {
  String toJson() {
    return DailyNavButtonModelMapper.ensureInitialized()
        .encodeJson<DailyNavButtonModel>(this as DailyNavButtonModel);
  }

  Map<String, dynamic> toMap() {
    return DailyNavButtonModelMapper.ensureInitialized()
        .encodeMap<DailyNavButtonModel>(this as DailyNavButtonModel);
  }

  DailyNavButtonModelCopyWith<DailyNavButtonModel, DailyNavButtonModel,
          DailyNavButtonModel>
      get copyWith => _DailyNavButtonModelCopyWithImpl(
          this as DailyNavButtonModel, $identity, $identity);
  @override
  String toString() {
    return DailyNavButtonModelMapper.ensureInitialized()
        .stringifyValue(this as DailyNavButtonModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DailyNavButtonModelMapper.ensureInitialized()
                .isValueEqual(this as DailyNavButtonModel, other));
  }

  @override
  int get hashCode {
    return DailyNavButtonModelMapper.ensureInitialized()
        .hashValue(this as DailyNavButtonModel);
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
  $R call({String? day, String? month, int? date, bool? isSelected});
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
  $R call({String? day, String? month, int? date, bool? isSelected}) =>
      $apply(FieldCopyWithData({
        if (day != null) #day: day,
        if (month != null) #month: month,
        if (date != null) #date: date,
        if (isSelected != null) #isSelected: isSelected
      }));
  @override
  DailyNavButtonModel $make(CopyWithData data) => DailyNavButtonModel(
      day: data.get(#day, or: $value.day),
      month: data.get(#month, or: $value.month),
      date: data.get(#date, or: $value.date),
      isSelected: data.get(#isSelected, or: $value.isSelected));

  @override
  DailyNavButtonModelCopyWith<$R2, DailyNavButtonModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DailyNavButtonModelCopyWithImpl($value, $cast, t);
}
