// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location_model.dart';

class LocationModelMapper extends ClassMapperBase<LocationModel> {
  LocationModelMapper._();

  static LocationModelMapper? _instance;
  static LocationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocationModel';

  static String _$subLocality(LocationModel v) => v.subLocality;
  static const Field<LocationModel, String> _f$subLocality =
      Field('subLocality', _$subLocality, opt: true, def: '');
  static String _$administrativeArea(LocationModel v) => v.administrativeArea;
  static const Field<LocationModel, String> _f$administrativeArea =
      Field('administrativeArea', _$administrativeArea, opt: true, def: '');
  static String _$country(LocationModel v) => v.country;
  static const Field<LocationModel, String> _f$country =
      Field('country', _$country, opt: true, def: '');
  static List<String>? _$longNameList(LocationModel v) => v.longNameList;
  static const Field<LocationModel, List<String>> _f$longNameList =
      Field('longNameList', _$longNameList, opt: true);

  @override
  final MappableFields<LocationModel> fields = const {
    #subLocality: _f$subLocality,
    #administrativeArea: _f$administrativeArea,
    #country: _f$country,
    #longNameList: _f$longNameList,
  };

  static LocationModel _instantiate(DecodingData data) {
    return LocationModel(
        subLocality: data.dec(_f$subLocality),
        administrativeArea: data.dec(_f$administrativeArea),
        country: data.dec(_f$country),
        longNameList: data.dec(_f$longNameList));
  }

  @override
  final Function instantiate = _instantiate;

  static LocationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocationModel>(map);
  }

  static LocationModel fromJson(String json) {
    return ensureInitialized().decodeJson<LocationModel>(json);
  }
}

mixin LocationModelMappable {
  String toJson() {
    return LocationModelMapper.ensureInitialized()
        .encodeJson<LocationModel>(this as LocationModel);
  }

  Map<String, dynamic> toMap() {
    return LocationModelMapper.ensureInitialized()
        .encodeMap<LocationModel>(this as LocationModel);
  }

  LocationModelCopyWith<LocationModel, LocationModel, LocationModel>
      get copyWith => _LocationModelCopyWithImpl(
          this as LocationModel, $identity, $identity);
  @override
  String toString() {
    return LocationModelMapper.ensureInitialized()
        .stringifyValue(this as LocationModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            LocationModelMapper.ensureInitialized()
                .isValueEqual(this as LocationModel, other));
  }

  @override
  int get hashCode {
    return LocationModelMapper.ensureInitialized()
        .hashValue(this as LocationModel);
  }
}

extension LocationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocationModel, $Out> {
  LocationModelCopyWith<$R, LocationModel, $Out> get $asLocationModel =>
      $base.as((v, t, t2) => _LocationModelCopyWithImpl(v, t, t2));
}

abstract class LocationModelCopyWith<$R, $In extends LocationModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get longNameList;
  $R call(
      {String? subLocality,
      String? administrativeArea,
      String? country,
      List<String>? longNameList});
  LocationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocationModel, $Out>
    implements LocationModelCopyWith<$R, LocationModel, $Out> {
  _LocationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocationModel> $mapper =
      LocationModelMapper.ensureInitialized();
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
          {String? subLocality,
          String? administrativeArea,
          String? country,
          Object? longNameList = $none}) =>
      $apply(FieldCopyWithData({
        if (subLocality != null) #subLocality: subLocality,
        if (administrativeArea != null) #administrativeArea: administrativeArea,
        if (country != null) #country: country,
        if (longNameList != $none) #longNameList: longNameList
      }));
  @override
  LocationModel $make(CopyWithData data) => LocationModel(
      subLocality: data.get(#subLocality, or: $value.subLocality),
      administrativeArea:
          data.get(#administrativeArea, or: $value.administrativeArea),
      country: data.get(#country, or: $value.country),
      longNameList: data.get(#longNameList, or: $value.longNameList));

  @override
  LocationModelCopyWith<$R2, LocationModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocationModelCopyWithImpl($value, $cast, t);
}
