import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_text.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'search_text.g.dart';


@freezed
class SearchText with _$SearchText {
  const factory SearchText({
    required String text,
    required bool isBold,
  }) = _SearchText;

  factory SearchText.fromJson(Map<String, Object?> json) =>
      _$SearchTextFromJson(json);
}
