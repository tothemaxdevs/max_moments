// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_reply_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllReplyListResult _$AllReplyListResultFromJson(Map<String, dynamic> json) =>
    AllReplyListResult(
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllReplyListResultToJson(AllReplyListResult instance) =>
    <String, dynamic>{
      'replies': instance.replies,
      'pagination': instance.pagination,
    };
