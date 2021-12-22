class SearchText {
  final String text;
  final bool isBold;

  SearchText({
    required this.isBold,
    required this.text,
  });

  @override
  String toString() {
    return 'SearchText(text: $text, isBold: $isBold)';
  }
}
