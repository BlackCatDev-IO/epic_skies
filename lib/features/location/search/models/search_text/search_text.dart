import 'package:dart_mappable/dart_mappable.dart';

part 'search_text.mapper.dart';

@MappableClass()
class SearchText with SearchTextMappable {
  const SearchText({
    required this.text,
    required this.isBold,
  });

  final String text;
  final bool isBold;

  static const fromMap = SearchTextMapper.fromMap;
}
