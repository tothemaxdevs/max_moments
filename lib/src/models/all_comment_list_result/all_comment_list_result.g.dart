// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_comment_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCommentListResult _$AllCommentListResultFromJson(
        Map<String, dynamic> json) =>
    AllCommentListResult(
      comments: json['comments'] == null
          ? null
          : Comments.fromJson(json['comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllCommentListResultToJson(
        AllCommentListResult instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };
