// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentResult _$PostCommentResultFromJson(Map<String, dynamic> json) =>
    PostCommentResult(
      comment: json['comment'] == null
          ? null
          : Comment.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostCommentResultToJson(PostCommentResult instance) =>
    <String, dynamic>{
      'comment': instance.comment,
    };
