// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'hourly_forecast_state.dart';

class HourlyForecastStateMapper extends ClassMapperBase<HourlyForecastState> {
  HourlyForecastStateMapper._();

  static HourlyForecastStateMapper? _instance;
  static HourlyForecastStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HourlyForecastStateMapper._());
      SortedHourlyListMapper.ensureInitialized();
      HourlyForecastModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'HourlyForecastState';

  static SortedHourlyList _$sortedHourlyList(HourlyForecastState v) =>
      v.sortedHourlyList;
  static const Field<HourlyForecastState, SortedHourlyList>
      _f$sortedHourlyList = Field('sortedHourlyList', _$sortedHourlyList,
          opt: true, def: const SortedHourlyList());
  static List<HourlyForecastModel> _$houryForecastModelList(
          HourlyForecastState v) =>
      v.houryForecastModelList;
  static const Field<HourlyForecastState, List<HourlyForecastModel>>
      _f$houryForecastModelList = Field(
          'houryForecastModelList', _$houryForecastModelList,
          opt: true, def: const []);

  @override
  final Map<Symbol, Field<HourlyForecastState, dynamic>> fields = const {
    #sortedHourlyList: _f$sortedHourlyList,
    #houryForecastModelList: _f$houryForecastModelList,
  };

  static HourlyForecastState _instantiate(DecodingData data) {
    return HourlyForecastState(
        sortedHourlyList: data.dec(_f$sortedHourlyList),
        houryForecastModelList: data.dec(_f$houryForecastModelList));
  }

  @override
  final Function instantiate = _instantiate;

  static HourlyForecastState fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<HourlyForecastState>(map));
  }

  static HourlyForecastState fromJson(String json) {
    return _guard((c) => c.fromJson<HourlyForecastState>(json));
  }
}

mixin HourlyForecastStateMappable {
  String toJson() {
    return HourlyForecastStateMapper._guard(
        (c) => c.toJson(this as HourlyForecastState));
  }

  Map<String, dynamic> toMap() {
    return HourlyForecastStateMapper._guard(
        (c) => c.toMap(this as HourlyForecastState));
  }

  HourlyForecastStateCopyWith<HourlyForecastState, HourlyForecastState,
          HourlyForecastState>
      get copyWith => _HourlyForecastStateCopyWithImpl(
          this as HourlyForecastState, $identity, $identity);
  @override
  String toString() {
    return HourlyForecastStateMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            HourlyForecastStateMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return HourlyForecastStateMapper._guard((c) => c.hash(this));
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
  SortedHourlyListCopyWith<$R, SortedHourlyList, SortedHourlyList>
      get sortedHourlyList;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get houryForecastModelList;
  $R call(
      {SortedHourlyList? sortedHourlyList,
      List<HourlyForecastModel>? houryForecastModelList});
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
  SortedHourlyListCopyWith<$R, SortedHourlyList, SortedHourlyList>
      get sortedHourlyList => $value.sortedHourlyList.copyWith
          .$chain((v) => call(sortedHourlyList: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get houryForecastModelList => ListCopyWith(
      $value.houryForecastModelList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(houryForecastModelList: v));
  @override
  $R call(
          {SortedHourlyList? sortedHourlyList,
          List<HourlyForecastModel>? houryForecastModelList}) =>
      $apply(FieldCopyWithData({
        if (sortedHourlyList != null) #sortedHourlyList: sortedHourlyList,
        if (houryForecastModelList != null)
          #houryForecastModelList: houryForecastModelList
      }));
  @override
  HourlyForecastState $make(CopyWithData data) => HourlyForecastState(
      sortedHourlyList:
          data.get(#sortedHourlyList, or: $value.sortedHourlyList),
      houryForecastModelList:
          data.get(#houryForecastModelList, or: $value.houryForecastModelList));

  @override
  HourlyForecastStateCopyWith<$R2, HourlyForecastState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HourlyForecastStateCopyWithImpl($value, $cast, t);
}
