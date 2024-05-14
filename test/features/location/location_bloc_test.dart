import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/locale/locale_repository.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/init_hydrated_storage.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockLocaleRepository extends Mock implements LocaleRepository {}

void main() {
  late LocationRepository weatherRepository;
  late LocaleRepository localeRepository;
  late LocationModel locationModel;

  setUpAll(() {
    initHydratedStorage();
    weatherRepository = MockLocationRepository();
    localeRepository = MockLocaleRepository();
    locationModel = const LocationModel(
      subLocality: 'City',
      administrativeArea: 'State',
      country: 'Country',
    );
  });

  group('LocationBloc', () {
    blocTest<LocationBloc, LocationState>(
      'Emits success with backup api on PlatformException',
      setUp: () {
        when(() => localeRepository.getLocale()).thenAnswer(
          (_) async => const Locale('en'),
        );
        when(() => weatherRepository.getCurrentPosition()).thenAnswer(
          (_) async => const Coordinates(lat: 0, long: 0),
        );

        when(
          () => weatherRepository.getPlacemarksFromCoordinates(
            coordinates: const Coordinates(lat: 0, long: 0),
          ),
        ).thenThrow(
          PlatformException(
            code: 'ERROR',
            message: 'Error',
          ),
        );

        when(
          () => weatherRepository.getLocationDetailsFromBackupAPI(
            lat: 0,
            long: 0,
          ),
        ).thenAnswer(
          (_) async => locationModel,
        );
      },
      build: () => LocationBloc(
        locationRepository: weatherRepository,
        localeRepository: localeRepository,
      ),
      act: (bloc) => bloc.add(LocationUpdateLocal()),
      expect: () => <LocationState>[
        const LocationState(
          status: LocationStatus.loading,
        ),
        LocationState(
          status: LocationStatus.success,
          localData: locationModel,
        ),
      ],
    );
  });
}
