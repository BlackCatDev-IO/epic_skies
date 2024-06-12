import 'package:flutter/material.dart';

extension StringExtension on String {
  String get capitalizeFirst {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach =>
      split(' ').map((str) => str.inCaps).join(' ');

  String get capitalizeFirstWord => split(' ').map((str) => str).join(' ');

  bool get hasNumber => _hasNumber(this);

  bool _hasNumber(String str) {
    var hasNumber = false;
    for (final char in str.characters) {
      if (_numeric.hasMatch(char)) {
        hasNumber = true;
      }
    }
    return hasNumber;
  }

  List<String> splitWordList() {
    final wordList = <String>[];
    for (final word in split(' ')) {
      wordList.add(word);
    }
    return wordList;
  }
}

final _numeric = RegExp(r'^-?[0-9]+$');
