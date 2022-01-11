import 'package:equatable/equatable.dart';

class SearchText extends Equatable{
  final String text;
  final bool isBold;

 const SearchText({
    required this.isBold,
    required this.text,
  });

  @override
  String toString() {
    return 'SearchText(text: $text, isBold: $isBold)';
  }

  @override
  List<Object?> get props => [text, isBold];
}
