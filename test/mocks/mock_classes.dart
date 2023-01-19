import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageController with Mock implements StorageController {}

class MockHydratedStorage extends Mock implements Storage {}

class MockFileController with Mock implements FileController {}

class MockBuildContext extends Mock implements BuildContext {}

class MockWeatherRepo with Mock implements WeatherRepository {}

class MockLocationRepo with Mock implements LocationRepository {}
