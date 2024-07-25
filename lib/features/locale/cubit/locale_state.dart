// ignore_for_file: sort_constructors_first

part of 'locale_cubit.dart';

enum CountryUnitSettings {
  metric,
  imperial;

  bool get isMetric => this == CountryUnitSettings.metric;
  bool get isImperial => this == CountryUnitSettings.imperial;
}

class LocaleState extends Equatable {
  const LocaleState({
    this.deviceLocale = const Locale('en', 'US'),
    this.countryUnitSettings = CountryUnitSettings.imperial,
    this.userSetLocale,
  });

  /// The locale of the device according to user device settings
  final Locale deviceLocale;

  /// Only different from [deviceLocale] if the user has set a different language in the app
  final Locale? userSetLocale;

  final CountryUnitSettings countryUnitSettings;

  factory LocaleState.fromMap(Map<String, dynamic> map) {
    return LocaleState(
      deviceLocale: localeFromMap(map['deviceLocale'] as Map<String, dynamic>),
      userSetLocale:
          localeFromMap(map['userSetLocale'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceLocale': deviceLocale.toMap,
      'userSetLocale': userSetLocale?.toMap,
    };
  }

  static Locale localeFromMap(Map<String, dynamic> map) => Locale(
        map['languageCode'] as String? ?? 'en',
        map['countryCode'] as String?,
      );

  LocaleState copyWith({
    Locale? deviceLocale,
    Locale? userSetLocale,
    CountryUnitSettings? countryUnitSettings,
  }) {
    return LocaleState(
      deviceLocale: deviceLocale ?? this.deviceLocale,
      userSetLocale: userSetLocale ?? this.userSetLocale,
      countryUnitSettings: countryUnitSettings ?? this.countryUnitSettings,
    );
  }

  @override
  List<Object?> get props => [
        deviceLocale,
        userSetLocale,
        countryUnitSettings,
      ];
}

extension LocaleExtension on Locale {
  Map<String, String?> get toMap => {
        'languageCode': languageCode,
        'countryCode': countryCode,
      };
}
