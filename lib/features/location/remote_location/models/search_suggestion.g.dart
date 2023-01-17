// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'search_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchSuggestion _$$_SearchSuggestionFromJson(Map<String, dynamic> json) =>
    _$_SearchSuggestion(
      placeId: json['placeId'] as String,
      description: json['description'] as String,
      searchTextList: (json['searchTextList'] as List<dynamic>?)
          ?.map((e) => SearchText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SearchSuggestionToJson(_$_SearchSuggestion instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'description': instance.description,
      'searchTextList': instance.searchTextList,
    };
