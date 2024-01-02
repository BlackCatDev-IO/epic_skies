// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocationState _$LocationStateFromJson(Map<String, dynamic> json) {
  return _LocationState.fromJson(json);
}

/// @nodoc
mixin _$LocationState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  LocationStatus get status => throw _privateConstructorUsedError;
  List<SearchSuggestion> get searchHistory =>
      throw _privateConstructorUsedError;
  List<SearchSuggestion> get currentSearchList =>
      throw _privateConstructorUsedError;
  LocationModel get data => throw _privateConstructorUsedError;
  RemoteLocationModel get remoteLocationData =>
      throw _privateConstructorUsedError;
  Coordinates? get coordinates => throw _privateConstructorUsedError;
  bool get searchIsLocal => throw _privateConstructorUsedError;
  String? get languageCode => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  SearchSuggestion? get searchSuggestion => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ErrorModel? get errorModel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationStateCopyWith<LocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res, LocationState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      LocationStatus status,
      List<SearchSuggestion> searchHistory,
      List<SearchSuggestion> currentSearchList,
      LocationModel data,
      RemoteLocationModel remoteLocationData,
      Coordinates? coordinates,
      bool searchIsLocal,
      String? languageCode,
      String? countryCode,
      SearchSuggestion? searchSuggestion,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ErrorModel? errorModel});

  $LocationModelCopyWith<$Res> get data;
  $RemoteLocationModelCopyWith<$Res> get remoteLocationData;
  $CoordinatesCopyWith<$Res>? get coordinates;
  $SearchSuggestionCopyWith<$Res>? get searchSuggestion;
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? searchHistory = null,
    Object? currentSearchList = null,
    Object? data = null,
    Object? remoteLocationData = null,
    Object? coordinates = freezed,
    Object? searchIsLocal = null,
    Object? languageCode = freezed,
    Object? countryCode = freezed,
    Object? searchSuggestion = freezed,
    Object? errorModel = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LocationStatus,
      searchHistory: null == searchHistory
          ? _value.searchHistory
          : searchHistory // ignore: cast_nullable_to_non_nullable
              as List<SearchSuggestion>,
      currentSearchList: null == currentSearchList
          ? _value.currentSearchList
          : currentSearchList // ignore: cast_nullable_to_non_nullable
              as List<SearchSuggestion>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      remoteLocationData: null == remoteLocationData
          ? _value.remoteLocationData
          : remoteLocationData // ignore: cast_nullable_to_non_nullable
              as RemoteLocationModel,
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      searchIsLocal: null == searchIsLocal
          ? _value.searchIsLocal
          : searchIsLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      languageCode: freezed == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      searchSuggestion: freezed == searchSuggestion
          ? _value.searchSuggestion
          : searchSuggestion // ignore: cast_nullable_to_non_nullable
              as SearchSuggestion?,
      errorModel: freezed == errorModel
          ? _value.errorModel
          : errorModel // ignore: cast_nullable_to_non_nullable
              as ErrorModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get data {
    return $LocationModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RemoteLocationModelCopyWith<$Res> get remoteLocationData {
    return $RemoteLocationModelCopyWith<$Res>(_value.remoteLocationData,
        (value) {
      return _then(_value.copyWith(remoteLocationData: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CoordinatesCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $CoordinatesCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SearchSuggestionCopyWith<$Res>? get searchSuggestion {
    if (_value.searchSuggestion == null) {
      return null;
    }

    return $SearchSuggestionCopyWith<$Res>(_value.searchSuggestion!, (value) {
      return _then(_value.copyWith(searchSuggestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationStateImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$LocationStateImplCopyWith(
          _$LocationStateImpl value, $Res Function(_$LocationStateImpl) then) =
      __$$LocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      LocationStatus status,
      List<SearchSuggestion> searchHistory,
      List<SearchSuggestion> currentSearchList,
      LocationModel data,
      RemoteLocationModel remoteLocationData,
      Coordinates? coordinates,
      bool searchIsLocal,
      String? languageCode,
      String? countryCode,
      SearchSuggestion? searchSuggestion,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ErrorModel? errorModel});

  @override
  $LocationModelCopyWith<$Res> get data;
  @override
  $RemoteLocationModelCopyWith<$Res> get remoteLocationData;
  @override
  $CoordinatesCopyWith<$Res>? get coordinates;
  @override
  $SearchSuggestionCopyWith<$Res>? get searchSuggestion;
}

/// @nodoc
class __$$LocationStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationStateImpl>
    implements _$$LocationStateImplCopyWith<$Res> {
  __$$LocationStateImplCopyWithImpl(
      _$LocationStateImpl _value, $Res Function(_$LocationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? searchHistory = null,
    Object? currentSearchList = null,
    Object? data = null,
    Object? remoteLocationData = null,
    Object? coordinates = freezed,
    Object? searchIsLocal = null,
    Object? languageCode = freezed,
    Object? countryCode = freezed,
    Object? searchSuggestion = freezed,
    Object? errorModel = freezed,
  }) {
    return _then(_$LocationStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LocationStatus,
      searchHistory: null == searchHistory
          ? _value._searchHistory
          : searchHistory // ignore: cast_nullable_to_non_nullable
              as List<SearchSuggestion>,
      currentSearchList: null == currentSearchList
          ? _value._currentSearchList
          : currentSearchList // ignore: cast_nullable_to_non_nullable
              as List<SearchSuggestion>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      remoteLocationData: null == remoteLocationData
          ? _value.remoteLocationData
          : remoteLocationData // ignore: cast_nullable_to_non_nullable
              as RemoteLocationModel,
      coordinates: freezed == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as Coordinates?,
      searchIsLocal: null == searchIsLocal
          ? _value.searchIsLocal
          : searchIsLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      languageCode: freezed == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      searchSuggestion: freezed == searchSuggestion
          ? _value.searchSuggestion
          : searchSuggestion // ignore: cast_nullable_to_non_nullable
              as SearchSuggestion?,
      errorModel: freezed == errorModel
          ? _value.errorModel
          : errorModel // ignore: cast_nullable_to_non_nullable
              as ErrorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationStateImpl extends _LocationState {
  const _$LocationStateImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      this.status = LocationStatus.initial,
      final List<SearchSuggestion> searchHistory = const [],
      final List<SearchSuggestion> currentSearchList = const [],
      this.data = const LocationModel(),
      this.remoteLocationData = const RemoteLocationModel(),
      this.coordinates = const Coordinates(lat: 0, long: 0),
      this.searchIsLocal = true,
      this.languageCode,
      this.countryCode,
      this.searchSuggestion,
      @JsonKey(includeFromJson: false, includeToJson: false) this.errorModel})
      : _searchHistory = searchHistory,
        _currentSearchList = currentSearchList,
        super._();

  factory _$LocationStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationStateImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final LocationStatus status;
  final List<SearchSuggestion> _searchHistory;
  @override
  @JsonKey()
  List<SearchSuggestion> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  final List<SearchSuggestion> _currentSearchList;
  @override
  @JsonKey()
  List<SearchSuggestion> get currentSearchList {
    if (_currentSearchList is EqualUnmodifiableListView)
      return _currentSearchList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentSearchList);
  }

  @override
  @JsonKey()
  final LocationModel data;
  @override
  @JsonKey()
  final RemoteLocationModel remoteLocationData;
  @override
  @JsonKey()
  final Coordinates? coordinates;
  @override
  @JsonKey()
  final bool searchIsLocal;
  @override
  final String? languageCode;
  @override
  final String? countryCode;
  @override
  final SearchSuggestion? searchSuggestion;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ErrorModel? errorModel;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._searchHistory, _searchHistory) &&
            const DeepCollectionEquality()
                .equals(other._currentSearchList, _currentSearchList) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.remoteLocationData, remoteLocationData) ||
                other.remoteLocationData == remoteLocationData) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates) &&
            (identical(other.searchIsLocal, searchIsLocal) ||
                other.searchIsLocal == searchIsLocal) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.searchSuggestion, searchSuggestion) ||
                other.searchSuggestion == searchSuggestion) &&
            (identical(other.errorModel, errorModel) ||
                other.errorModel == errorModel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_searchHistory),
      const DeepCollectionEquality().hash(_currentSearchList),
      data,
      remoteLocationData,
      coordinates,
      searchIsLocal,
      languageCode,
      countryCode,
      searchSuggestion,
      errorModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      __$$LocationStateImplCopyWithImpl<_$LocationStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationStateImplToJson(
      this,
    );
  }
}

abstract class _LocationState extends LocationState {
  const factory _LocationState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final LocationStatus status,
      final List<SearchSuggestion> searchHistory,
      final List<SearchSuggestion> currentSearchList,
      final LocationModel data,
      final RemoteLocationModel remoteLocationData,
      final Coordinates? coordinates,
      final bool searchIsLocal,
      final String? languageCode,
      final String? countryCode,
      final SearchSuggestion? searchSuggestion,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ErrorModel? errorModel}) = _$LocationStateImpl;
  const _LocationState._() : super._();

  factory _LocationState.fromJson(Map<String, dynamic> json) =
      _$LocationStateImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  LocationStatus get status;
  @override
  List<SearchSuggestion> get searchHistory;
  @override
  List<SearchSuggestion> get currentSearchList;
  @override
  LocationModel get data;
  @override
  RemoteLocationModel get remoteLocationData;
  @override
  Coordinates? get coordinates;
  @override
  bool get searchIsLocal;
  @override
  String? get languageCode;
  @override
  String? get countryCode;
  @override
  SearchSuggestion? get searchSuggestion;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ErrorModel? get errorModel;
  @override
  @JsonKey(ignore: true)
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
