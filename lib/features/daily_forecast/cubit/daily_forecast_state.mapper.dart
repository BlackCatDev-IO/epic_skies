// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'daily_forecast_state.dart';

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
  static List<DailyNavButtonModel> _$week1NavButtonList(DailyForecastState v) =>
      v.week1NavButtonList;
  static const Field<DailyForecastState, List<DailyNavButtonModel>>
      _f$week1NavButtonList = Field('week1NavButtonList', _$week1NavButtonList);
  static List<DailyNavButtonModel> _$week2NavButtonList(DailyForecastState v) =>
      v.week2NavButtonList;
  static const Field<DailyForecastState, List<DailyNavButtonModel>>
      _f$week2NavButtonList = Field('week2NavButtonList', _$week2NavButtonList);
  static List<String> _$dayLabelList(DailyForecastState v) => v.dayLabelList;
  static const Field<DailyForecastState, List<String>> _f$dayLabelList =
      Field('dayLabelList', _$dayLabelList);
  static List<bool> _$selectedDayList(DailyForecastState v) =>
      v.selectedDayList;
  static const Field<DailyForecastState, List<bool>> _f$selectedDayList =
      Field('selectedDayList', _$selectedDayList);
  static int _$selectedDayIndex(DailyForecastState v) => v.selectedDayIndex;
  static const Field<DailyForecastState, int> _f$selectedDayIndex =
      Field('selectedDayIndex', _$selectedDayIndex);

  @override
  final MappableFields<DailyForecastState> fields = const {
    #dayColumnModelList: _f$dayColumnModelList,
    #dailyForecastModelList: _f$dailyForecastModelList,
    #week1NavButtonList: _f$week1NavButtonList,
    #week2NavButtonList: _f$week2NavButtonList,
    #dayLabelList: _f$dayLabelList,
    #selectedDayList: _f$selectedDayList,
    #selectedDayIndex: _f$selectedDayIndex,
  };

  static DailyForecastState _instantiate(DecodingData data) {
    return DailyForecastState(
        dayColumnModelList: data.dec(_f$dayColumnModelList),
        dailyForecastModelList: data.dec(_f$dailyForecastModelList),
        week1NavButtonList: data.dec(_f$week1NavButtonList),
        week2NavButtonList: data.dec(_f$week2NavButtonList),
        dayLabelList: data.dec(_f$dayLabelList),
        selectedDayList: data.dec(_f$selectedDayList),
        selectedDayIndex: data.dec(_f$selectedDayIndex));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DailyForecastStateMapper.ensureInitialized()
                .isValueEqual(this as DailyForecastState, other));
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
          DailyNavButtonModel>> get week1NavButtonList;
  ListCopyWith<
      $R,
      DailyNavButtonModel,
      DailyNavButtonModelCopyWith<$R, DailyNavButtonModel,
          DailyNavButtonModel>> get week2NavButtonList;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get dayLabelList;
  ListCopyWith<$R, bool, ObjectCopyWith<$R, bool, bool>> get selectedDayList;
  $R call(
      {List<DailyScrollWidgetModel>? dayColumnModelList,
      List<DailyForecastModel>? dailyForecastModelList,
      List<DailyNavButtonModel>? week1NavButtonList,
      List<DailyNavButtonModel>? week2NavButtonList,
      List<String>? dayLabelList,
      List<bool>? selectedDayList,
      int? selectedDayIndex});
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
          DailyNavButtonModel>> get week1NavButtonList => ListCopyWith(
      $value.week1NavButtonList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(week1NavButtonList: v));
  @override
  ListCopyWith<
      $R,
      DailyNavButtonModel,
      DailyNavButtonModelCopyWith<$R, DailyNavButtonModel,
          DailyNavButtonModel>> get week2NavButtonList => ListCopyWith(
      $value.week2NavButtonList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(week2NavButtonList: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get dayLabelList => ListCopyWith(
          $value.dayLabelList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(dayLabelList: v));
  @override
  ListCopyWith<$R, bool, ObjectCopyWith<$R, bool, bool>> get selectedDayList =>
      ListCopyWith(
          $value.selectedDayList,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(selectedDayList: v));
  @override
  $R call(
          {List<DailyScrollWidgetModel>? dayColumnModelList,
          List<DailyForecastModel>? dailyForecastModelList,
          List<DailyNavButtonModel>? week1NavButtonList,
          List<DailyNavButtonModel>? week2NavButtonList,
          List<String>? dayLabelList,
          List<bool>? selectedDayList,
          int? selectedDayIndex}) =>
      $apply(FieldCopyWithData({
        if (dayColumnModelList != null) #dayColumnModelList: dayColumnModelList,
        if (dailyForecastModelList != null)
          #dailyForecastModelList: dailyForecastModelList,
        if (week1NavButtonList != null) #week1NavButtonList: week1NavButtonList,
        if (week2NavButtonList != null) #week2NavButtonList: week2NavButtonList,
        if (dayLabelList != null) #dayLabelList: dayLabelList,
        if (selectedDayList != null) #selectedDayList: selectedDayList,
        if (selectedDayIndex != null) #selectedDayIndex: selectedDayIndex
      }));
  @override
  DailyForecastState $make(CopyWithData data) => DailyForecastState(
      dayColumnModelList:
          data.get(#dayColumnModelList, or: $value.dayColumnModelList),
      dailyForecastModelList:
          data.get(#dailyForecastModelList, or: $value.dailyForecastModelList),
      week1NavButtonList:
          data.get(#week1NavButtonList, or: $value.week1NavButtonList),
      week2NavButtonList:
          data.get(#week2NavButtonList, or: $value.week2NavButtonList),
      dayLabelList: data.get(#dayLabelList, or: $value.dayLabelList),
      selectedDayList: data.get(#selectedDayList, or: $value.selectedDayList),
      selectedDayIndex:
          data.get(#selectedDayIndex, or: $value.selectedDayIndex));

  @override
  DailyForecastStateCopyWith<$R2, DailyForecastState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DailyForecastStateCopyWithImpl($value, $cast, t);
}
