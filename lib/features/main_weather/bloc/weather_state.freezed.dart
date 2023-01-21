// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weather_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) {
  return _WeatherState.fromJson(json);
}

/// @nodoc
mixin _$WeatherState {
  WeatherResponseModel? get weatherModel => throw _privateConstructorUsedError;
  WeatherStatus get status => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get searchIsLocal => throw _privateConstructorUsedError;
  UnitSettings get unitSettings => throw _privateConstructorUsedError;
  SearchLocalWeatherButtonModel get searchButtonModel =>
      throw _privateConstructorUsedError;
  List<SunTimesModel> get refererenceSuntimes =>
      throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  Exception? get exception => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherStateCopyWith<WeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherStateCopyWith<$Res> {
  factory $WeatherStateCopyWith(
          WeatherState value, $Res Function(WeatherState) then) =
      _$WeatherStateCopyWithImpl<$Res, WeatherState>;
  @useResult
  $Res call(
      {WeatherResponseModel? weatherModel,
      WeatherStatus status,
      bool isLoading,
      bool searchIsLocal,
      UnitSettings unitSettings,
      SearchLocalWeatherButtonModel searchButtonModel,
      List<SunTimesModel> refererenceSuntimes,
      bool isDay,
      @JsonKey(ignore: true) Exception? exception});

  $WeatherResponseModelCopyWith<$Res>? get weatherModel;
  $UnitSettingsCopyWith<$Res> get unitSettings;
}

/// @nodoc
class _$WeatherStateCopyWithImpl<$Res, $Val extends WeatherState>
    implements $WeatherStateCopyWith<$Res> {
  _$WeatherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherModel = freezed,
    Object? status = null,
    Object? isLoading = null,
    Object? searchIsLocal = null,
    Object? unitSettings = null,
    Object? searchButtonModel = null,
    Object? refererenceSuntimes = null,
    Object? isDay = null,
    Object? exception = freezed,
  }) {
    return _then(_value.copyWith(
      weatherModel: freezed == weatherModel
          ? _value.weatherModel
          : weatherModel // ignore: cast_nullable_to_non_nullable
              as WeatherResponseModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WeatherStatus,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchIsLocal: null == searchIsLocal
          ? _value.searchIsLocal
          : searchIsLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      unitSettings: null == unitSettings
          ? _value.unitSettings
          : unitSettings // ignore: cast_nullable_to_non_nullable
              as UnitSettings,
      searchButtonModel: null == searchButtonModel
          ? _value.searchButtonModel
          : searchButtonModel // ignore: cast_nullable_to_non_nullable
              as SearchLocalWeatherButtonModel,
      refererenceSuntimes: null == refererenceSuntimes
          ? _value.refererenceSuntimes
          : refererenceSuntimes // ignore: cast_nullable_to_non_nullable
              as List<SunTimesModel>,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherResponseModelCopyWith<$Res>? get weatherModel {
    if (_value.weatherModel == null) {
      return null;
    }

    return $WeatherResponseModelCopyWith<$Res>(_value.weatherModel!, (value) {
      return _then(_value.copyWith(weatherModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitSettingsCopyWith<$Res> get unitSettings {
    return $UnitSettingsCopyWith<$Res>(_value.unitSettings, (value) {
      return _then(_value.copyWith(unitSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeatherStateCopyWith<$Res>
    implements $WeatherStateCopyWith<$Res> {
  factory _$$_WeatherStateCopyWith(
          _$_WeatherState value, $Res Function(_$_WeatherState) then) =
      __$$_WeatherStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeatherResponseModel? weatherModel,
      WeatherStatus status,
      bool isLoading,
      bool searchIsLocal,
      UnitSettings unitSettings,
      SearchLocalWeatherButtonModel searchButtonModel,
      List<SunTimesModel> refererenceSuntimes,
      bool isDay,
      @JsonKey(ignore: true) Exception? exception});

  @override
  $WeatherResponseModelCopyWith<$Res>? get weatherModel;
  @override
  $UnitSettingsCopyWith<$Res> get unitSettings;
}

/// @nodoc
class __$$_WeatherStateCopyWithImpl<$Res>
    extends _$WeatherStateCopyWithImpl<$Res, _$_WeatherState>
    implements _$$_WeatherStateCopyWith<$Res> {
  __$$_WeatherStateCopyWithImpl(
      _$_WeatherState _value, $Res Function(_$_WeatherState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherModel = freezed,
    Object? status = null,
    Object? isLoading = null,
    Object? searchIsLocal = null,
    Object? unitSettings = null,
    Object? searchButtonModel = null,
    Object? refererenceSuntimes = null,
    Object? isDay = null,
    Object? exception = freezed,
  }) {
    return _then(_$_WeatherState(
      weatherModel: freezed == weatherModel
          ? _value.weatherModel
          : weatherModel // ignore: cast_nullable_to_non_nullable
              as WeatherResponseModel?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WeatherStatus,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      searchIsLocal: null == searchIsLocal
          ? _value.searchIsLocal
          : searchIsLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      unitSettings: null == unitSettings
          ? _value.unitSettings
          : unitSettings // ignore: cast_nullable_to_non_nullable
              as UnitSettings,
      searchButtonModel: null == searchButtonModel
          ? _value.searchButtonModel
          : searchButtonModel // ignore: cast_nullable_to_non_nullable
              as SearchLocalWeatherButtonModel,
      refererenceSuntimes: null == refererenceSuntimes
          ? _value._refererenceSuntimes
          : refererenceSuntimes // ignore: cast_nullable_to_non_nullable
              as List<SunTimesModel>,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherState implements _WeatherState {
  const _$_WeatherState(
      {this.weatherModel,
      this.status = WeatherStatus.initial,
      this.isLoading = false,
      this.searchIsLocal = true,
      this.unitSettings = const UnitSettings(),
      this.searchButtonModel = const SearchLocalWeatherButtonModel(),
      final List<SunTimesModel> refererenceSuntimes = const [],
      this.isDay = true,
      @JsonKey(ignore: true) this.exception})
      : _refererenceSuntimes = refererenceSuntimes;

  factory _$_WeatherState.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherStateFromJson(json);

  @override
  final WeatherResponseModel? weatherModel;
  @override
  @JsonKey()
  final WeatherStatus status;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool searchIsLocal;
  @override
  @JsonKey()
  final UnitSettings unitSettings;
  @override
  @JsonKey()
  final SearchLocalWeatherButtonModel searchButtonModel;
  final List<SunTimesModel> _refererenceSuntimes;
  @override
  @JsonKey()
  List<SunTimesModel> get refererenceSuntimes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refererenceSuntimes);
  }

  @override
  @JsonKey()
  final bool isDay;
  @override
  @JsonKey(ignore: true)
  final Exception? exception;

  @override
  String toString() {
    return 'WeatherState(weatherModel: $weatherModel, status: $status, isLoading: $isLoading, searchIsLocal: $searchIsLocal, unitSettings: $unitSettings, searchButtonModel: $searchButtonModel, refererenceSuntimes: $refererenceSuntimes, isDay: $isDay, exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherState &&
            (identical(other.weatherModel, weatherModel) ||
                other.weatherModel == weatherModel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.searchIsLocal, searchIsLocal) ||
                other.searchIsLocal == searchIsLocal) &&
            (identical(other.unitSettings, unitSettings) ||
                other.unitSettings == unitSettings) &&
            (identical(other.searchButtonModel, searchButtonModel) ||
                other.searchButtonModel == searchButtonModel) &&
            const DeepCollectionEquality()
                .equals(other._refererenceSuntimes, _refererenceSuntimes) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weatherModel,
      status,
      isLoading,
      searchIsLocal,
      unitSettings,
      searchButtonModel,
      const DeepCollectionEquality().hash(_refererenceSuntimes),
      isDay,
      exception);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherStateCopyWith<_$_WeatherState> get copyWith =>
      __$$_WeatherStateCopyWithImpl<_$_WeatherState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherStateToJson(
      this,
    );
  }
}

abstract class _WeatherState implements WeatherState {
  const factory _WeatherState(
      {final WeatherResponseModel? weatherModel,
      final WeatherStatus status,
      final bool isLoading,
      final bool searchIsLocal,
      final UnitSettings unitSettings,
      final SearchLocalWeatherButtonModel searchButtonModel,
      final List<SunTimesModel> refererenceSuntimes,
      final bool isDay,
      @JsonKey(ignore: true) final Exception? exception}) = _$_WeatherState;

  factory _WeatherState.fromJson(Map<String, dynamic> json) =
      _$_WeatherState.fromJson;

  @override
  WeatherResponseModel? get weatherModel;
  @override
  WeatherStatus get status;
  @override
  bool get isLoading;
  @override
  bool get searchIsLocal;
  @override
  UnitSettings get unitSettings;
  @override
  SearchLocalWeatherButtonModel get searchButtonModel;
  @override
  List<SunTimesModel> get refererenceSuntimes;
  @override
  bool get isDay;
  @override
  @JsonKey(ignore: true)
  Exception? get exception;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherStateCopyWith<_$_WeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}
