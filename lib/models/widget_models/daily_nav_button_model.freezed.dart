// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'daily_nav_button_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyNavButtonModel _$DailyNavButtonModelFromJson(Map<String, dynamic> json) {
  return _DailyNavButtonModel.fromJson(json);
}

/// @nodoc
mixin _$DailyNavButtonModel {
  String get day => throw _privateConstructorUsedError;
  String get month => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyNavButtonModelCopyWith<DailyNavButtonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyNavButtonModelCopyWith<$Res> {
  factory $DailyNavButtonModelCopyWith(
          DailyNavButtonModel value, $Res Function(DailyNavButtonModel) then) =
      _$DailyNavButtonModelCopyWithImpl<$Res, DailyNavButtonModel>;
  @useResult
  $Res call({String day, String month, String date, int index});
}

/// @nodoc
class _$DailyNavButtonModelCopyWithImpl<$Res, $Val extends DailyNavButtonModel>
    implements $DailyNavButtonModelCopyWith<$Res> {
  _$DailyNavButtonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? date = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyNavButtonModelCopyWith<$Res>
    implements $DailyNavButtonModelCopyWith<$Res> {
  factory _$$_DailyNavButtonModelCopyWith(_$_DailyNavButtonModel value,
          $Res Function(_$_DailyNavButtonModel) then) =
      __$$_DailyNavButtonModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, String month, String date, int index});
}

/// @nodoc
class __$$_DailyNavButtonModelCopyWithImpl<$Res>
    extends _$DailyNavButtonModelCopyWithImpl<$Res, _$_DailyNavButtonModel>
    implements _$$_DailyNavButtonModelCopyWith<$Res> {
  __$$_DailyNavButtonModelCopyWithImpl(_$_DailyNavButtonModel _value,
      $Res Function(_$_DailyNavButtonModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? month = null,
    Object? date = null,
    Object? index = null,
  }) {
    return _then(_$_DailyNavButtonModel(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyNavButtonModel implements _DailyNavButtonModel {
  _$_DailyNavButtonModel(
      {required this.day,
      required this.month,
      required this.date,
      required this.index});

  factory _$_DailyNavButtonModel.fromJson(Map<String, dynamic> json) =>
      _$$_DailyNavButtonModelFromJson(json);

  @override
  final String day;
  @override
  final String month;
  @override
  final String date;
  @override
  final int index;

  @override
  String toString() {
    return 'DailyNavButtonModel(day: $day, month: $month, date: $date, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyNavButtonModel &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, month, date, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyNavButtonModelCopyWith<_$_DailyNavButtonModel> get copyWith =>
      __$$_DailyNavButtonModelCopyWithImpl<_$_DailyNavButtonModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyNavButtonModelToJson(
      this,
    );
  }
}

abstract class _DailyNavButtonModel implements DailyNavButtonModel {
  factory _DailyNavButtonModel(
      {required final String day,
      required final String month,
      required final String date,
      required final int index}) = _$_DailyNavButtonModel;

  factory _DailyNavButtonModel.fromJson(Map<String, dynamic> json) =
      _$_DailyNavButtonModel.fromJson;

  @override
  String get day;
  @override
  String get month;
  @override
  String get date;
  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$_DailyNavButtonModelCopyWith<_$_DailyNavButtonModel> get copyWith =>
      throw _privateConstructorUsedError;
}
