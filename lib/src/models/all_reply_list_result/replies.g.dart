// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Replies _$RepliesFromJson(Map<String, dynamic> json) => Replies(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
      'items': instance.items,
      'pagination': instance.pagination,
    };
