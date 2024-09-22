// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'daily_forecast_cubit.dart';

class DailyForecastStateMapper extends ClassMapperBase<DailyForecastState> {
  DailyForecastStateMapper._();

  static DailyForecastStateMapper? _instance;
  static DailyForecastStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyForecastStateMapper._());
      DailyScrollWidgetModelMapper.ensureInitialized();
      DailyForecastModelMapper.ensureInitialized();
      DailyNavButtonModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DailyForecastState';

  static List<DailyScrollWidgetModel> _$dayColumnModelList(
          DailyForecastState v) =>
      v.dayColumnModelList;
  static const Field<DailyForecastState, List<DailyScrollWidgetModel>>
      _f$dayColumnModelList = Field('dayColumnModelList', _$dayColumnModelList);
  static List<DailyForecastModel> _$dailyForecastModelList(
          DailyForecastState v) =>
      v.dailyForecastModelList;
  static const Field<DailyForecastState, List<DailyForecastModel>>
      _f$dailyForecastModelList =
      Field('dailyForecastModelList', _$dailyForecastModelList);
  static List<DailyNavButtonModel> _$navButtonModelList(DailyForecastState v) =>
      v.navButtonModelList;
  static const Field<DailyForecastState, List<DailyNavButtonModel>>
      _f$navButtonModelList = Field('navButtonModelList', _$navButtonModelList);
  static List<String> _$dayLabelList(DailyForecastState v) => v.dayLabelList;
  static const Field<DailyForecastState, List<String>> _f$dayLabelList =
      Field('dayLabelList', _$dayLabelList);

  @override
  final MappableFields<DailyForecastState> fields = const {
    #dayColumnModelList: _f$dayColumnModelList,
    #dailyForecastModelList: _f$dailyForecastModelList,
    #navButtonModelList: _f$navButtonModelList,
    #dayLabelList: _f$dayLabelList,
  };

  static DailyForecastState _instantiate(DecodingData data) {
    return DailyForecastState(
        dayColumnModelList: data.dec(_f$dayColumnModelList),
        dailyForecastModelList: data.dec(_f$dailyForecastModelList),
        navButtonModelList: data.dec(_f$navButtonModelList),
        dayLabelList: data.dec(_f$dayLabelList));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyForecastState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyForecastState>(map);
  }

  static DailyForecastState fromJson(String json) {
    return ensureInitialized().decodeJson<DailyForecastState>(json);
  }
}

mixin DailyForecastStateMappable {
  String toJson() {
    return DailyForecastStateMapper.ensureInitialized()
        .encodeJson<DailyForecastState>(this as DailyForecastState);
  }

  Map<String, dynamic> toMap() {
    return DailyForecastStateMapper.ensureInitialized()
        .encodeMap<DailyForecastState>(this as DailyForecastState);
  }

  DailyForecastStateCopyWith<DailyForecastState, DailyForecastState,
          DailyForecastState>
      get copyWith => _DailyForecastStateCopyWithImpl(
          this as DailyForecastState, $identity, $identity);
  @override
  String toString() {
    return DailyForecastStateMapper.ensureInitialized()
        .stringifyValue(this as DailyForecastState);
  }

  @override
  bool operator ==(Object other) {
    return DailyForecastStateMapper.ensureInitialized()
        .equalsValue(this as DailyForecastState, other);
  }

  @override
  int get hashCode {
    return DailyForecastStateMapper.ensureInitialized()
        .hashValue(this as DailyForecastState);
  }
}

extension DailyForecastStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyForecastState, $Out> {
  DailyForecastStateCopyWith<$R, DailyForecastState, $Out>
      get $asDailyForecastState =>
          $base.as((v, t, t2) => _DailyForecastStateCopyWithImpl(v, t, t2));
}

abstract class DailyForecastStateCopyWith<$R, $In extends DailyForecastState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      DailyScrollWidgetModel,
      DailyScrollWidgetModelCopyWith<$R, DailyScrollWidgetModel,
          DailyScrollWidgetModel>> get dayColumnModelList;
  ListCopyWith<
      $R,
      DailyForecastModel,
      DailyForecastModelCopyWith<$R, DailyForecastModel,
          DailyForecastModel>> get dailyForecastModelList;
  ListCopyWith<
      $R,
      DailyNavButtonModel,
      DailyNavButtonModelCopyWith<$R, DailyNavButtonModel,
          DailyNavButtonModel>> get navButtonModelList;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get dayLabelList;
  $R call(
      {List<DailyScrollWidgetModel>? dayColumnModelList,
      List<DailyForecastModel>? dailyForecastModelList,
      List<DailyNavButtonModel>? navButtonModelList,
      List<String>? dayLabelList});
  DailyForecastStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DailyForecastStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyForecastState, $Out>
    implements DailyForecastStateCopyWith<$R, DailyForecastState, $Out> {
  _DailyForecastStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyForecastState> $mapper =
      DailyForecastStateMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      DailyScrollWidgetModel,
      DailyScrollWidgetModelCopyWith<$R, DailyScrollWidgetModel,
          DailyScrollWidgetModel>> get dayColumnModelList => ListCopyWith(
      $value.dayColumnModelList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(dayColumnModelList: v));
  @override
  ListCopyWith<
      $R,
      DailyForecastModel,
      DailyForecastModelCopyWith<$R, DailyForecastModel,
          DailyForecastModel>> get dailyForecastModelList => ListCopyWith(
      $value.dailyForecastModelList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(dailyForecastModelList: v));
  @override
  ListCopyWith<
      $R,
      DailyNavButtonModel,
      DailyNavButtonModelCopyWith<$R, DailyNavButtonModel,
          DailyNavButtonModel>> get navButtonModelList => ListCopyWith(
      $value.navButtonModelList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(navButtonModelList: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get dayLabelList => ListCopyWith(
          $value.dayLabelList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(dayLabelList: v));
  @override
  $R call(
          {List<DailyScrollWidgetModel>? dayColumnModelList,
          List<DailyForecastModel>? dailyForecastModelList,
          List<DailyNavButtonModel>? navButtonModelList,
          List<String>? dayLabelList}) =>
      $apply(FieldCopyWithData({
        if (dayColumnModelList != null) #dayColumnModelList: dayColumnModelList,
        if (dailyForecastModelList != null)
          #dailyForecastModelList: dailyForecastModelList,
        if (navButtonModelList != null) #navButtonModelList: navButtonModelList,
        if (dayLabelList != null) #dayLabelList: dayLabelList
      }));
  @override
  DailyForecastState $make(CopyWithData data) => DailyForecastState(
      dayColumnModelList:
          data.get(#dayColumnModelList, or: $value.dayColumnModelList),
      dailyForecastModelList:
          data.get(#dailyForecastModelList, or: $value.dailyForecastModelList),
      navButtonModelList:
          data.get(#navButtonModelList, or: $value.navButtonModelList),
      dayLabelList: data.get(#dayLabelList, or: $value.dayLabelList));

  @override
  DailyForecastStateCopyWith<$R2, DailyForecastState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DailyForecastStateCopyWithImpl($value, $cast, t);
}
