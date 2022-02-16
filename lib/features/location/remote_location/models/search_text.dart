import 'dart:convert';

import 'package:equatable/equatable.dart';

class SearchText extends Equatable {
  final String text;
  final bool isBold;

  const SearchText({
    required this.isBold,
    required this.text,
  });

  String toRawJson() => jsonEncode({'text': text, 'isBold': isBold});

  factory SearchText.fromRawJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return SearchText(
      text: map['text'] as String,
      isBold: map['isBold'] as bool,
    );
  }

  @override
  String toString() {
    return 'SearchText(text: $text, isBold: $isBold)';
  }

  @override
  List<Object?> get props => [text, isBold];
}
