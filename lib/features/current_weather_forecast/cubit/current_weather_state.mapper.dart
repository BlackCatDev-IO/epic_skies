// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'current_weather_state.dart';

class CurrentWeatherStateMapper extends ClassMapperBase<CurrentWeatherState> {
  CurrentWeatherStateMapper._();

  static CurrentWeatherStateMapper? _instance;
  static CurrentWeatherStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrentWeatherStateMapper._());
      CurrentWeatherModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CurrentWeatherState';

  static String _$currentTimeString(CurrentWeatherState v) =>
      v.currentTimeString;
  static const Field<CurrentWeatherState, String> _f$currentTimeString =
      Field('currentTimeString', _$currentTimeString);
  static CurrentWeatherModel? _$data(CurrentWeatherState v) => v.data;
  static const Field<CurrentWeatherState, CurrentWeatherModel> _f$data =
      Field('data', _$data, opt: true);

  @override
  final MappableFields<CurrentWeatherState> fields = const {
    #currentTimeString: _f$currentTimeString,
    #data: _f$data,
  };

  static CurrentWeatherState _instantiate(DecodingData data) {
    return CurrentWeatherState(
        currentTimeString: data.dec(_f$currentTimeString),
        data: data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static CurrentWeatherState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CurrentWeatherState>(map);
  }

  static CurrentWeatherState fromJson(String json) {
    return ensureInitialized().decodeJson<CurrentWeatherState>(json);
  }
}

mixin CurrentWeatherStateMappable {
  String toJson() {
    return CurrentWeatherStateMapper.ensureInitialized()
        .encodeJson<CurrentWeatherState>(this as CurrentWeatherState);
  }

  Map<String, dynamic> toMap() {
    return CurrentWeatherStateMapper.ensureInitialized()
        .encodeMap<CurrentWeatherState>(this as CurrentWeatherState);
  }

  CurrentWeatherStateCopyWith<CurrentWeatherState, CurrentWeatherState,
          CurrentWeatherState>
      get copyWith => _CurrentWeatherStateCopyWithImpl(
          this as CurrentWeatherState, $identity, $identity);
  @override
  String toString() {
    return CurrentWeatherStateMapper.ensureInitialized()
        .stringifyValue(this as CurrentWeatherState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CurrentWeatherStateMapper.ensureInitialized()
                .isValueEqual(this as CurrentWeatherState, other));
  }

  @override
  int get hashCode {
    return CurrentWeatherStateMapper.ensureInitialized()
        .hashValue(this as CurrentWeatherState);
  }
}

extension CurrentWeatherStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrentWeatherState, $Out> {
  CurrentWeatherStateCopyWith<$R, CurrentWeatherState, $Out>
      get $asCurrentWeatherState =>
          $base.as((v, t, t2) => _CurrentWeatherStateCopyWithImpl(v, t, t2));
}

abstract class CurrentWeatherStateCopyWith<$R, $In extends CurrentWeatherState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  CurrentWeatherModelCopyWith<$R, CurrentWeatherModel, CurrentWeatherModel>?
      get data;
  $R call({String? currentTimeString, CurrentWeatherModel? data});
  CurrentWeatherStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CurrentWeatherStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrentWeatherState, $Out>
    implements CurrentWeatherStateCopyWith<$R, CurrentWeatherState, $Out> {
  _CurrentWeatherStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrentWeatherState> $mapper =
      CurrentWeatherStateMapper.ensureInitialized();
  @override
  CurrentWeatherModelCopyWith<$R, CurrentWeatherModel, CurrentWeatherModel>?
      get data => $value.data?.copyWith.$chain((v) => call(data: v));
  @override
  $R call({String? currentTimeString, Object? data = $none}) =>
      $apply(FieldCopyWithData({
        if (currentTimeString != null) #currentTimeString: currentTimeString,
        if (data != $none) #data: data
      }));
  @override
  CurrentWeatherState $make(CopyWithData data) => CurrentWeatherState(
      currentTimeString:
          data.get(#currentTimeString, or: $value.currentTimeString),
      data: data.get(#data, or: $value.data));

  @override
  CurrentWeatherStateCopyWith<$R2, CurrentWeatherState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CurrentWeatherStateCopyWithImpl($value, $cast, t);
}
