// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'remote_location_model.dart';

class RemoteLocationModelMapper extends ClassMapperBase<RemoteLocationModel> {
  RemoteLocationModelMapper._();

  static RemoteLocationModelMapper? _instance;
  static RemoteLocationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteLocationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteLocationModel';

  static double _$remoteLat(RemoteLocationModel v) => v.remoteLat;
  static const Field<RemoteLocationModel, double> _f$remoteLat =
      Field('remoteLat', _$remoteLat, opt: true, def: 0.0);
  static double _$remoteLong(RemoteLocationModel v) => v.remoteLong;
  static const Field<RemoteLocationModel, double> _f$remoteLong =
      Field('remoteLong', _$remoteLong, opt: true, def: 0.0);
  static String _$city(RemoteLocationModel v) => v.city;
  static const Field<RemoteLocationModel, String> _f$city =
      Field('city', _$city, opt: true, def: '');
  static String _$state(RemoteLocationModel v) => v.state;
  static const Field<RemoteLocationModel, String> _f$state =
      Field('state', _$state, opt: true, def: '');
  static String _$country(RemoteLocationModel v) => v.country;
  static const Field<RemoteLocationModel, String> _f$country =
      Field('country', _$country, opt: true, def: '');
  static List<String>? _$longNameList(RemoteLocationModel v) => v.longNameList;
  static const Field<RemoteLocationModel, List<String>> _f$longNameList =
      Field('longNameList', _$longNameList, opt: true);

  @override
  final MappableFields<RemoteLocationModel> fields = const {
    #remoteLat: _f$remoteLat,
    #remoteLong: _f$remoteLong,
    #city: _f$city,
    #state: _f$state,
    #country: _f$country,
    #longNameList: _f$longNameList,
  };

  static RemoteLocationModel _instantiate(DecodingData data) {
    return RemoteLocationModel(
        remoteLat: data.dec(_f$remoteLat),
        remoteLong: data.dec(_f$remoteLong),
        city: data.dec(_f$city),
        state: data.dec(_f$state),
        country: data.dec(_f$country),
        longNameList: data.dec(_f$longNameList));
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteLocationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteLocationModel>(map);
  }

  static RemoteLocationModel fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteLocationModel>(json);
  }
}

mixin RemoteLocationModelMappable {
  String toJson() {
    return RemoteLocationModelMapper.ensureInitialized()
        .encodeJson<RemoteLocationModel>(this as RemoteLocationModel);
  }

  Map<String, dynamic> toMap() {
    return RemoteLocationModelMapper.ensureInitialized()
        .encodeMap<RemoteLocationModel>(this as RemoteLocationModel);
  }

  RemoteLocationModelCopyWith<RemoteLocationModel, RemoteLocationModel,
          RemoteLocationModel>
      get copyWith => _RemoteLocationModelCopyWithImpl(
          this as RemoteLocationModel, $identity, $identity);
  @override
  String toString() {
    return RemoteLocationModelMapper.ensureInitialized()
        .stringifyValue(this as RemoteLocationModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RemoteLocationModelMapper.ensureInitialized()
                .isValueEqual(this as RemoteLocationModel, other));
  }

  @override
  int get hashCode {
    return RemoteLocationModelMapper.ensureInitialized()
        .hashValue(this as RemoteLocationModel);
  }
}

extension RemoteLocationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteLocationModel, $Out> {
  RemoteLocationModelCopyWith<$R, RemoteLocationModel, $Out>
      get $asRemoteLocationModel =>
          $base.as((v, t, t2) => _RemoteLocationModelCopyWithImpl(v, t, t2));
}

abstract class RemoteLocationModelCopyWith<$R, $In extends RemoteLocationModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get longNameList;
  $R call(
      {double? remoteLat,
      double? remoteLong,
      String? city,
      String? state,
      String? country,
      List<String>? longNameList});
  RemoteLocationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RemoteLocationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteLocationModel, $Out>
    implements RemoteLocationModelCopyWith<$R, RemoteLocationModel, $Out> {
  _RemoteLocationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteLocationModel> $mapper =
      RemoteLocationModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get longNameList => $value.longNameList != null
          ? ListCopyWith(
              $value.longNameList!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(longNameList: v))
          : null;
  @override
  $R call(
          {double? remoteLat,
          double? remoteLong,
          String? city,
          String? state,
          String? country,
          Object? longNameList = $none}) =>
      $apply(FieldCopyWithData({
        if (remoteLat != null) #remoteLat: remoteLat,
        if (remoteLong != null) #remoteLong: remoteLong,
        if (city != null) #city: city,
        if (state != null) #state: state,
        if (country != null) #country: country,
        if (longNameList != $none) #longNameList: longNameList
      }));
  @override
  RemoteLocationModel $make(CopyWithData data) => RemoteLocationModel(
      remoteLat: data.get(#remoteLat, or: $value.remoteLat),
      remoteLong: data.get(#remoteLong, or: $value.remoteLong),
      city: data.get(#city, or: $value.city),
      state: data.get(#state, or: $value.state),
      country: data.get(#country, or: $value.country),
      longNameList: data.get(#longNameList, or: $value.longNameList));

  @override
  RemoteLocationModelCopyWith<$R2, RemoteLocationModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _RemoteLocationModelCopyWithImpl($value, $cast, t);
}
