// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_forecast_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyForecastModel _$DailyForecastModelFromJson(Map<String, dynamic> json) {
  return _DailyForecastModel.fromJson(json);
}

/// @nodoc
mixin _$DailyForecastModel {
  int get dailyTemp => throw _privateConstructorUsedError;
  int get feelsLikeDay => throw _privateConstructorUsedError;
  int? get highTemp => throw _privateConstructorUsedError;
  int? get lowTemp => throw _privateConstructorUsedError;
  num get precipitationAmount => throw _privateConstructorUsedError;
  int get windSpeed => throw _privateConstructorUsedError;
  num get precipitationProbability => throw _privateConstructorUsedError;
  String get precipitationType => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  String get day => throw _privateConstructorUsedError;
  String get month => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get speedUnit => throw _privateConstructorUsedError;
  String get precipUnit => throw _privateConstructorUsedError;
  String? get precipIconPath => throw _privateConstructorUsedError;
  SunTimesModel get suntime => throw _privateConstructorUsedError;
  List<HourlyVerticalWidgetModel>? get extendedHourlyList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyForecastModelCopyWith<DailyForecastModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyForecastModelCopyWith<$Res> {
  factory $DailyForecastModelCopyWith(
          DailyForecastModel value, $Res Function(DailyForecastModel) then) =
      _$DailyForecastModelCopyWithImpl<$Res, DailyForecastModel>;
  @useResult
  $Res call(
      {int dailyTemp,
      int feelsLikeDay,
      int? highTemp,
      int? lowTemp,
      num precipitationAmount,
      int windSpeed,
      num precipitationProbability,
      String precipitationType,
      String iconPath,
      String day,
      String month,
      String year,
      String date,
      String condition,
      String speedUnit,
      String precipUnit,
      String? precipIconPath,
      SunTimesModel suntime,
      List<HourlyVerticalWidgetModel>? extendedHourlyList});

  $SunTimesModelCopyWith<$Res> get suntime;
}

/// @nodoc
class _$DailyForecastModelCopyWithImpl<$Res, $Val extends DailyForecastModel>
    implements $DailyForecastModelCopyWith<$Res> {
  _$DailyForecastModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyTemp = null,
    Object? feelsLikeDay = null,
    Object? highTemp = freezed,
    Object? lowTemp = freezed,
    Object? precipitationAmount = null,
    Object? windSpeed = null,
    Object? precipitationProbability = null,
    Object? precipitationType = null,
    Object? iconPath = null,
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? date = null,
    Object? condition = null,
    Object? speedUnit = null,
    Object? precipUnit = null,
    Object? precipIconPath = freezed,
    Object? suntime = null,
    Object? extendedHourlyList = freezed,
  }) {
    return _then(_value.copyWith(
      dailyTemp: null == dailyTemp
          ? _value.dailyTemp
          : dailyTemp // ignore: cast_nullable_to_non_nullable
              as int,
      feelsLikeDay: null == feelsLikeDay
          ? _value.feelsLikeDay
          : feelsLikeDay // ignore: cast_nullable_to_non_nullable
              as int,
      highTemp: freezed == highTemp
          ? _value.highTemp
          : highTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      lowTemp: freezed == lowTemp
          ? _value.lowTemp
          : lowTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      precipitationAmount: null == precipitationAmount
          ? _value.precipitationAmount
          : precipitationAmount // ignore: cast_nullable_to_non_nullable
              as num,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      precipitationProbability: null == precipitationProbability
          ? _value.precipitationProbability
          : precipitationProbability // ignore: cast_nullable_to_non_nullable
              as num,
      precipitationType: null == precipitationType
          ? _value.precipitationType
          : precipitationType // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      speedUnit: null == speedUnit
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      precipUnit: null == precipUnit
          ? _value.precipUnit
          : precipUnit // ignore: cast_nullable_to_non_nullable
              as String,
      precipIconPath: freezed == precipIconPath
          ? _value.precipIconPath
          : precipIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      suntime: null == suntime
          ? _value.suntime
          : suntime // ignore: cast_nullable_to_non_nullable
              as SunTimesModel,
      extendedHourlyList: freezed == extendedHourlyList
          ? _value.extendedHourlyList
          : extendedHourlyList // ignore: cast_nullable_to_non_nullable
              as List<HourlyVerticalWidgetModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SunTimesModelCopyWith<$Res> get suntime {
    return $SunTimesModelCopyWith<$Res>(_value.suntime, (value) {
      return _then(_value.copyWith(suntime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DailyForecastModelCopyWith<$Res>
    implements $DailyForecastModelCopyWith<$Res> {
  factory _$$_DailyForecastModelCopyWith(_$_DailyForecastModel value,
          $Res Function(_$_DailyForecastModel) then) =
      __$$_DailyForecastModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int dailyTemp,
      int feelsLikeDay,
      int? highTemp,
      int? lowTemp,
      num precipitationAmount,
      int windSpeed,
      num precipitationProbability,
      String precipitationType,
      String iconPath,
      String day,
      String month,
      String year,
      String date,
      String condition,
      String speedUnit,
      String precipUnit,
      String? precipIconPath,
      SunTimesModel suntime,
      List<HourlyVerticalWidgetModel>? extendedHourlyList});

  @override
  $SunTimesModelCopyWith<$Res> get suntime;
}

/// @nodoc
class __$$_DailyForecastModelCopyWithImpl<$Res>
    extends _$DailyForecastModelCopyWithImpl<$Res, _$_DailyForecastModel>
    implements _$$_DailyForecastModelCopyWith<$Res> {
  __$$_DailyForecastModelCopyWithImpl(
      _$_DailyForecastModel _value, $Res Function(_$_DailyForecastModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyTemp = null,
    Object? feelsLikeDay = null,
    Object? highTemp = freezed,
    Object? lowTemp = freezed,
    Object? precipitationAmount = null,
    Object? windSpeed = null,
    Object? precipitationProbability = null,
    Object? precipitationType = null,
    Object? iconPath = null,
    Object? day = null,
    Object? month = null,
    Object? year = null,
    Object? date = null,
    Object? condition = null,
    Object? speedUnit = null,
    Object? precipUnit = null,
    Object? precipIconPath = freezed,
    Object? suntime = null,
    Object? extendedHourlyList = freezed,
  }) {
    return _then(_$_DailyForecastModel(
      dailyTemp: null == dailyTemp
          ? _value.dailyTemp
          : dailyTemp // ignore: cast_nullable_to_non_nullable
              as int,
      feelsLikeDay: null == feelsLikeDay
          ? _value.feelsLikeDay
          : feelsLikeDay // ignore: cast_nullable_to_non_nullable
              as int,
      highTemp: freezed == highTemp
          ? _value.highTemp
          : highTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      lowTemp: freezed == lowTemp
          ? _value.lowTemp
          : lowTemp // ignore: cast_nullable_to_non_nullable
              as int?,
      precipitationAmount: null == precipitationAmount
          ? _value.precipitationAmount
          : precipitationAmount // ignore: cast_nullable_to_non_nullable
              as num,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      precipitationProbability: null == precipitationProbability
          ? _value.precipitationProbability
          : precipitationProbability // ignore: cast_nullable_to_non_nullable
              as num,
      precipitationType: null == precipitationType
          ? _value.precipitationType
          : precipitationType // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      speedUnit: null == speedUnit
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      precipUnit: null == precipUnit
          ? _value.precipUnit
          : precipUnit // ignore: cast_nullable_to_non_nullable
              as String,
      precipIconPath: freezed == precipIconPath
          ? _value.precipIconPath
          : precipIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      suntime: null == suntime
          ? _value.suntime
          : suntime // ignore: cast_nullable_to_non_nullable
              as SunTimesModel,
      extendedHourlyList: freezed == extendedHourlyList
          ? _value._extendedHourlyList
          : extendedHourlyList // ignore: cast_nullable_to_non_nullable
              as List<HourlyVerticalWidgetModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DailyForecastModel implements _DailyForecastModel {
  _$_DailyForecastModel(
      {required this.dailyTemp,
      required this.feelsLikeDay,
      required this.highTemp,
      required this.lowTemp,
      required this.precipitationAmount,
      required this.windSpeed,
      required this.precipitationProbability,
      required this.precipitationType,
      required this.iconPath,
      required this.day,
      required this.month,
      required this.year,
      required this.date,
      required this.condition,
      required this.speedUnit,
      required this.precipUnit,
      required this.precipIconPath,
      required this.suntime,
      final List<HourlyVerticalWidgetModel>? extendedHourlyList})
      : _extendedHourlyList = extendedHourlyList;

  factory _$_DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      _$$_DailyForecastModelFromJson(json);

  @override
  final int dailyTemp;
  @override
  final int feelsLikeDay;
  @override
  final int? highTemp;
  @override
  final int? lowTemp;
  @override
  final num precipitationAmount;
  @override
  final int windSpeed;
  @override
  final num precipitationProbability;
  @override
  final String precipitationType;
  @override
  final String iconPath;
  @override
  final String day;
  @override
  final String month;
  @override
  final String year;
  @override
  final String date;
  @override
  final String condition;
  @override
  final String speedUnit;
  @override
  final String precipUnit;
  @override
  final String? precipIconPath;
  @override
  final SunTimesModel suntime;
  final List<HourlyVerticalWidgetModel>? _extendedHourlyList;
  @override
  List<HourlyVerticalWidgetModel>? get extendedHourlyList {
    final value = _extendedHourlyList;
    if (value == null) return null;
    if (_extendedHourlyList is EqualUnmodifiableListView)
      return _extendedHourlyList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DailyForecastModel(dailyTemp: $dailyTemp, feelsLikeDay: $feelsLikeDay, highTemp: $highTemp, lowTemp: $lowTemp, precipitationAmount: $precipitationAmount, windSpeed: $windSpeed, precipitationProbability: $precipitationProbability, precipitationType: $precipitationType, iconPath: $iconPath, day: $day, month: $month, year: $year, date: $date, condition: $condition, speedUnit: $speedUnit, precipUnit: $precipUnit, precipIconPath: $precipIconPath, suntime: $suntime, extendedHourlyList: $extendedHourlyList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyForecastModel &&
            (identical(other.dailyTemp, dailyTemp) ||
                other.dailyTemp == dailyTemp) &&
            (identical(other.feelsLikeDay, feelsLikeDay) ||
                other.feelsLikeDay == feelsLikeDay) &&
            (identical(other.highTemp, highTemp) ||
                other.highTemp == highTemp) &&
            (identical(other.lowTemp, lowTemp) || other.lowTemp == lowTemp) &&
            (identical(other.precipitationAmount, precipitationAmount) ||
                other.precipitationAmount == precipitationAmount) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(
                    other.precipitationProbability, precipitationProbability) ||
                other.precipitationProbability == precipitationProbability) &&
            (identical(other.precipitationType, precipitationType) ||
                other.precipitationType == precipitationType) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.speedUnit, speedUnit) ||
                other.speedUnit == speedUnit) &&
            (identical(other.precipUnit, precipUnit) ||
                other.precipUnit == precipUnit) &&
            (identical(other.precipIconPath, precipIconPath) ||
                other.precipIconPath == precipIconPath) &&
            (identical(other.suntime, suntime) || other.suntime == suntime) &&
            const DeepCollectionEquality()
                .equals(other._extendedHourlyList, _extendedHourlyList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        dailyTemp,
        feelsLikeDay,
        highTemp,
        lowTemp,
        precipitationAmount,
        windSpeed,
        precipitationProbability,
        precipitationType,
        iconPath,
        day,
        month,
        year,
        date,
        condition,
        speedUnit,
        precipUnit,
        precipIconPath,
        suntime,
        const DeepCollectionEquality().hash(_extendedHourlyList)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyForecastModelCopyWith<_$_DailyForecastModel> get copyWith =>
      __$$_DailyForecastModelCopyWithImpl<_$_DailyForecastModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DailyForecastModelToJson(
      this,
    );
  }
}

abstract class _DailyForecastModel implements DailyForecastModel {
  factory _DailyForecastModel(
          {required final int dailyTemp,
          required final int feelsLikeDay,
          required final int? highTemp,
          required final int? lowTemp,
          required final num precipitationAmount,
          required final int windSpeed,
          required final num precipitationProbability,
          required final String precipitationType,
          required final String iconPath,
          required final String day,
          required final String month,
          required final String year,
          required final String date,
          required final String condition,
          required final String speedUnit,
          required final String precipUnit,
          required final String? precipIconPath,
          required final SunTimesModel suntime,
          final List<HourlyVerticalWidgetModel>? extendedHourlyList}) =
      _$_DailyForecastModel;

  factory _DailyForecastModel.fromJson(Map<String, dynamic> json) =
      _$_DailyForecastModel.fromJson;

  @override
  int get dailyTemp;
  @override
  int get feelsLikeDay;
  @override
  int? get highTemp;
  @override
  int? get lowTemp;
  @override
  num get precipitationAmount;
  @override
  int get windSpeed;
  @override
  num get precipitationProbability;
  @override
  String get precipitationType;
  @override
  String get iconPath;
  @override
  String get day;
  @override
  String get month;
  @override
  String get year;
  @override
  String get date;
  @override
  String get condition;
  @override
  String get speedUnit;
  @override
  String get precipUnit;
  @override
  String? get precipIconPath;
  @override
  SunTimesModel get suntime;
  @override
  List<HourlyVerticalWidgetModel>? get extendedHourlyList;
  @override
  @JsonKey(ignore: true)
  _$$_DailyForecastModelCopyWith<_$_DailyForecastModel> get copyWith =>
      throw _privateConstructorUsedError;
}
