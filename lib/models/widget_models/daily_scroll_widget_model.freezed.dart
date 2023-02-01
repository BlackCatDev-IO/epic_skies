// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_scroll_widget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyScrollWidgetModel _$DailyScrollWidgetModelFromJson(
    Map<String, dynamic> json) {
  return _DailyScrollWidgetModel.fromJson(json);
}

/// @nodoc
mixin _$DailyScrollWidgetModel {
  String get header => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  String get month => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get temp => throw _privateConstructorUsedError;
  num get precipitation => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyScrollWidgetModelCopyWith<DailyScrollWidgetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyScrollWidgetModelCopyWith<$Res> {
  factory $DailyScrollWidgetModelCopyWith(DailyScrollWidgetModel value,
          $Res Function(DailyScrollWidgetModel) then) =
      _$DailyScrollWidgetModelCopyWithImpl<$Res, DailyScrollWidgetModel>;
  @useResult
  $Res call(
      {String header,
      String iconPath,
      String month,
      String date,
      int temp,
      num precipitation,
      int index});
}

/// @nodoc
class _$DailyScrollWidgetModelCopyWithImpl<$Res,
        $Val extends DailyScrollWidgetModel>
    implements $DailyScrollWidgetModelCopyWith<$Res> {
  _$DailyScrollWidgetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? iconPath = null,
    Object? month = null,
    Object? date = null,
    Object? temp = null,
    Object? precipitation = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      precipitation: null == precipitation
          ? _value.precipitation
          : precipitation // ignore: cast_nullable_to_non_nullable
              as num,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyScrollWidgetModelCopyWith<$Res>
    implements $DailyScrollWidgetModelCopyWith<$Res> {
  factory _$$_DailyScrollWidgetModelCopyWith(_$_DailyScrollWidgetModel value,
          $Res Function(_$_DailyScrollWidgetModel) then) =
      __$$_DailyScrollWidgetModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String header,
      String iconPath,
      String month,
      String date,
      int temp,
      num precipitation,
      int index});
}

/// @nodoc
class __$$_DailyScrollWidgetModelCopyWithImpl<$Res>
    extends _$DailyScrollWidgetModelCopyWithImpl<$Res,
        _$_DailyScrollWidgetModel>
    implements _$$_DailyScrollWidgetModelCopyWith<$Res> {
  __$$_DailyScrollWidgetModelCopyWithImpl(_$_DailyScrollWidgetModel _value,
      $Res Function(_$_DailyScrollWidgetModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? header = null,
    Object? iconPath = null,
    Object? month = null,
    Object? date = null,
    Object? temp = null,
    Object? precipitation = null,
    Object? index = null,
  }) {
    return _then(_$_DailyScrollWidgetModel(
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      precipitation: null == precipitation
          ? _value.precipitation
          : precipitation // ignore: cast_nullable_to_non_nullable
              as num,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyScrollWidgetModel implements _DailyScrollWidgetModel {
  _$_DailyScrollWidgetModel(
      {required this.header,
      required this.iconPath,
      required this.month,
      required this.date,
      required this.temp,
      required this.precipitation,
      required this.index});

  factory _$_DailyScrollWidgetModel.fromJson(Map<String, dynamic> json) =>
      _$$_DailyScrollWidgetModelFromJson(json);

  @override
  final String header;
  @override
  final String iconPath;
  @override
  final String month;
  @override
  final String date;
  @override
  final int temp;
  @override
  final num precipitation;
  @override
  final int index;

  @override
  String toString() {
    return 'DailyScrollWidgetModel(header: $header, iconPath: $iconPath, month: $month, date: $date, temp: $temp, precipitation: $precipitation, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyScrollWidgetModel &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.precipitation, precipitation) ||
                other.precipitation == precipitation) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, header, iconPath, month, date, temp, precipitation, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyScrollWidgetModelCopyWith<_$_DailyScrollWidgetModel> get copyWith =>
      __$$_DailyScrollWidgetModelCopyWithImpl<_$_DailyScrollWidgetModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyScrollWidgetModelToJson(
      this,
    );
  }
}

abstract class _DailyScrollWidgetModel implements DailyScrollWidgetModel {
  factory _DailyScrollWidgetModel(
      {required final String header,
      required final String iconPath,
      required final String month,
      required final String date,
      required final int temp,
      required final num precipitation,
      required final int index}) = _$_DailyScrollWidgetModel;

  factory _DailyScrollWidgetModel.fromJson(Map<String, dynamic> json) =
      _$_DailyScrollWidgetModel.fromJson;

  @override
  String get header;
  @override
  String get iconPath;
  @override
  String get month;
  @override
  String get date;
  @override
  int get temp;
  @override
  num get precipitation;
  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$_DailyScrollWidgetModelCopyWith<_$_DailyScrollWidgetModel> get copyWith =>
      throw _privateConstructorUsedError;
}
