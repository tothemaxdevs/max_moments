// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_comment_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCommentListResult _$AllCommentListResultFromJson(
        Map<String, dynamic> json) =>
    AllCommentListResult(
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllCommentListResultToJson(
        AllCommentListResult instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'pagination': instance.pagination,
    };
