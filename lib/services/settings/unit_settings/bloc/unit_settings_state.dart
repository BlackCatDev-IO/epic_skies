part of 'unit_settings_bloc.dart';

class UnitSettingsState extends Equatable {
  const UnitSettingsState({required this.unitSettings});

  final UnitSettings unitSettings;

  @override
  List<Object> get props => [unitSettings];

  UnitSettingsState copyWith({
    required UnitSettings unitSettings,
  }) {
    return UnitSettingsState(
      unitSettings: unitSettings,
    );
  }
}
