// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchSuggestionImpl _$$SearchSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchSuggestionImpl(
      placeId: json['placeId'] as String,
      description: json['description'] as String,
      searchTextList: (json['searchTextList'] as List<dynamic>?)
          ?.map((e) => SearchText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchSuggestionImplToJson(
        _$SearchSuggestionImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'description': instance.description,
      'searchTextList': instance.searchTextList,
    };
