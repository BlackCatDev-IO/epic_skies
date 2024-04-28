part of 'app_update_bloc.dart';

abstract class AppUpdateEvent {}

/// Runs on app start to check if the app has been updated
class AppInitInfoOnAppStart extends AppUpdateEvent {
  AppInitInfoOnAppStart({
    required this.minorVersionLowThreshold,
    required this.minorVersionHighThreshold,
  });

  /// If current minor version is <= this number, it meets 1 of the 2 conditions
  final int minorVersionLowThreshold;

  /// If updated minor version is >= this number, it meets the other 1 of the 2
  /// conditions
  final int minorVersionHighThreshold;

  @override
  String toString() => 'AppInitInfoOnAppStart';
}
