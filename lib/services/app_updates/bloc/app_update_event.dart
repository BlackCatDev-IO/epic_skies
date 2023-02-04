part of 'app_update_bloc.dart';

/// base event class that all other classes extent
abstract class AppUpdateEvent {}


/// Runs on 
class AppInitInfoOnAppStart extends AppUpdateEvent {
  AppInitInfoOnAppStart({
    required this.isNewInstall,
  });

  final bool isNewInstall;
}
