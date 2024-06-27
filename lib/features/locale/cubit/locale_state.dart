// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.mapper.dart';

class LocaleState extends Equatable {
  const LocaleState({
    this.deviceLocale = const Locale('en', 'US'),
    this.userSetLocale,
  });

  /// The locale of the device according to user device settings
  final Locale deviceLocale;

  /// Only different from [deviceLocale] if the user has set a different language in the app
  final Locale? userSetLocale;

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
  }) {
    return LocaleState(
      deviceLocale: deviceLocale ?? this.deviceLocale,
      userSetLocale: userSetLocale ?? this.userSetLocale,
    );
  }

  @override
  List<Object?> get props => [
        deviceLocale,
        userSetLocale,
      ];
}

extension LocaleExtension on Locale {
  Map<String, String?> get toMap => {
        'languageCode': languageCode,
        'countryCode': countryCode,
      };
}
