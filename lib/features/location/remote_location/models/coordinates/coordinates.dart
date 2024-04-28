// ignore_for_file: sort_constructors_first
import 'package:dart_mappable/dart_mappable.dart';
import 'package:geolocator/geolocator.dart';

part 'coordinates.mapper.dart';

@MappableClass()
class Coordinates with CoordinatesMappable {
  const Coordinates({
    required this.lat,
    required this.long,
  });

  final double lat;
  final double long;

  factory Coordinates.fromPosition(Position position) {
    return Coordinates(
      lat: position.latitude,
      long: position.longitude,
    );
  }
}
