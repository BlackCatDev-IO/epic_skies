import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';

part 'coordinates.freezed.dart';

part 'coordinates.g.dart';

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({
    required double lat,
    required double long,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, Object?> json) =>
      _$CoordinatesFromJson(json);

  factory Coordinates.fromPosition(LocationData position) {
    return Coordinates(
      lat: position.latitude!,
      long: position.longitude!,
    );
  }
}
