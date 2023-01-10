import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppNotifyLoading>((event, emit) {
      emit(AppLoading());
    });

    on<AppNotifySuccess>((event, emit) {
      emit(AppSuccess());
    });
  }
}
