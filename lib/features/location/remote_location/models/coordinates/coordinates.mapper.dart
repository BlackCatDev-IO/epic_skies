// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'coordinates.dart';

class CoordinatesMapper extends ClassMapperBase<Coordinates> {
  CoordinatesMapper._();

  static CoordinatesMapper? _instance;
  static CoordinatesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CoordinatesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Coordinates';

  static double _$lat(Coordinates v) => v.lat;
  static const Field<Coordinates, double> _f$lat = Field('lat', _$lat);
  static double _$long(Coordinates v) => v.long;
  static const Field<Coordinates, double> _f$long = Field('long', _$long);

  @override
  final MappableFields<Coordinates> fields = const {
    #lat: _f$lat,
    #long: _f$long,
  };

  static Coordinates _instantiate(DecodingData data) {
    return Coordinates(lat: data.dec(_f$lat), long: data.dec(_f$long));
  }

  @override
  final Function instantiate = _instantiate;

  static Coordinates fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Coordinates>(map);
  }

  static Coordinates fromJson(String json) {
    return ensureInitialized().decodeJson<Coordinates>(json);
  }
}

mixin CoordinatesMappable {
  String toJson() {
    return CoordinatesMapper.ensureInitialized()
        .encodeJson<Coordinates>(this as Coordinates);
  }

  Map<String, dynamic> toMap() {
    return CoordinatesMapper.ensureInitialized()
        .encodeMap<Coordinates>(this as Coordinates);
  }

  CoordinatesCopyWith<Coordinates, Coordinates, Coordinates> get copyWith =>
      _CoordinatesCopyWithImpl(this as Coordinates, $identity, $identity);
  @override
  String toString() {
    return CoordinatesMapper.ensureInitialized()
        .stringifyValue(this as Coordinates);
  }

  @override
  bool operator ==(Object other) {
    return CoordinatesMapper.ensureInitialized()
        .equalsValue(this as Coordinates, other);
  }

  @override
  int get hashCode {
    return CoordinatesMapper.ensureInitialized().hashValue(this as Coordinates);
  }
}

extension CoordinatesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Coordinates, $Out> {
  CoordinatesCopyWith<$R, Coordinates, $Out> get $asCoordinates =>
      $base.as((v, t, t2) => _CoordinatesCopyWithImpl(v, t, t2));
}

abstract class CoordinatesCopyWith<$R, $In extends Coordinates, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? lat, double? long});
  CoordinatesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CoordinatesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Coordinates, $Out>
    implements CoordinatesCopyWith<$R, Coordinates, $Out> {
  _CoordinatesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Coordinates> $mapper =
      CoordinatesMapper.ensureInitialized();
  @override
  $R call({double? lat, double? long}) => $apply(FieldCopyWithData(
      {if (lat != null) #lat: lat, if (long != null) #long: long}));
  @override
  Coordinates $make(CopyWithData data) => Coordinates(
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long));

  @override
  CoordinatesCopyWith<$R2, Coordinates, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CoordinatesCopyWithImpl($value, $cast, t);
}
