import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_classes.dart';

void initHydratedStorage() {
  final storage = MockHydratedStorage();
  HydratedBloc.storage = storage;
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
}
