// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hourly_forecast_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HourlyForecastState _$HourlyForecastStateFromJson(Map<String, dynamic> json) {
  return _HourlyForecastState.fromJson(json);
}

/// @nodoc
mixin _$HourlyForecastState {
  List<HourlyForecastModel> get houryForecastModelList =>
      throw _privateConstructorUsedError;
  SortedHourlyList get sortedHourlyList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HourlyForecastStateCopyWith<HourlyForecastState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyForecastStateCopyWith<$Res> {
  factory $HourlyForecastStateCopyWith(
          HourlyForecastState value, $Res Function(HourlyForecastState) then) =
      _$HourlyForecastStateCopyWithImpl<$Res, HourlyForecastState>;
  @useResult
  $Res call(
      {List<HourlyForecastModel> houryForecastModelList,
      SortedHourlyList sortedHourlyList});

  $SortedHourlyListCopyWith<$Res> get sortedHourlyList;
}

/// @nodoc
class _$HourlyForecastStateCopyWithImpl<$Res, $Val extends HourlyForecastState>
    implements $HourlyForecastStateCopyWith<$Res> {
  _$HourlyForecastStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houryForecastModelList = null,
    Object? sortedHourlyList = null,
  }) {
    return _then(_value.copyWith(
      houryForecastModelList: null == houryForecastModelList
          ? _value.houryForecastModelList
          : houryForecastModelList // ignore: cast_nullable_to_non_nullable
              as List<HourlyForecastModel>,
      sortedHourlyList: null == sortedHourlyList
          ? _value.sortedHourlyList
          : sortedHourlyList // ignore: cast_nullable_to_non_nullable
              as SortedHourlyList,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SortedHourlyListCopyWith<$Res> get sortedHourlyList {
    return $SortedHourlyListCopyWith<$Res>(_value.sortedHourlyList, (value) {
      return _then(_value.copyWith(sortedHourlyList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_HourlyForecastStateCopyWith<$Res>
    implements $HourlyForecastStateCopyWith<$Res> {
  factory _$$_HourlyForecastStateCopyWith(_$_HourlyForecastState value,
          $Res Function(_$_HourlyForecastState) then) =
      __$$_HourlyForecastStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<HourlyForecastModel> houryForecastModelList,
      SortedHourlyList sortedHourlyList});

  @override
  $SortedHourlyListCopyWith<$Res> get sortedHourlyList;
}

/// @nodoc
class __$$_HourlyForecastStateCopyWithImpl<$Res>
    extends _$HourlyForecastStateCopyWithImpl<$Res, _$_HourlyForecastState>
    implements _$$_HourlyForecastStateCopyWith<$Res> {
  __$$_HourlyForecastStateCopyWithImpl(_$_HourlyForecastState _value,
      $Res Function(_$_HourlyForecastState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houryForecastModelList = null,
    Object? sortedHourlyList = null,
  }) {
    return _then(_$_HourlyForecastState(
      houryForecastModelList: null == houryForecastModelList
          ? _value._houryForecastModelList
          : houryForecastModelList // ignore: cast_nullable_to_non_nullable
              as List<HourlyForecastModel>,
      sortedHourlyList: null == sortedHourlyList
          ? _value.sortedHourlyList
          : sortedHourlyList // ignore: cast_nullable_to_non_nullable
              as SortedHourlyList,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HourlyForecastState implements _HourlyForecastState {
  _$_HourlyForecastState(
      {final List<HourlyForecastModel> houryForecastModelList = const [],
      this.sortedHourlyList = const SortedHourlyList()})
      : _houryForecastModelList = houryForecastModelList;

  factory _$_HourlyForecastState.fromJson(Map<String, dynamic> json) =>
      _$$_HourlyForecastStateFromJson(json);

  final List<HourlyForecastModel> _houryForecastModelList;
  @override
  @JsonKey()
  List<HourlyForecastModel> get houryForecastModelList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_houryForecastModelList);
  }

  @override
  @JsonKey()
  final SortedHourlyList sortedHourlyList;

  @override
  String toString() {
    return 'HourlyForecastState(houryForecastModelList: $houryForecastModelList, sortedHourlyList: $sortedHourlyList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HourlyForecastState &&
            const DeepCollectionEquality().equals(
                other._houryForecastModelList, _houryForecastModelList) &&
            (identical(other.sortedHourlyList, sortedHourlyList) ||
                other.sortedHourlyList == sortedHourlyList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_houryForecastModelList),
      sortedHourlyList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HourlyForecastStateCopyWith<_$_HourlyForecastState> get copyWith =>
      __$$_HourlyForecastStateCopyWithImpl<_$_HourlyForecastState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HourlyForecastStateToJson(
      this,
    );
  }
}

abstract class _HourlyForecastState implements HourlyForecastState {
  factory _HourlyForecastState(
      {final List<HourlyForecastModel> houryForecastModelList,
      final SortedHourlyList sortedHourlyList}) = _$_HourlyForecastState;

  factory _HourlyForecastState.fromJson(Map<String, dynamic> json) =
      _$_HourlyForecastState.fromJson;

  @override
  List<HourlyForecastModel> get houryForecastModelList;
  @override
  SortedHourlyList get sortedHourlyList;
  @override
  @JsonKey(ignore: true)
  _$$_HourlyForecastStateCopyWith<_$_HourlyForecastState> get copyWith =>
      throw _privateConstructorUsedError;
}
