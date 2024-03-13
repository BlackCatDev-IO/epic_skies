// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location_state.dart';

class LocationStatusMapper extends EnumMapper<LocationStatus> {
  LocationStatusMapper._();

  static LocationStatusMapper? _instance;
  static LocationStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationStatusMapper._());
    }
    return _instance!;
  }

  static LocationStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LocationStatus decode(dynamic value) {
    switch (value) {
      case 'initial':
        return LocationStatus.initial;
      case 'loading':
        return LocationStatus.loading;
      case 'success':
        return LocationStatus.success;
      case 'noLocationPermission':
        return LocationStatus.noLocationPermission;
      case 'locationDisabled':
        return LocationStatus.locationDisabled;
      case 'error':
        return LocationStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LocationStatus self) {
    switch (self) {
      case LocationStatus.initial:
        return 'initial';
      case LocationStatus.loading:
        return 'loading';
      case LocationStatus.success:
        return 'success';
      case LocationStatus.noLocationPermission:
        return 'noLocationPermission';
      case LocationStatus.locationDisabled:
        return 'locationDisabled';
      case LocationStatus.error:
        return 'error';
    }
  }
}

extension LocationStatusMapperExtension on LocationStatus {
  String toValue() {
    LocationStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LocationStatus>(this) as String;
  }
}

class LocationStateMapper extends ClassMapperBase<LocationState> {
  LocationStateMapper._();

  static LocationStateMapper? _instance;
  static LocationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationStateMapper._());
      LocationStatusMapper.ensureInitialized();
      SearchSuggestionMapper.ensureInitialized();
      LocationModelMapper.ensureInitialized();
      RemoteLocationModelMapper.ensureInitialized();
      CoordinatesMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocationState';

  static LocationStatus _$status(LocationState v) => v.status;
  static const Field<LocationState, LocationStatus> _f$status =
      Field('status', _$status, opt: true, def: LocationStatus.initial);
  static List<SearchSuggestion> _$searchHistory(LocationState v) =>
      v.searchHistory;
  static const Field<LocationState, List<SearchSuggestion>> _f$searchHistory =
      Field('searchHistory', _$searchHistory, opt: true, def: const []);
  static List<SearchSuggestion> _$currentSearchList(LocationState v) =>
      v.currentSearchList;
  static const Field<LocationState, List<SearchSuggestion>>
      _f$currentSearchList =
      Field('currentSearchList', _$currentSearchList, opt: true, def: const []);
  static LocationModel _$data(LocationState v) => v.data;
  static const Field<LocationState, LocationModel> _f$data =
      Field('data', _$data, opt: true, def: const LocationModel());
  static RemoteLocationModel _$remoteLocationData(LocationState v) =>
      v.remoteLocationData;
  static const Field<LocationState, RemoteLocationModel> _f$remoteLocationData =
      Field('remoteLocationData', _$remoteLocationData,
          opt: true, def: const RemoteLocationModel());
  static Coordinates? _$coordinates(LocationState v) => v.coordinates;
  static const Field<LocationState, Coordinates> _f$coordinates = Field(
      'coordinates', _$coordinates,
      opt: true, def: const Coordinates(lat: 0, long: 0));
  static bool _$searchIsLocal(LocationState v) => v.searchIsLocal;
  static const Field<LocationState, bool> _f$searchIsLocal =
      Field('searchIsLocal', _$searchIsLocal, opt: true, def: true);
  static String? _$languageCode(LocationState v) => v.languageCode;
  static const Field<LocationState, String> _f$languageCode =
      Field('languageCode', _$languageCode, opt: true);
  static String? _$countryCode(LocationState v) => v.countryCode;
  static const Field<LocationState, String> _f$countryCode =
      Field('countryCode', _$countryCode, opt: true);
  static SearchSuggestion? _$searchSuggestion(LocationState v) =>
      v.searchSuggestion;
  static const Field<LocationState, SearchSuggestion> _f$searchSuggestion =
      Field('searchSuggestion', _$searchSuggestion, opt: true);
  static ErrorModel? _$errorModel(LocationState v) => v.errorModel;
  static const Field<LocationState, ErrorModel> _f$errorModel =
      Field('errorModel', _$errorModel, opt: true);
  static DateTime? _$lastUpdated(LocationState v) => v.lastUpdated;
  static const Field<LocationState, DateTime> _f$lastUpdated =
      Field('lastUpdated', _$lastUpdated, opt: true);

  @override
  final MappableFields<LocationState> fields = const {
    #status: _f$status,
    #searchHistory: _f$searchHistory,
    #currentSearchList: _f$currentSearchList,
    #data: _f$data,
    #remoteLocationData: _f$remoteLocationData,
    #coordinates: _f$coordinates,
    #searchIsLocal: _f$searchIsLocal,
    #languageCode: _f$languageCode,
    #countryCode: _f$countryCode,
    #searchSuggestion: _f$searchSuggestion,
    #errorModel: _f$errorModel,
    #lastUpdated: _f$lastUpdated,
  };

  static LocationState _instantiate(DecodingData data) {
    return LocationState(
        status: data.dec(_f$status),
        searchHistory: data.dec(_f$searchHistory),
        currentSearchList: data.dec(_f$currentSearchList),
        data: data.dec(_f$data),
        remoteLocationData: data.dec(_f$remoteLocationData),
        coordinates: data.dec(_f$coordinates),
        searchIsLocal: data.dec(_f$searchIsLocal),
        languageCode: data.dec(_f$languageCode),
        countryCode: data.dec(_f$countryCode),
        searchSuggestion: data.dec(_f$searchSuggestion),
        errorModel: data.dec(_f$errorModel),
        lastUpdated: data.dec(_f$lastUpdated));
  }

  @override
  final Function instantiate = _instantiate;

  static LocationState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocationState>(map);
  }

  static LocationState fromJson(String json) {
    return ensureInitialized().decodeJson<LocationState>(json);
  }
}

mixin LocationStateMappable {
  String toJson() {
    return LocationStateMapper.ensureInitialized()
        .encodeJson<LocationState>(this as LocationState);
  }

  Map<String, dynamic> toMap() {
    return LocationStateMapper.ensureInitialized()
        .encodeMap<LocationState>(this as LocationState);
  }

  LocationStateCopyWith<LocationState, LocationState, LocationState>
      get copyWith => _LocationStateCopyWithImpl(
          this as LocationState, $identity, $identity);
  @override
  String toString() {
    return LocationStateMapper.ensureInitialized()
        .stringifyValue(this as LocationState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            LocationStateMapper.ensureInitialized()
                .isValueEqual(this as LocationState, other));
  }

  @override
  int get hashCode {
    return LocationStateMapper.ensureInitialized()
        .hashValue(this as LocationState);
  }
}

extension LocationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocationState, $Out> {
  LocationStateCopyWith<$R, LocationState, $Out> get $asLocationState =>
      $base.as((v, t, t2) => _LocationStateCopyWithImpl(v, t, t2));
}

abstract class LocationStateCopyWith<$R, $In extends LocationState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SearchSuggestion,
          SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>>
      get searchHistory;
  ListCopyWith<$R, SearchSuggestion,
          SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>>
      get currentSearchList;
  LocationModelCopyWith<$R, LocationModel, LocationModel> get data;
  RemoteLocationModelCopyWith<$R, RemoteLocationModel, RemoteLocationModel>
      get remoteLocationData;
  CoordinatesCopyWith<$R, Coordinates, Coordinates>? get coordinates;
  SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>?
      get searchSuggestion;
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get errorModel;
  $R call(
      {LocationStatus? status,
      List<SearchSuggestion>? searchHistory,
      List<SearchSuggestion>? currentSearchList,
      LocationModel? data,
      RemoteLocationModel? remoteLocationData,
      Coordinates? coordinates,
      bool? searchIsLocal,
      String? languageCode,
      String? countryCode,
      SearchSuggestion? searchSuggestion,
      ErrorModel? errorModel,
      DateTime? lastUpdated});
  LocationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocationState, $Out>
    implements LocationStateCopyWith<$R, LocationState, $Out> {
  _LocationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocationState> $mapper =
      LocationStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SearchSuggestion,
          SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>>
      get searchHistory => ListCopyWith($value.searchHistory,
          (v, t) => v.copyWith.$chain(t), (v) => call(searchHistory: v));
  @override
  ListCopyWith<$R, SearchSuggestion,
          SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>>
      get currentSearchList => ListCopyWith($value.currentSearchList,
          (v, t) => v.copyWith.$chain(t), (v) => call(currentSearchList: v));
  @override
  LocationModelCopyWith<$R, LocationModel, LocationModel> get data =>
      $value.data.copyWith.$chain((v) => call(data: v));
  @override
  RemoteLocationModelCopyWith<$R, RemoteLocationModel, RemoteLocationModel>
      get remoteLocationData => $value.remoteLocationData.copyWith
          .$chain((v) => call(remoteLocationData: v));
  @override
  CoordinatesCopyWith<$R, Coordinates, Coordinates>? get coordinates =>
      $value.coordinates?.copyWith.$chain((v) => call(coordinates: v));
  @override
  SearchSuggestionCopyWith<$R, SearchSuggestion, SearchSuggestion>?
      get searchSuggestion => $value.searchSuggestion?.copyWith
          .$chain((v) => call(searchSuggestion: v));
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get errorModel =>
      $value.errorModel?.copyWith.$chain((v) => call(errorModel: v));
  @override
  $R call(
          {LocationStatus? status,
          List<SearchSuggestion>? searchHistory,
          List<SearchSuggestion>? currentSearchList,
          LocationModel? data,
          RemoteLocationModel? remoteLocationData,
          Object? coordinates = $none,
          bool? searchIsLocal,
          Object? languageCode = $none,
          Object? countryCode = $none,
          Object? searchSuggestion = $none,
          Object? errorModel = $none,
          Object? lastUpdated = $none}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (searchHistory != null) #searchHistory: searchHistory,
        if (currentSearchList != null) #currentSearchList: currentSearchList,
        if (data != null) #data: data,
        if (remoteLocationData != null) #remoteLocationData: remoteLocationData,
        if (coordinates != $none) #coordinates: coordinates,
        if (searchIsLocal != null) #searchIsLocal: searchIsLocal,
        if (languageCode != $none) #languageCode: languageCode,
        if (countryCode != $none) #countryCode: countryCode,
        if (searchSuggestion != $none) #searchSuggestion: searchSuggestion,
        if (errorModel != $none) #errorModel: errorModel,
        if (lastUpdated != $none) #lastUpdated: lastUpdated
      }));
  @override
  LocationState $make(CopyWithData data) => LocationState(
      status: data.get(#status, or: $value.status),
      searchHistory: data.get(#searchHistory, or: $value.searchHistory),
      currentSearchList:
          data.get(#currentSearchList, or: $value.currentSearchList),
      data: data.get(#data, or: $value.data),
      remoteLocationData:
          data.get(#remoteLocationData, or: $value.remoteLocationData),
      coordinates: data.get(#coordinates, or: $value.coordinates),
      searchIsLocal: data.get(#searchIsLocal, or: $value.searchIsLocal),
      languageCode: data.get(#languageCode, or: $value.languageCode),
      countryCode: data.get(#countryCode, or: $value.countryCode),
      searchSuggestion:
          data.get(#searchSuggestion, or: $value.searchSuggestion),
      errorModel: data.get(#errorModel, or: $value.errorModel),
      lastUpdated: data.get(#lastUpdated, or: $value.lastUpdated));

  @override
  LocationStateCopyWith<$R2, LocationState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocationStateCopyWithImpl($value, $cast, t);
}
